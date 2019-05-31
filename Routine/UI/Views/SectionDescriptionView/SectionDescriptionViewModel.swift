import UIKit

protocol SectionDescriptionViewModel {
    associatedtype ViewModel: RoutineViewModel
    var viewModel: ViewModel { get set }
    var descriptionLabelViewModel: RoutineLabelViewModel { get set }
    init(viewModel: ViewModel,
         descriptionLabelViewModel: RoutineLabelViewModel)
}

extension SectionDescriptionViewModel {
    init(viewModel: ViewModel,
         descriptionLabelViewModel: RoutineLabelViewModel) {
        self.viewModel = viewModel
        self.descriptionLabelViewModel = descriptionLabelViewModel
    }
    func heightForWidth(_ width: CGFloat) -> CGFloat {
        let heightLabel = self.descriptionLabelViewModel.heightForWidth(width)
        return heightLabel
    }
}
