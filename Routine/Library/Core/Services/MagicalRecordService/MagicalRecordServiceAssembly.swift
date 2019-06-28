import Foundation

enum MagicalRecordServiceAssembly {
    static func build() -> MagicalRecordServiceInterface {
        let magicalRecordService = MagicalRecordService()
        return magicalRecordService
    }
}
