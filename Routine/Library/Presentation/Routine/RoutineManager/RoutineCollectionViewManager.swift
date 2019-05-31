import UIKit

protocol RoutineCollectionViewManagerDelegate: class {
    func didTriggerCell(index: Int, actionType: RoutineActionType)
}

protocol RoutineCollectionViewManagerInterface {
    func configure(cellViewModels: [RoutineCollectionViewCellViewModel], reloadData: Bool)
    func updateRowAtIndex(_ index: Int)
    func deleteRowAtIndex(_ index: Int)
    func insertRowToIndex(_ index: Int)
    func moveRowFromIndex(_ index: Int, toIndex: Int)
    func scrollToIndex(_ index: Int, scrollPosition: UICollectionView.ScrollPosition, animated: Bool)
    func selectedRows() -> [Int]
    func selectRow(_ index: Int)
    func deselectRow(_ index: Int)
}

final class RoutineCollectionViewManager: NSObject {
    private var collectionView: UICollectionView
    weak var delegate: RoutineCollectionViewManagerDelegate?

    private var cellViewModels: [RoutineCollectionViewCellViewModel] = []

    init(collectionView: UICollectionView, delegate: RoutineCollectionViewManagerDelegate) {
        self.collectionView = collectionView
        self.delegate = delegate
        super.init()

        self.collectionView.dataSource = self
        self.collectionView.delegate = self

    }

}

// MARK: - RoutineCollectionViewManagerInterface
extension RoutineCollectionViewManager: RoutineCollectionViewManagerInterface {

    func configure(cellViewModels: [RoutineCollectionViewCellViewModel], reloadData: Bool = true) {
        self.cellViewModels = cellViewModels

        for viewModel in self.cellViewModels {
            if let owner = viewModel.cellOwner, let reuseIdentifier = viewModel.reuseIdentifier {
                switch owner {
                case .type(let value): self.collectionView.register(value, forCellWithReuseIdentifier: reuseIdentifier)
                case .nib(let value): self.collectionView.register(value, forCellWithReuseIdentifier: reuseIdentifier)
                }
            }
        }

        if reloadData {
            self.collectionView.reloadData()
        }

    }

    func updateRowAtIndex(_ index: Int) {
        self.collectionView.reloadItems(at: [IndexPath(row: index, section: 0)])
    }

    func deleteRowAtIndex(_ index: Int) {
        self.collectionView.deleteItems(at: [IndexPath(row: index, section: 0)])
    }

    func insertRowToIndex(_ index: Int) {
        self.collectionView.insertItems(at: [IndexPath(row: index, section: 0)])
    }

    func moveRowFromIndex(_ index: Int, toIndex: Int) {
        self.collectionView.moveItem(at: IndexPath(row: index, section: 0), to: IndexPath(index: toIndex))
    }

    func scrollToIndex(_ index: Int, scrollPosition: UICollectionView.ScrollPosition, animated: Bool) {
        self.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: scrollPosition, animated: animated)
    }

    func selectedRows() -> [Int] {
        var result: [Int] = []

        for item in self.collectionView.indexPathsForSelectedItems ?? [] {
            result += [item.row]
        }

        return result
    }

    func selectRow(_ index: Int) {
        self.cellViewModels[index].isSelected = true
        self.updateRowAtIndex(index)
    }

    func deselectRow(_ index: Int) {
        self.cellViewModels[index].isSelected = false
        self.updateRowAtIndex(index)
    }

}

// MARK: - UICollectionViewDataSource
extension RoutineCollectionViewManager: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.cellViewModels.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let reuseIdentifier = self.cellViewModels[indexPath.row].reuseIdentifier else { return UICollectionViewCell() }
        return collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)

    }

}

// MARK: - UICollectionViewDelegate
extension RoutineCollectionViewManager: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let cellObj = self.cellViewModels[indexPath.row]

        if cellObj.isSelected {
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .left)
        } else {
            collectionView.deselectItem(at: indexPath, animated: false)
        }

        if let loclaizedConfigure = cell as? RoutineConfigure {
            loclaizedConfigure.configureView(config: cellObj)
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.cellViewModels[indexPath.row].isSelected = true
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.setNeedsLayout()
        }

        self.delegate?.didTriggerCell(index: indexPath.row, actionType: .select)
    }

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        self.cellViewModels[indexPath.row].isSelected = false
        if let cell = collectionView.cellForItem(at: indexPath) {
            cell.setNeedsLayout()
        }

        self.delegate?.didTriggerCell(index: indexPath.row, actionType: .deselect)
    }
}

// MARK: - UICollectionViewFlowLayout
extension RoutineCollectionViewManager: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {

        let viewModel = self.cellViewModels[indexPath.row]

        return CGSize(width: viewModel.width, height: viewModel.heightForWidth(viewModel.width))

    }

    // FIXME: - сделать вью модель для секций
    // чтобы можно было работать с секциями (для таблицы тоже самое)
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }

}
