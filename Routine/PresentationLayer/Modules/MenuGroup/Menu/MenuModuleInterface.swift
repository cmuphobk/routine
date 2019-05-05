
import UIKit

protocol MenuModuleInput: class {
    func configureModule(menuItems: [ModuleDescription])
    func selectMenuItemWithName(_ moduleName: String)
}

protocol MenuModuleOutput: class {
}

protocol MenuModuleViewInput: class {
    func setupInitialState()
    
    func configureViewWithItemTitles(_ itemTitles: [String])
    func selectMenuItemWithName(_ moduleName: String)
}

protocol MenuModuleViewOutput: class {
    func didTriggerViewReadyEvent()
    func didTriggerViewWillAppear()
    func didTriggerSelectRow(_ itemIndex: Int)
    func didTriggerShowMenu()
    func didTriggerHideMenu() 
}

protocol MenuModuleRouting: class {
    func didTriggerOpenModuleById(_ identifier: String)
    func didTriggerShowMenu()
    func didTriggerHideMenu()
}
