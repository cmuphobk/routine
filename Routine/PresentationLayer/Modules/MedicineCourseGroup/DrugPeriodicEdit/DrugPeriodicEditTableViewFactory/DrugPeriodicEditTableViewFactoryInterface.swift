import Foundation

protocol DrugPeriodicEditTableViewFactoryInterface {
    
    func makeDays(withValue: Int) -> [RoutineTableViewCellViewModel]
    
    func makeDay(text: String, isSelected: Bool) -> RoutineTableViewCellViewModel
    
    func makeCountDays(withValue: Int) -> [RoutineTableViewCellViewModel]
    
}
