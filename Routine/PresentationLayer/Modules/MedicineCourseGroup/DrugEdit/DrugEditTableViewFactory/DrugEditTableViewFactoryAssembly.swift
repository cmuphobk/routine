import Foundation

enum DrugEditTableViewFactoryAssembly {
    
    static func build() -> DrugEditTableViewFactoryInterface {
        
        let drugEditFactory = DrugEditTableViewFactory()
        
        return drugEditFactory
        
    }
    
}
