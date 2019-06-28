import Foundation

import UserNotifications
import Firebase
import FirebaseMessaging
import HockeySDK

final class LocalNotificationService: NSObject {
    var storageService: StorageServiceInterface!
    private let center: UNUserNotificationCenter
    private var application: UIApplication!
    private(set) var maxRequestsCount = 64

    private let hockeyId = "3dfa3d93e3324d16a9c38ae59f42d063"

    override public init() {
        self.center = UNUserNotificationCenter.current()
        super.init()
        self.center.delegate = self
        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        Messaging.messaging().shouldEstablishDirectChannel = true

        BITHockeyManager.shared().configure(withIdentifier: self.hockeyId)
        BITHockeyManager.shared().isUpdateManagerDisabled = true
        BITHockeyManager.shared().start()
        BITHockeyManager.shared().authenticator.authenticateInstallation()
    }
}

// MARK: LocalNotificationServiceInterface
extension LocalNotificationService: LocalNotificationServiceInterface {

    func configure(application: UIApplication) {
        self.application = application
        if #available(iOS 10.0, *) {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            self.center.requestAuthorization(options: authOptions) {_, _ in }
        } else {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            self.application.registerUserNotificationSettings(settings)
        }
        self.application.registerForRemoteNotifications()
    }

    func createNotifications(model: NotificationsModel) {
        var dates: [DateForNotification] = self.obtainDatesNotifications(model: model)
        dates = dates.filter { (date) -> Bool in
            return date.timestamp >= Int(Date().timeIntervalSince1970 * 1000.0)
        }
        dates.sort { (date1, date2) -> Bool in
            return date1.timestamp < date2.timestamp
        }
        let notifications: [LocalNotification] = dates.map { (date) -> LocalNotification in
            return LocalNotification(
                name: "\(date.hashValue)_notification",
                timestamp: date.timestamp,
                categoryIdentifier: date.userInfo.description,
                title: date.userInfo.description)
        }
        self.removeAllNotifications()
        var index = 0
        var poolNotifications: [LocalNotification] = []
        for notification in notifications {
            index += 1
            if index > self.maxRequestsCount {
                poolNotifications.append(notification)
            } else {
                self.configure(notification: notification, center: self.center)
            }
        }
        self.savePoolNotifications(poolNotifications: poolNotifications)
    }

    func recreateNotifications() {
        self.recreateNotifications(center: self.center)
    }

    func removeAllNotifications() {
        self.center.removeAllPendingNotificationRequests()
        self.center.removeAllDeliveredNotifications()
    }

    func obtainDatesNotifications(model: NotificationsModel) -> [DateForNotification] {
        var arrayDates: [DateForNotification] = []
        if model.periodType == .countDays && model.endingType == .countUsageNumber {
            arrayDates = self.obtainTimesForPeriod(model.periodValue,
                                                   andStartDate: model.startDate,
                                                   andCountUsageNumber: model.endingValue,
                                                   andTimes: model.times,
                                                   userInfo: model.userInfo)
        } else if model.periodType == .countDays && model.endingType == .countUsageDays {
            arrayDates = self.obtainTimesForPeriod(model.periodValue,
                                                   andStartDate: model.startDate,
                                                   andCountUsageDays: model.endingValue,
                                                   andTimes: model.times,
                                                   userInfo: model.userInfo)
        } else if model.periodType == .countDays && model.endingType == .endUsageDate {
            arrayDates = self.obtainTimesForPeriod(model.periodValue,
                                                   andStartDate: model.startDate,
                                                   andEndUsageDate: model.endingValue,
                                                   andTimes: model.times,
                                                   userInfo: model.userInfo)
        } else if model.periodType == .weekDays && model.endingType == .countUsageNumber {
            arrayDates = self.obtainTimesForPeriodDays(model.periodValue,
                                                       andStartDate: model.startDate,
                                                       andCountUsageNumber: model.endingValue,
                                                       andTimes: model.times,
                                                       userInfo: model.userInfo)
        } else if model.periodType == .weekDays && model.endingType == .countUsageDays {
            arrayDates = self.obtainTimesForPeriodDays(model.periodValue,
                                                       andStartDate: model.startDate,
                                                       andCountUsageDays: model.endingValue,
                                                       andTimes: model.times,
                                                       userInfo: model.userInfo)
        } else if model.periodType == .weekDays && model.endingType == .endUsageDate {
            arrayDates = self.obtainTimesForPeriodDays(model.periodValue,
                                                       andStartDate: model.startDate,
                                                       andEndUsageDate: model.endingValue,
                                                       andTimes: model.times,
                                                       userInfo: model.userInfo)
        }
        arrayDates = arrayDates.filter { $0.timestamp >= Int(Date().timeIntervalSince1970 * 1000.0)}
        arrayDates.sort { $0.timestamp < $1.timestamp }
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

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler:
        @escaping (UNNotificationPresentationOptions) -> Void) {
        self.recreateNotifications(center: self.center)
        completionHandler([.alert, .sound, .badge])
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        default:
            print("Unknown action")
        }
        self.recreateNotifications(center: self.center)
        completionHandler()
    }
}
