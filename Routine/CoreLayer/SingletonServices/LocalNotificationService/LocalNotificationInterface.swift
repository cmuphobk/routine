import UIKit
import Firebase
import UserNotifications

protocol LocalNotificationServiceInterface: UNUserNotificationCenterDelegate, MessagingDelegate {
    
    func configure(application: UIApplication)
    
    func createNotifications(_ courses: [MedicineCourse])
    
    func removeAllNotifications()
    
    func obtainDatesNotificationsFromCourses(_ courses: [MedicineCourse]) -> [DateForNotification]
   
    func obtainDatesNotificationsFromDrugsModel(_ model: MedicineDrug) -> [DateForNotification]
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any])
    
}
