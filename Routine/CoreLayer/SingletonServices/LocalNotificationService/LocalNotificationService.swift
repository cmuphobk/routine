import Foundation
import DateToolsSwift
import UserNotifications
import Firebase
import FirebaseMessaging

struct DateForNotification {
    
    let model: MedicineDrug
    let timestamp: Int
    let dose: Double
    
}

private let dayLength = 60 * 60 * 24 * 1000

final class LocalNotificationService: NSObject {
    
    var storageService: StorageServiceInterface!
    
    static let shared = LocalNotificationService()
    
    private let center: UNUserNotificationCenter
    
    private var application: UIApplication!
    
    private let maxRequestsCount = 64
    private let poolNotificationsString = "kPoolNotifications"
    
    private override init() {
        
        self.center = UNUserNotificationCenter.current()
        
        super.init()
        
        self.center.delegate = self
        //Configure FirebaseApp
        FirebaseApp.configure()
        
        Messaging.messaging().delegate = self
        Messaging.messaging().shouldEstablishDirectChannel = true
        
        self.recreateNotifications()
        
    }
    
}

// MARK: LocalNotificationServiceInterface
extension LocalNotificationService: LocalNotificationServiceInterface {
    
    func configure(application: UIApplication) {
        
        self.application = application
        
        //Configure push notifications
        if #available(iOS 10.0, *) {
            
            // For iOS 10 display notification (sent via APNS)
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            
            self.center.requestAuthorization(options: authOptions) {_, _ in }
        } else {
            
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            self.application.registerUserNotificationSettings(settings)
        }
        
        self.application.registerForRemoteNotifications()
        
    }
    
    func createNotifications(_ courses: [MedicineCourse]) {
        
        let dates = self.obtainDatesNotificationsFromCourses(courses)
        
        let notifications: [MedicineLocalNotification] = dates.map { (timestamp) -> MedicineLocalNotification in
            
            let body = "\(timestamp.model.name)\n\(timestamp.dose) \(timestamp.model.unit.pluralsStringFor(count: Int(timestamp.dose), localizeService: AppDelegate.serviceProvider.makeStringService()))"
            
            let objectId = timestamp.model.objectId ?? ""
            
            let needAcceptPill = AppDelegate.serviceProvider.makeStringService().localizeId("need_to_accept_a_pill")
            
            return MedicineLocalNotification(name: "\(objectId)_\(timestamp)_notification", timestamp: timestamp.timestamp, categoryIdentifier: objectId, title: needAcceptPill, body: body)
        }
        
        self.removeAllNotifications()
        
        
        var index = 0
        var poolNotifications: [MedicineLocalNotification] = []
        for notification in notifications {
            index += 1
            if index > self.maxRequestsCount {
                poolNotifications.append(notification)
            } else {
                self.configure(notification: notification)
            }
        }
        
        self.savePoolNotifications(poolNotifications: poolNotifications)
        
    }
    
    func removeAllNotifications() {
        
        self.center.removeAllPendingNotificationRequests()
        self.center.removeAllDeliveredNotifications()

    }
    
    func obtainDatesNotificationsFromCourses(_ courses: [MedicineCourse]) -> [DateForNotification] {
        
        var dates: [DateForNotification] = []
        
        for course in courses {
            if let drugs = course.drugs {
                for model in drugs {
                    dates.append(contentsOf: self.obtainDatesNotificationsFromDrugsModel(model))
                }
            }
        }
        
        dates = dates.filter { (date) -> Bool in
            return date.timestamp >= Int(Date().timeIntervalSince1970 * 1000.0)
        }
        
        dates.sort { (date1, date2) -> Bool in
            return date1.timestamp < date2.timestamp
        }
        
        return dates
        
    }
    
    
    func obtainDatesNotificationsFromDrugsModel(_ model: MedicineDrug) -> [DateForNotification] {
        
        var arrayDates: [DateForNotification] = []
        
        let startDate = model.startDate
        let times = model.times
        
        if model.periodCourseType == .countDays && model.endingCourseType == .countUsageNumber {
            
            arrayDates = self.obtainTimesForPeriod(model.periodCourseValue, andStartDate: startDate, andCountUsageNumber: model.endingCourseValue, andTimes: times, model: model)
            
        } else if model.periodCourseType == .countDays && model.endingCourseType == .countUsageDays {
            
            arrayDates = self.obtainTimesForPeriod(model.periodCourseValue, andStartDate: startDate, andCountUsageDays: model.endingCourseValue, andTimes: times, model: model)
            
        } else if model.periodCourseType == .countDays && model.endingCourseType == .endUsageDate {
            
            arrayDates = self.obtainTimesForPeriod(model.periodCourseValue, andStartDate: startDate, andEndUsageDate: model.endingCourseValue, andTimes: times, model: model)
            
        } else if model.periodCourseType == .weekDays && model.endingCourseType == .countUsageNumber {
            
            arrayDates = self.obtainTimesForPeriodDays(model.periodCourseValue, andStartDate: startDate, andCountUsageNumber: model.endingCourseValue, andTimes: times, model: model)
            
        } else if model.periodCourseType == .weekDays && model.endingCourseType == .countUsageDays {
            
            arrayDates = self.obtainTimesForPeriodDays(model.periodCourseValue, andStartDate: startDate, andCountUsageDays: model.endingCourseValue, andTimes: times, model: model)
            
        } else if model.periodCourseType == .weekDays && model.endingCourseType == .endUsageDate {
            
            arrayDates = self.obtainTimesForPeriodDays(model.periodCourseValue, andStartDate: startDate, andEndUsageDate: model.endingCourseValue, andTimes: times, model: model)
            
        }
        
        arrayDates = arrayDates.filter { (date) -> Bool in
            return date.timestamp >= Int(Date().timeIntervalSince1970 * 1000.0)
        }
        
        arrayDates.sort { (date1, date2) -> Bool in
            return date1.timestamp < date2.timestamp
        }
        
        return arrayDates
    }
}

