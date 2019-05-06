import UIKit

final class StandartPagePickerCollectionViewFactory {
    
    static func standartPagePickerCellViewModels(models: [String], size: CGSize, font: UIFont, textColor: UIColor, backgroundColor: UIColor) -> [RoutineCollectionViewCellViewModel] {
        
        return models.map({ (name) -> StandartPagePickerCellViewModel in
            StandartPagePickerCellViewModel(text: name, size: size, isSelected: false, font: font, textColor: textColor, backgroundColor: backgroundColor)
        })
    }
    
}
