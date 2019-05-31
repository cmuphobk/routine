import UIKit

protocol SectionHeaderViewModelDelegate: class {
    func didTriggerCloseButton(viewModel: SectionHeaderViewModel)
}

class SectionHeaderViewModel: RoutineViewModel {

    lazy var infoIconViewModel = RoutineImageViewModel()
    lazy var textLabelViewModel = RoutineLabelViewModel()
    lazy var closeButtonViewModel = RoutineButtonViewModel()
    weak var delegate: SectionHeaderViewModelDelegate?

    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return 25.0
    }
}