// MARK: MessagingDelegate
extension LocalNotificationService {
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        messaging.subscribe(toTopic: "test_topic")
    }
    
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        print("Firebase message: \(remoteMessage.appData)")
    }
    
}

// MARK: - UNUserNotificationCenterDelegate
extension LocalNotificationService {
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("RegisterForRemoteNotificationsWithDeviceToken")
    }
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any]) {
        print("Firebase push message: \(userInfo)")
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        self.recreateNotifications()
        
        completionHandler([.alert, .sound, .badge])
        
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        default:
            print("Unknown action")
        }
        
        self.recreateNotifications()
        
        completionHandler()
    }
    
}

// MARK: Private
extension LocalNotificationService {
    
    private func recreateNotifications() {
    
        self.center.getPendingNotificationRequests { [unowned self] (requests) in
            
            let count = self.maxRequestsCount - requests.count
            var array = self.obtainPoolNotifications()
            
            for index in 0..<count where array.count > index {
                let item = array[index]
                self.configure(notification: item)
                array.remove(at: index)
            }
            self.savePoolNotifications(poolNotifications: array)
            
            print("\(String(describing: requests))")
        }
    
    }
    
    private func obtainPoolNotifications() -> [MedicineLocalNotification] {
        
        guard let poolNotificationsData = self.storageService.object(forKey: self.poolNotificationsString) as? Data, let poolNotifications = try? JSONDecoder().decode([MedicineLocalNotification].self, from: poolNotificationsData) else { return [] }
        
        return poolNotifications
    }
    
    private func savePoolNotifications(poolNotifications: [MedicineLocalNotification]) {
        
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(poolNotifications) {
            self.storageService.set(encoded, forKey: self.poolNotificationsString)
        }
        
    }
    
    private func configure(notification: MedicineLocalNotification) {
        
        let identifier = notification.name
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = notification.categoryIdentifier
        content.sound = UNNotificationSound.default
        content.title = notification.title
        content.body = notification.body
        content.badge = NSNumber(value: 0)
        
        let date = Date(timeIntervalSince1970: Double(notification.timestamp / 1000))
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        self.center.add(request) { (error) in
            if let error = error {
                print("Unhandled error LocalNotificationService: \(String(describing: error))")
            }
        }
        
    }
    
    private func obtainTimesForPeriod(_ period: Int, andStartDate startDate: Int, andCountUsageNumber countUsageNumber: Int, andTimes times: [MedicineCourseTime], model: MedicineDrug) -> [DateForNotification] {
        
        var arrayDates: [DateForNotification] = []
        
        if countUsageNumber > 0 {
            
            var countUsageNumberVar = countUsageNumber
            
            for time in times {
                
                //добавляем прием
                if countUsageNumberVar > 0 {
                    
                    arrayDates.append(DateForNotification(model: model, timestamp: startDate + time.usageTime.rawValue(), dose: time.dose))
                    countUsageNumberVar -= 1
                    
                } else {
                
                    return arrayDates
                }
                
            }
            
            let newStartDate = startDate + (period * dayLength)
            //startDate += period day and call
            arrayDates += self.obtainTimesForPeriod(period, andStartDate: newStartDate, andCountUsageNumber: countUsageNumberVar, andTimes: times, model: model)
            
        }
        
        return arrayDates
        
    }
    
    private func obtainTimesForPeriod(_ period: Int, andStartDate startDate: Int, andCountUsageDays countUsageDays: Int, andTimes times: [MedicineCourseTime], model: MedicineDrug) -> [DateForNotification] {
        
        var arrayDates: [DateForNotification] = []
        
        if countUsageDays > 0 {
            
            var countUsageDaysVar = countUsageDays
            
            for time in times {
 
                arrayDates.append(DateForNotification(model: model, timestamp: startDate + time.usageTime.rawValue(), dose: time.dose))
                
            }
            
            countUsageDaysVar -= 1
            
            let newStartDate = startDate + (period * dayLength)
            //startDate += period day and call
            arrayDates += self.obtainTimesForPeriod(period, andStartDate: newStartDate, andCountUsageDays: countUsageDaysVar, andTimes: times, model: model)
            
        }
        
        return arrayDates
        
    }
    
