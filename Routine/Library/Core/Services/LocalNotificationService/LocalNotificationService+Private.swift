import Foundation
import UserNotifications

// MARK: Private
extension LocalNotificationService {

    var dayLength: Int {
        return 60 * 60 * 24 * 1000
    }

    var poolNotificationsString: String {
        return "kPoolNotifications"
    }

    func recreateNotifications(center: UNUserNotificationCenter) {
        center.getPendingNotificationRequests { [unowned self] (requests) in
            let count = self.maxRequestsCount - requests.count
            var array = self.obtainPoolNotifications()
            for index in 0..<count where array.count > index {
                let item = array[index]
                self.configure(notification: item, center: center)
                array.remove(at: index)
            }
            self.savePoolNotifications(poolNotifications: array)
            print("\(String(describing: requests))")
        }
    }

    func obtainPoolNotifications() -> [LocalNotification] {
        guard let poolNotificationsData = self.storageService.object(forKey: self.poolNotificationsString) as? Data,
            let poolNotifications = try? JSONDecoder().decode([LocalNotification].self,
                                                              from: poolNotificationsData)
            else { return [] }
        return poolNotifications
    }

    func savePoolNotifications(poolNotifications: [LocalNotification]) {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(poolNotifications) {
            self.storageService.set(encoded, forKey: self.poolNotificationsString)
        }
    }

