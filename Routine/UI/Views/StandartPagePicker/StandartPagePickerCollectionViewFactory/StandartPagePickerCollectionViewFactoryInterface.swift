import UIKit

protocol StandartPagePickerCollectionViewFactoryInterface {
    
    func standartPagePickerCellViewModels(models: [String], size: CGSize, font: UIFont, textColor: UIColor, backgroundColor: UIColor) -> [RoutineCollectionViewCellViewModel]
    
}
