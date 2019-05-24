import UIKit

class RoutineComboboxViewModel: RoutineViewModel {
    lazy var textFieldViewModel = RoutineTextFieldViewModel(routineDelegate: self.routineDelegate)
    lazy var markViewModel = RoutineImageViewModel(routineDelegate: self.routineDelegate)
}
