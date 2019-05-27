import UIKit

class MenuPresenter: BasePresenter {    
    weak var view: MenuViewInput!
    var router: MenuRouterInput!
    
    var name = R.string.localizable.menu_name.key
    var alias = R.string.localizable.menu_alias.key
    weak var viewController: UIViewController! {
        return self.view as? UIViewController
    }
    
    var menuItems: [ModuleDescription] = []
    
    var localizeService: StringServiceInterface!
    
    var menuTableViewFactory: MenuTableViewFactoryInterface!
}

// MARK: - MenuModuleInput
extension MenuPresenter: MenuModuleInput {
    func configureModule(menuItems: [ModuleDescription]) {
        self.menuItems = menuItems
    }
    
    func selectMenuItemWithName(_ moduleName: String) {
        self.view?.selectMenuItemWithName(self.localizeService.localizeId(moduleName))
    }
}

// MARK: - MenuViewOutput
extension MenuPresenter: MenuViewOutput {
    
    func didTriggerShowMenu() {
        self.router.didTriggerShowMenu()
    }
    
    func didTriggerHideMenu() {
        self.router.didTriggerHideMenu()
    }
    
    func didTriggerViewReadyEvent() {
        self.view?.setupInitialState()
        
        let itemTitles = self.menuItems.map { (moduleDescription) -> String? in
            return self.localizeService.localizeId(moduleDescription.alias)
        }
        
        let filterItems = itemTitles.filter { $0 != nil ? true : false }
        
        if let filterItems = filterItems as? [String] {
            self.view?.configureViewWithItemTitles(filterItems)
        }
    }
    
    func didTriggerViewWillAppear() {
        
    }
    
    func didTriggerSelectRow(_ itemIndex: Int) {
        
        if itemIndex < self.menuItems.count {
            let item: String = self.menuItems[itemIndex].name
            self.router.didTriggerOpenModuleById(item)
        }
        
    }

}
