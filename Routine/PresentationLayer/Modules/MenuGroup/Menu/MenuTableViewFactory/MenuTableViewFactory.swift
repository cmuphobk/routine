import Foundation

final class MenuTableViewFactory: MenuTableViewFactoryInterface {
    
    func menuCellViewModels(itemTitles: [String]) -> [LabelCellViewModel] {

        return itemTitles.enumerated().map { (name) -> LabelCellViewModel in
            let model = LabelCellViewModel(routineDelegate: AppDelegate.serviceProvider.makeStringService())
            model.labelViewModel.text = name.element
            model.backgroundColor = ColorProvider.menuColors.menuCellBackgroundColor
            return model
        }
    }
}
