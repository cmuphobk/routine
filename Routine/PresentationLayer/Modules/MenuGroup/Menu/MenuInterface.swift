import UIKit

protocol MenuModuleInput: ModuleInput {
    func configureModule(menuItems: [ModuleDescription])
    func selectMenuItemWithName(_ moduleName: String)
}

protocol MenuViewInput: ViewInput {    
    func configureViewWithItemTitles(_ itemTitles: [String])
    func selectMenuItemWithName(_ moduleName: String)
}

protocol MenuViewOutput: ViewOutput {
    var localizeService: StringServiceInterface! { get }
    var menuTableViewFactory: MenuTableViewFactoryInterface! { get }
    
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    func didTriggerSelectRow(_ itemIndex: Int)
    func didTriggerShowMenu()
    func didTriggerHideMenu() 
}

protocol MenuRouterInput: RouterInput {
    func didTriggerOpenModuleById(_ identifier: String)
    func didTriggerShowMenu()
    func didTriggerHideMenu()
}

protocol MenuRouterOutput: RouterOutput {
    func openModuleById(_ identifier: String)
}