    func configure(notification: LocalNotification, center: UNUserNotificationCenter) {
        let identifier = notification.name
        let content = UNMutableNotificationContent()
        content.categoryIdentifier = notification.categoryIdentifier
        content.sound = UNNotificationSound.default
        content.title = notification.title
        content.badge = NSNumber(value: 0)
        let date = Date(timeIntervalSince1970: Double(notification.timestamp / 1000))
        let triggerDate = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: date)
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
        center.add(request) { (error) in
            if let error = error {
                print("Unhandled error LocalNotificationService: \(String(describing: error))")
            }
        }
    }

    func obtainTimesForPeriod(_ period: Int,
                              andStartDate startDate: Int,
                              andCountUsageNumber countUsageNumber: Int,
                              andTimes times: [Time],
                              userInfo: CustomStringConvertible) -> [DateForNotification] {
        var arrayDates: [DateForNotification] = []
        if countUsageNumber > 0 {
            var countUsageNumberVar = countUsageNumber
            for time in times {
                //добавляем прием
                if countUsageNumberVar > 0 {
                    arrayDates.append(DateForNotification(timestamp: startDate + time.rawValue(), userInfo: userInfo))
                    countUsageNumberVar -= 1
                } else {
                    return arrayDates
                }
            }
            let newStartDate = startDate + (period * dayLength)
            //startDate += period day and call
            arrayDates += self.obtainTimesForPeriod(period,
                                                    andStartDate: newStartDate,
                                                    andCountUsageNumber: countUsageNumberVar,
                                                    andTimes: times,
                                                    userInfo: userInfo)

        }
        return arrayDates
    }

    func obtainTimesForPeriod(_ period: Int,
                              andStartDate startDate: Int,
                              andCountUsageDays countUsageDays: Int,
                              andTimes times: [Time],
                              userInfo: CustomStringConvertible) -> [DateForNotification] {
        var arrayDates: [DateForNotification] = []
        if countUsageDays > 0 {
            var countUsageDaysVar = countUsageDays
            for time in times {
                arrayDates.append(DateForNotification(timestamp: startDate + time.rawValue(), userInfo: userInfo))
            }
            countUsageDaysVar -= 1
            let newStartDate = startDate + (period * dayLength)
            //startDate += period day and call
            arrayDates += self.obtainTimesForPeriod(period,
                                                    andStartDate: newStartDate,
                                                    andCountUsageDays: countUsageDaysVar,
                                                    andTimes: times,
                                                    userInfo: userInfo)

        }
        return arrayDates
    }

    func obtainTimesForPeriod(_ period: Int,
                              andStartDate startDate: Int,
                              andEndUsageDate endUsageDate: Int,
                              andTimes times: [Time],
                              userInfo: CustomStringConvertible) -> [DateForNotification] {
        var arrayDates: [DateForNotification] = []
        if startDate <= endUsageDate {
            for time in times {
                if startDate + time.rawValue() <= endUsageDate {
                    arrayDates.append(DateForNotification(timestamp: startDate + time.rawValue(), userInfo: userInfo))
                }
            }
            let newStartDate = startDate + (period * dayLength)
            //startDate += period day and call
            arrayDates += self.obtainTimesForPeriod(period,
                                                    andStartDate: newStartDate,
                                                    andEndUsageDate: endUsageDate,
                                                    andTimes: times,
                                                    userInfo: userInfo)

        }
        return arrayDates
    }

    func obtainTimesForPeriodDays(_ periodDays: Int,
                                  andStartDate startDate: Int,
                                  andCountUsageNumber countUsageNumber: Int,
                                  andTimes times: [Time],
                                  userInfo: CustomStringConvertible) -> [DateForNotification] {
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
            arrayDates += self.obtainTimesForPeriod(1,
                                                    andStartDate: startDate,
                                                    andCountUsageNumber: count,
                                                    andTimes: times,
                                                    userInfo: userInfo)
            newCountUsageNumber -= times.count
        }
        //увеличиваем startDate на 1 день и рекурсивно вызываем себя
        if newCountUsageNumber > 0 {
            arrayDates += self.obtainTimesForPeriodDays(periodDays,
                                                        andStartDate: newStartDate,
                                                        andCountUsageNumber: newCountUsageNumber,
                                                        andTimes: times,
                                                        userInfo: userInfo)
        }
        return arrayDates
    }

    func obtainTimesForPeriodDays(_ periodDays: Int,
                                  andStartDate startDate: Int,
                                  andCountUsageDays countUsageDays: Int,
                                  andTimes times: [Time],
                                  userInfo: CustomStringConvertible) -> [DateForNotification] {
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
            arrayDates += self.obtainTimesForPeriod(1,
                                                    andStartDate: startDate,
                                                    andCountUsageDays: 1,
                                                    andTimes: times,
                                                    userInfo: userInfo)
            newCountUsageDays -= 1
        }
        if newCountUsageDays > 0 {
            arrayDates += self.obtainTimesForPeriodDays(periodDays,
                                                        andStartDate: newStartDate,
                                                        andCountUsageDays: newCountUsageDays,
                                                        andTimes: times,
                                                        userInfo: userInfo)
        }
        return arrayDates
    }

    func obtainTimesForPeriodDays(_ periodDays: Int,
                                  andStartDate startDate: Int,
                                  andEndUsageDate endUsageDate: Int,
                                  andTimes times: [Time],
                                  userInfo: CustomStringConvertible) -> [DateForNotification] {
        var arrayDates: [DateForNotification] = []
        let peroidDaysInt8 = UInt8(periodDays)
        let dayOfWeek = DayOfWeek.checkDateWeekDay(timestamp: startDate)
        guard let ifExist = dayOfWeek?.checkIfExist(peroidDaysInt8) else {
            return arrayDates
        }
        let newStartDate = startDate + dayLength
        //если startDate попала в periodDays вызываем получения дат в startDate
        if ifExist {
            arrayDates += self.obtainTimesForPeriod(1,
                                                    andStartDate: startDate,
                                                    andCountUsageDays: 1,
                                                    andTimes: times,
                                                    userInfo: userInfo)
        }
        if newStartDate <= endUsageDate {
            arrayDates += self.obtainTimesForPeriodDays(periodDays,
                                                        andStartDate: newStartDate,
                                                        andEndUsageDate: endUsageDate,
                                                        andTimes: times,
                                                        userInfo: userInfo)
        }
        return arrayDates
    }
}
