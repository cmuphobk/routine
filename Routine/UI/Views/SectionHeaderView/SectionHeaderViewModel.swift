import UIKit

protocol SectionHeaderViewModelDelegate: class {
    func didTriggerCloseButton(viewModel: SectionHeaderViewModel)
}

class SectionHeaderViewModel: RoutineViewModel {
    
    var infoIconViewModel = RoutineImageViewModel()
    var textLabelViewModel = RoutineLabelViewModel()
    var closeButtonViewModel = RoutineButtonViewModel()
    weak var delegate: SectionHeaderViewModelDelegate?

    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return 25.0
    }
}
