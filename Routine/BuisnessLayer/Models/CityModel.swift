import Foundation

struct CityModel: StandartPickerTitleModel {
    
    let name: String
    let code: Int
    
    var title: String {
        return name
    }
    
}
