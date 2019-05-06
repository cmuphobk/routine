import UIKit

class MenuModulePresenter {
    var moduleOutput: MenuModuleOutput!
    
    weak var view: MenuModuleViewInput?
    var router: MenuModuleRouting!
    
    var menuItems: [ModuleDescription] = []
}

// MARK: - MenuModuleInput
extension MenuModulePresenter: MenuModuleInput {
    func configureModule(menuItems: [ModuleDescription]) {
        self.menuItems = menuItems
    }
    
    func selectMenuItemWithName(_ moduleName: String) {
        self.view?.selectMenuItemWithName(AppDelegate.serviceProvider.makeStringService().localizeById(moduleName))
    }
}

// MARK: - MenuModuleViewOutput
extension MenuModulePresenter: MenuModuleViewOutput {
    func didTriggerShowMenu() {
        self.router.didTriggerShowMenu()
    }
    
    func didTriggerHideMenu() {
        self.router.didTriggerHideMenu()
    }
    
    func didTriggerViewReadyEvent() {
        self.view?.setupInitialState()
        
        let itemTitles = self.menuItems.map { (moduleDescription) -> String? in
            return AppDelegate.serviceProvider.makeStringService().localizeById(moduleDescription.alias)
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
