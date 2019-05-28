import Foundation

enum MagicalRecordServiceAssembly {

    static func build() -> MagicalRecordServiceInterface {

        let magicalRecordService = MagicalRecordService.shared

        return magicalRecordService

    }

}
