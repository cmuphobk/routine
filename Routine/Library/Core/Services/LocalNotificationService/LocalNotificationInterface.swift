import UIKit
import Firebase
import UserNotifications

protocol LocalNotificationServiceInterface: UNUserNotificationCenterDelegate, MessagingDelegate {
    
    func configure(application: UIApplication)
    
    func createNotifications(startDate: Int,
                             times: [Time],
                             periodCourseType: PeriodCourseType,
                             periodCourseValue: Int,
                             endingCourseType: EndingCourseType,
                             endingCourseValue: Int,
                             userInfo: CustomStringConvertible)
    
    func removeAllNotifications()
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any])
    
}
