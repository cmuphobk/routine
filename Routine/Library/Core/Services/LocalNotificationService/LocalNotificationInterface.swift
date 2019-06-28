import UIKit
import Firebase
import UserNotifications

protocol LocalNotificationServiceInterface: UNUserNotificationCenterDelegate, MessagingDelegate {

    func configure(application: UIApplication)

    func createNotifications(model: NotificationsModel)

    func recreateNotifications()

    func removeAllNotifications()

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any])

}
