import UIKit

struct SimpleComboboxUnit: StandartPickerTitleModel {
    var title: String = ""
    var value: String = ""
}

class RoutineComboboxViewModel: RoutineViewModel {
    
    var textFieldViewModel = RoutineTextFieldViewModel()
    var markViewModel = RoutineImageViewModel() 
    
}
