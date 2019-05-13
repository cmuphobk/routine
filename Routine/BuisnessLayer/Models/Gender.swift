import Foundation

enum Gender: String, StandartPickerTitleModel {
    
    case male = "gender_male"
    case female = "gender_female"
    
    func toString(localizeService: StringServiceInterface) -> String {
        return localizeService.localizeId(self.rawValue)
    }
    
    var genderCode: String? {
        switch self {
        case .male:
            return "man"
        case .female:
            return "women"
        }
    }
    
}
