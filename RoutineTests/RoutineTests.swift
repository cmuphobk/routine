import XCTest
@testable import Routine

class RoutineTests: XCTestCase {
    
    //injections
    let localNotificationService: LocalNotificationServiceInterface = AppDelegate.serviceProvider.makeLocalNotificationService()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLocalNotificationService() {
        
//        var startDate = Date()
//        startDate.hour(0)
//        startDate.minute(0)
//        startDate.second(0)
//
//        var endDate = Date().add(3.days)
//
//        endDate.hour(0)
//        endDate.minute(0)
//        endDate.second(0)
//
//        let startTimestamp = Int(startDate.timeIntervalSince1970 * 1000)
//
//        let endTimestamp = Int(endDate.timeIntervalSince1970 * 1000)
//
//        var drugsModel: MedicineDrug
//
//        drugsModel = MedicineDrug(name: "test", comment: "", type: .ampoules, unit: .gramm, startDate: startTimestamp, endingCourseValue: 5, endingCourseType: .countUsageNumber, daysPeriod: 2, periodCourseType: .countDays, times: [
//            MedicineCourseTime(dose: 0, usageTime: Time(hours: 12, minutes: 0)),
//            MedicineCourseTime(dose: 0, usageTime: Time(hours: 15, minutes: 0))
//            ])
//
//        XCTAssert(self.localNotificationService.obtainDatesNotificationsFromDrugsModel(drugsModel).count == 5, "notifications count: \(self.localNotificationService.obtainDatesNotificationsFromDrugsModel(drugsModel).count); endDate: \(drugsModel.endDate ?? 0)")
//
//        drugsModel = MedicineDrug(name: "test", comment: "", type: .ampoules, unit: .gramm, startDate: startTimestamp, endingCourseValue: 5, endingCourseType: .countUsageDays, daysPeriod: 2, periodCourseType: .countDays, times: [
//            MedicineCourseTime(dose: 0, usageTime: Time(hours: 12, minutes: 0)),
//            MedicineCourseTime(dose: 0, usageTime: Time(hours: 15, minutes: 0))
//            ])
//
//        XCTAssert(self.localNotificationService.obtainDatesNotificationsFromDrugsModel(drugsModel).count == 10, "notifications count: \(self.localNotificationService.obtainDatesNotificationsFromDrugsModel(drugsModel)); endDate: \(drugsModel.endDate ?? 0)")
//
//        drugsModel = MedicineDrug(name: "test", comment: "", type: .ampoules, unit: .gramm, startDate: startTimestamp, endingCourseValue: endTimestamp, endingCourseType: .endUsageDate, daysPeriod: 2, periodCourseType: .countDays, times: [
//            MedicineCourseTime(dose: 0, usageTime: Time(hours: 12, minutes: 0)),
//            MedicineCourseTime(dose: 0, usageTime: Time(hours: 15, minutes: 0))
//            ])
//
//        XCTAssert(self.localNotificationService.obtainDatesNotificationsFromDrugsModel(drugsModel).count == 4, "notifications count: \(self.localNotificationService.obtainDatesNotificationsFromDrugsModel(drugsModel)); endDate: \(drugsModel.endDate ?? 0)")
//
//
//
//        let periodDays = 0b00011111
//        let intPeriodDays = Int(periodDays)
//
//        drugsModel = MedicineDrug(name: "test", comment: "", type: .ampoules, unit: .gramm, startDate: startTimestamp, endingCourseValue: 5, endingCourseType: .countUsageNumber, daysPeriod: intPeriodDays, periodCourseType: .weekDays, times: [
//            MedicineCourseTime(dose: 0, usageTime: Time(hours: 12, minutes: 0)),
//            MedicineCourseTime(dose: 0, usageTime: Time(hours: 15, minutes: 0))
//            ])
//
//        XCTAssert(true, "notifications count: \(self.localNotificationService.obtainDatesNotificationsFromDrugsModel(drugsModel)); endDate: \(drugsModel.endDate ?? 0)")
//
//        drugsModel = MedicineDrug(name: "test", comment: "", type: .ampoules, unit: .gramm, startDate: startTimestamp, endingCourseValue: 5, endingCourseType: .countUsageDays, daysPeriod: intPeriodDays, periodCourseType: .weekDays, times: [
//            MedicineCourseTime(dose: 0, usageTime: Time(hours: 12, minutes: 0)),
//            MedicineCourseTime(dose: 0, usageTime: Time(hours: 15, minutes: 0))
//            ])
//
//        XCTAssert(true, "notifications count: \(self.localNotificationService.obtainDatesNotificationsFromDrugsModel(drugsModel)); endDate: \(drugsModel.endDate ?? 0)")
//
//        drugsModel = MedicineDrug(name: "test", comment: "", type: .ampoules, unit: .gramm, startDate: startTimestamp, endingCourseValue: endTimestamp, endingCourseType: .endUsageDate, daysPeriod: intPeriodDays, periodCourseType: .weekDays, times: [
//            MedicineCourseTime(dose: 0, usageTime: Time(hours: 12, minutes: 0)),
//            MedicineCourseTime(dose: 0, usageTime: Time(hours: 15, minutes: 0))
//            ])
//
//        XCTAssert(true, "notifications count: \(self.localNotificationService.obtainDatesNotificationsFromDrugsModel(drugsModel)); endDate: \(drugsModel.endDate ?? 0)")
//
//        self.localNotificationService.createNotifications(drugsModel)

    }

}
