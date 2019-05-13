import Foundation

protocol MedicineCourseTableViewFactoryInterface {
    
    func medicineCourseCellViewModel(medicineCourse: MedicineCourse, isArchive: Bool, delegate: MedicineCourseCellProtocol) -> RoutineTableViewCellViewModel
    
    func medicineCourseCellViewModels(models: [MedicineCourse], isArchive: Bool, delegate: MedicineCourseCellProtocol) -> [RoutineTableViewCellViewModel]
    
}
