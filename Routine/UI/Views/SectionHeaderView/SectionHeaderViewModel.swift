import UIKit

protocol SectionHeaderViewModelDelegate: class {
    func didTriggerCloseButton(viewModel: SectionHeaderViewModel)
}

class SectionHeaderViewModel: LocalizedViewModel {
    
    var infoIconViewModel = LocalizedImageViewModel()
    var textLabelViewModel = LocalizedLabelViewModel()
    var closeButtonViewModel = LocalizedButtonViewModel()
    weak var delegate: SectionHeaderViewModelDelegate?

    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        return 25.0
    }
}
