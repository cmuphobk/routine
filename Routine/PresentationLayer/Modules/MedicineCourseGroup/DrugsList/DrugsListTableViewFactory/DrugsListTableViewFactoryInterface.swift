import Foundation

protocol DrugsListTableViewFactoryInterface {
    
    func drugsListCellViewModels(model: MedicineCourse) -> [RoutineTableViewCellViewModel]
    
    func drugsListCellViewModel(model: MedicineDrug) -> DrugCellViewModel
    
}
