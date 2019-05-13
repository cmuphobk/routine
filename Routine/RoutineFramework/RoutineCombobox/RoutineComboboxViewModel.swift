import UIKit

struct SimpleComboboxUnit: StandartPickerTitleModel {
    func toString(localizeService: StringServiceInterface) -> String {
        return localizeService.localizeId(self.value)
    }
    
    var value: String = ""
}

class RoutineComboboxViewModel: RoutineViewModel {
    
    lazy var textFieldViewModel = RoutineTextFieldViewModel(routineDelegate: self.routineDelegate)
    lazy var markViewModel = RoutineImageViewModel(routineDelegate: self.routineDelegate)
    
}
