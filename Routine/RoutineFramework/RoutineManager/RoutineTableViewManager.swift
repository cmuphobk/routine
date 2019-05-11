import UIKit

protocol RoutineTableViewManagerDelegate: class {
    func didTriggerCell(index: Int, actionType: RoutineActionType)
}

protocol RoutineTableViewManagerInterface {
    func configure(cellViewModels: [RoutineTableViewCellViewModel], reloadData: Bool)
    func updateRowAtIndex(_ index: Int)
    func deleteRowAtIndex(_ index: Int)
    func insertRowToIndex(_ index: Int)
    func moveRowFromIndex(_ index: Int, toIndex: Int)
    func scrollToIndex(_ index: Int, scrollPosition: UITableView.ScrollPosition, animated: Bool)
    func selectedRows() -> [Int]
    func selectRow(_ index: Int)
    func deselectRow(_ index: Int)
}

final class RoutineTableViewManager: NSObject {
    
    private var tableView: UITableView
    
    private var cellViewModels: [RoutineTableViewCellViewModel] = []
    
    var count: Int {
        return self.cellViewModels.count
    }
    
    weak var delegate: RoutineTableViewManagerDelegate?
    
    init(tableView: UITableView, delegate: RoutineTableViewManagerDelegate?) {
        self.tableView = tableView
        self.delegate = delegate
        super.init()
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    
    }
    
}

// MARK: - RoutineTableViewManagerInterface
extension RoutineTableViewManager: RoutineTableViewManagerInterface {
    
    func configure(cellViewModels: [RoutineTableViewCellViewModel], reloadData: Bool = true) {
        self.cellViewModels = cellViewModels
        
        for viewModel in self.cellViewModels {
            if let owner = viewModel.cellOwner, let reuseIdentifier = viewModel.reuseIdentifier {
                switch owner {
                case .type(let value): self.tableView.register(value, forCellReuseIdentifier: reuseIdentifier)
                case .nib(let value): self.tableView.register(value, forCellReuseIdentifier: reuseIdentifier)
                }
            }
        }
        
        if reloadData {
            self.tableView.reloadData()
        }
    
    }
        
    func updateRowAtIndex(_ index: Int) {
        self.tableView.reloadRows(at: [IndexPath(row: index, section: 0)], with: .fade)
    }
    
    func deleteRowAtIndex(_ index: Int) {
        self.tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .right)
    }
    
    func insertRowToIndex(_ index: Int) {
        self.tableView.insertRows(at: [IndexPath(row: index, section: 0)], with: .left)
    }
    
    func moveRowFromIndex(_ index: Int, toIndex: Int) {
        self.tableView.moveRow(at: IndexPath(row: index, section: 0), to: IndexPath(index: toIndex))
    }
    
    func scrollToIndex(_ index: Int, scrollPosition: UITableView.ScrollPosition, animated: Bool) {
        self.tableView.scrollToRow(at: IndexPath(row: index, section: 0), at: scrollPosition, animated: animated)
    }
    
    func selectedRows() -> [Int] {
        var result: [Int] = []
        
        for tuple in self.cellViewModels.enumerated() where tuple.element.isSelected == true {
            result += [tuple.offset]
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

// MARK: - UITableViewDataSource
extension RoutineTableViewManager: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellViewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let reuseIdentifier = self.cellViewModels[indexPath.row].reuseIdentifier else { return UITableViewCell() }
        return tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
    
    }
}

// MARK: - UITableViewDelegate
extension RoutineTableViewManager: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let cellViewModel = self.cellViewModels[indexPath.row]
        
        if cellViewModel.isSelected {
            tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        } else {
            tableView.deselectRow(at: indexPath, animated: false)
        }
        
        if let configure = cell as? RoutineConfigure {
            configure.configureView(config: cellViewModel)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellObj = self.cellViewModels[indexPath.row]
        return cellObj.heightForWidth(self.tableView.frame.width)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.cellViewModels[indexPath.row].isSelected = true
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.setNeedsLayout()
        }
        
        self.delegate?.didTriggerCell(index: indexPath.row, actionType: .select)
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        self.cellViewModels[indexPath.row].isSelected = false
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.setNeedsLayout()
        }
        
        self.delegate?.didTriggerCell(index: indexPath.row, actionType: .deselect)
    }
}
