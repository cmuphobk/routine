import Foundation
import Reachability

final class ReachabilityService: ReachabilityServiceInterface {

    private var reachability: Reachability = Reachability.forInternetConnection()

    var notificationService: NotificationServiceInterface!

    func configure() {
        self.notificationService.addObserver(self,
                                             selector: #selector(checkForReachability),
                                             name: NSNotification.Name.reachabilityChanged,
                                             object: nil)
        self.reachability.startNotifier()
    }

}

// MARK: Private
extension ReachabilityService {

    @objc private func checkForReachability(notification: NSNotification) {

        if let networkReachability = notification.object as? Reachability {
            let remoteHostStatus = networkReachability.currentReachabilityStatus()

            if remoteHostStatus == NetworkStatus.NotReachable {
                print("Not Reachable")
            } else if remoteHostStatus == NetworkStatus.ReachableViaWiFi {
                print("Reachable via Wifi")
            } else {
                print("Reachable")
            }
        }

    }
}
