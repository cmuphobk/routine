import Foundation

enum DrugsListTableViewFactoryAssembly {
    
    static func build() -> DrugsListTableViewFactoryInterface {
        
        let drugListFactory = DrugsListTableViewFactory()
        
        return drugListFactory
        
    }
    
}
