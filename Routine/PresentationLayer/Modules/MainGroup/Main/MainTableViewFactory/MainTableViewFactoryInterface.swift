import Foundation

protocol MainTableViewFactoryInterface {
    func mainCellViewModels(delegate: SectionCellViewModelDelegate) -> [SectionCellViewModel]
}
