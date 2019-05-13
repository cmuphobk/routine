import Foundation

final class MenuTableViewFactory: MenuTableViewFactoryInterface {
    
    func menuCellViewModels(itemTitles: [String]) -> [MenuModuleCellViewModel] {

        return itemTitles.enumerated().map { (name) -> MenuModuleCellViewModel in
            let model = MenuModuleCellViewModel(routineDelegate: AppDelegate.serviceProvider.makeStringService())
            model.text = name.element
            model.backgroundColor = ColorProvider.menuColors.menuCellBackgroundColor
            return model
        }
    }
}
