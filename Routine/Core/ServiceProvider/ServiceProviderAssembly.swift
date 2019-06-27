import Foundation

enum ServiceProviderAssembly {

    static func build() -> ServiceProviderInterface {

        let serviceProvider = ServiceProvider.shared

        serviceProvider.storageService = StorageServiceAssembly.build()
        serviceProvider.languageService = LanguageServiceAssembly.build()

        serviceProvider.localNotificationService = LocalNotificationServiceAssembly.build(storageService:
            serviceProvider.storageService)
        serviceProvider.moduleService = ModuleServiceAssembly.build()
        serviceProvider.windowService = WindowServiceAssembly.build()
        serviceProvider.notificationService = NotificationServiceAssembly.build()
        serviceProvider.reachabilityService = ReachabilityServiceAssembly.build(notificationService:
            serviceProvider.notificationService)
        serviceProvider.magicalRecordService = MagicalRecordServiceAssembly.build()
        serviceProvider.hockeyService = HockeyServiceAssembly.build()

        serviceProvider.stringService = StringServiceAssembly.build(windowService: serviceProvider.windowService,
                                                                    languageService: serviceProvider.languageService)
        serviceProvider.imageService = ImageServiceAssembly.build(languageService: serviceProvider.languageService)
        serviceProvider.dateService = DateServiceAssembly.build(languageService: serviceProvider.languageService)

        return serviceProvider

    }

}