    private func obtainTimesForPeriod(_ period: Int, andStartDate startDate: Int, andEndUsageDate endUsageDate: Int, andTimes times: [MedicineCourseTime], model: MedicineDrug) -> [DateForNotification] {
        
        var arrayDates: [DateForNotification] = []
        
        if startDate <= endUsageDate {
                        
            for time in times {
                
                if startDate + time.usageTime.rawValue() <= endUsageDate {
                    
                    arrayDates.append(DateForNotification(model: model, timestamp: startDate + time.usageTime.rawValue(), dose: time.dose))
                    
                }
                
            }
            
            let newStartDate = startDate + (period * dayLength)
            
            //startDate += period day and call
            arrayDates += self.obtainTimesForPeriod(period, andStartDate: newStartDate, andEndUsageDate: endUsageDate, andTimes: times, model: model)
            
        }
        
        return arrayDates
        
    }
    
    private func obtainTimesForPeriodDays(_ periodDays: Int, andStartDate startDate: Int, andCountUsageNumber countUsageNumber: Int, andTimes times: [MedicineCourseTime], model: MedicineDrug) -> [DateForNotification] {
        
        var arrayDates: [DateForNotification] = []
        
        let peroidDaysInt8 = UInt8(periodDays)
        let dayOfWeek = DayOfWeek.checkDateWeekDay(timestamp: startDate)
        guard let ifExist = dayOfWeek?.checkIfExist(peroidDaysInt8) else {
            return arrayDates
        }

        let newStartDate = startDate + dayLength
        var newCountUsageNumber = countUsageNumber
        
        //если startDate попала в periodDays вызываем получения дат в startDate
        if ifExist {
            let count = times.count <= countUsageNumber ? times.count : countUsageNumber
            arrayDates += self.obtainTimesForPeriod(1, andStartDate: startDate, andCountUsageNumber: count, andTimes: times, model: model)
            newCountUsageNumber -= times.count
        }

        //увеличиваем startDate на 1 день и рекурсивно вызываем себя
        
        if newCountUsageNumber > 0 {
            arrayDates += self.obtainTimesForPeriodDays(periodDays, andStartDate: newStartDate, andCountUsageNumber: newCountUsageNumber, andTimes: times, model: model)
        }
        return arrayDates

    }
    
    private func obtainTimesForPeriodDays(_ periodDays: Int, andStartDate startDate: Int, andCountUsageDays countUsageDays: Int, andTimes times: [MedicineCourseTime], model: MedicineDrug) -> [DateForNotification] {
        
        var arrayDates: [DateForNotification] = []
        
        let peroidDaysInt8 = UInt8(periodDays)
        let dayOfWeek = DayOfWeek.checkDateWeekDay(timestamp: startDate)
        guard let ifExist = dayOfWeek?.checkIfExist(peroidDaysInt8) else {
            return arrayDates
        }
        
        let newStartDate = startDate + dayLength
        var newCountUsageDays = countUsageDays
        
        //если startDate попала в periodDays вызываем получения дат в startDate
        if ifExist {
            arrayDates += self.obtainTimesForPeriod(1, andStartDate: startDate, andCountUsageDays: 1, andTimes: times, model: model)
            newCountUsageDays -= 1
        }
        
        if newCountUsageDays > 0 {
            arrayDates += self.obtainTimesForPeriodDays(periodDays, andStartDate: newStartDate, andCountUsageDays: newCountUsageDays, andTimes: times, model: model)
        }
        return arrayDates

    }
    
    private func obtainTimesForPeriodDays(_ periodDays: Int, andStartDate startDate: Int, andEndUsageDate endUsageDate: Int, andTimes times: [MedicineCourseTime], model: MedicineDrug) -> [DateForNotification] {
    
        var arrayDates: [DateForNotification] = []
        
        let peroidDaysInt8 = UInt8(periodDays)
        let dayOfWeek = DayOfWeek.checkDateWeekDay(timestamp: startDate)
        guard let ifExist = dayOfWeek?.checkIfExist(peroidDaysInt8) else {
            return arrayDates
        }
        
        let newStartDate = startDate + dayLength

        //если startDate попала в periodDays вызываем получения дат в startDate
        if ifExist {
            arrayDates += self.obtainTimesForPeriod(1, andStartDate: startDate, andCountUsageDays: 1, andTimes: times, model: model)
        }
        
        if newStartDate <= endUsageDate {
            arrayDates += self.obtainTimesForPeriodDays(periodDays, andStartDate: newStartDate, andEndUsageDate: endUsageDate, andTimes: times, model: model)
        }
        return arrayDates
        
    }
    
}
