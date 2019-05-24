import Foundation

protocol MenuTableViewFactoryInterface {
    
    func menuCellViewModels(itemTitles: [String]) -> [LabelCellViewModel]
    
}
