import Foundation

protocol DrugEditTableViewFactoryInterface {
    
    func makeCellViewModelsBeforeTimes(model: MedicineDrug?, delegate: TextFieldCellProtocol & TwiceComboboxCellProtocol & SingleButtonCellProtocol & TextAreaCellProtocol & ComboboxCellProtocol) -> [RoutineTableViewCellViewModel]
    
    func makeCellObjectsAfterTimes(model: MedicineDrug?, delegate: TextFieldCellProtocol & TwiceComboboxCellProtocol & SingleButtonCellProtocol & TextAreaCellProtocol, editMode: DrugEditMode) -> [RoutineTableViewCellViewModel]
    
    func makeTimeCellViewModel(model: MedicineDrug?, delegate: UsingTimesCellViewModelDelegate) -> [UsingTimesCellViewModel]
    
    func makeTimeCellViewModel(index: Int, delegate: UsingTimesCellViewModelDelegate) -> UsingTimesCellViewModel

}
