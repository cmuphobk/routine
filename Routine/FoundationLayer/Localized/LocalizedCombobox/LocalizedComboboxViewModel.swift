import UIKit

struct SimpleComboboxUnit: StandartPickerTitleModel {
    var title: String = ""
    var value: String = ""
}

class LocalizedComboboxViewModel: LocalizedViewModel {
    
    var textFieldViewModel = LocalizedTextFieldViewModel()
    var markViewModel = LocalizedImageViewModel() 
    
}
