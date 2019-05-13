import Foundation

enum StandartPagePickerFactoryAssembly {
    
    static func build() -> StandartPagePickerCollectionViewFactoryInterface {
        
        let standartPagePickerCollectionViewFactory = StandartPagePickerCollectionViewFactory()
        
        return standartPagePickerCollectionViewFactory
        
    }
    
}
