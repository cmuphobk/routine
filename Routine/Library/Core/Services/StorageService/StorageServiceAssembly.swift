import Foundation

enum StorageServiceAssembly {

    static func build() -> StorageServiceInterface {

        let storageService = StorageService.shared

        return storageService

    }

}
