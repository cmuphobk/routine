import Foundation
import HockeySDK

final class HockeyService: HockeyServiceInterface {

    static var shared = HockeyService()

    private let hockeyId = "3dfa3d93e3324d16a9c38ae59f42d063"

    private init () {
        //Configure hockeyAppSDK
        BITHockeyManager.shared().configure(withIdentifier: self.hockeyId)
        BITHockeyManager.shared().isUpdateManagerDisabled = true
        BITHockeyManager.shared().start()
        BITHockeyManager.shared().authenticator.authenticateInstallation()
    }

}
