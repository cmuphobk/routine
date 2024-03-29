import Foundation

final class ServiceProvider: ServiceProviderInterface {
    
    //store all singletone services
    
    //sigletone services
    var languageService: LanguageServiceInterface!
    var stringService: StringServiceInterface!
    var imageService: ImageServiceInterface!
    var dateService: DateServiceInterface!
    var localNotificationService: LocalNotificationServiceInterface!
    var storageService: StorageServiceInterface!
    var moduleService: ModuleServiceInterface!
    var windowService: WindowServiceInterface!
    var notificationService: NotificationServiceInterface!
    var reachabilityService: ReachabilityServiceInterface!
    var magicalRecordService: MagicalRecordServiceInterface!
    var hockeyService: HockeyServiceInterface!
    
    //stored instance services
    var authService: AuthServiceInterface!
    
    static var shared = ServiceProvider()
    
    //build all service-dependencies in project
    private init () { }
    
    //make services
    func makeLanguageService() -> LanguageServiceInterface {
        return self.languageService
    }
    
    func makeStringService() -> StringServiceInterface {
        return self.stringService
    }
    
    func makeImageService() -> ImageServiceInterface {
        return self.imageService
    }
    
    func makeDateService() -> DateServiceInterface {
        return self.dateService
    }
    
    func makeLocalNotificationService() -> LocalNotificationServiceInterface {
        return self.localNotificationService
    }
    
    func makeStorageService() -> StorageServiceInterface {
        return self.storageService
    }
    
    func makeModuleService() -> ModuleServiceInterface {
        return self.moduleService
    }
    
    func makeWindowService() -> WindowServiceInterface {
        return self.windowService
    }
    
    func makeReachabilityService() -> ReachabilityServiceInterface {
        return self.reachabilityService
    }
    
    func makeMagicalRecordService() -> MagicalRecordServiceInterface {
        return self.magicalRecordService
    }
    
    func makeNotificationService() -> NotificationServiceInterface {
        return self.notificationService
    }
    
    func makeHockeyService() -> HockeyServiceInterface {
        return self.hockeyService
    }
    
    func makeAuthService() -> AuthServiceInterface {
        return self.authService
    }
    
    func makeMedicineCourseService() -> MedicineCourseServiceInterface {
        return MedicineCourseServiceAssembly.build()
    }
    
    func makeMedicineDrugService() -> MedicineDrugServiceInterface {
        return MedicineDrugServiceAssembly.build()
    }
    
    
    
}
