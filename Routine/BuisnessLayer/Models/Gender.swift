import Foundation

enum Gender: String, StandartPickerTitleModel {
    
    case male = "gender_male"
    case female = "gender_female"
    
    var title: String {
        return AppDelegate.serviceProvider.makeStringService().localizeById(self.rawValue)
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
