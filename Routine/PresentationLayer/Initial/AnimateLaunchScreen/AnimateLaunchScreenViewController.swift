import UIKit

final class AnimateLaunchScreenViewController: RoutineViewController {
    
    @IBOutlet weak private var logoImageView: UIImageView!
    @IBOutlet weak private var progressView: StandartProgressBar!
    
    var progress: Float = 0.0

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.updateProgress(self.progress)
    }

    override func localizationSetup() {
        super.localizationSetup()
        
        self.logoImageView.image = AppDelegate.serviceProvider.makeImageService().localizeById("logo_splash")
        
    }
    
    func updateProgress(_ progres: Float) {
        if progres > 1.0 {
            self.progress = 1.0
        } else if progres < 0.0 {
            self.progress = 0.0
        } else {
            self.progress = progres
        }
        self.progressView?.setProgress(self.progress, animated: true)
    }
    
}
