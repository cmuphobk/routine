import UIKit

protocol SectionHeaderViewModelDelegate: class {
    func didTriggerCloseButton(viewModel: SectionHeaderViewModel)
}

class SectionHeaderViewModel: RoutineViewModel {

    lazy var infoIconViewModel = RoutineImageViewModel(routineDelegate: self.routineDelegate)
    lazy var textLabelViewModel = RoutineLabelViewModel(routineDelegate: self.routineDelegate)
    lazy var closeButtonViewModel = RoutineButtonViewModel(routineDelegate: self.routineDelegate)
    weak var delegate: SectionHeaderViewModelDelegate?

    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return 25.0
    }
}
