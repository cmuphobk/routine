import UIKit

final class MedicineCourseTableViewFactory {
    
    static func medicineCourseCellViewModel(medicineCourse: MedicineCourse, isArchive: Bool, delegate: MedicineCourseCellProtocol) -> RoutineTableViewCellViewModel {
        let cellViewModel = MedicineCourseCellViewModel(name: medicineCourse.name, drugs: medicineCourse.drugs ?? [], isArchive: isArchive, delegate: delegate)
        return cellViewModel
    }
    
    static func medicineCourseCellViewModels(models: [MedicineCourse], isArchive: Bool, delegate: MedicineCourseCellProtocol) -> [RoutineTableViewCellViewModel] {
        return models.map({ [unowned delegate] (item) -> RoutineTableViewCellViewModel in
            let cellViewModel = self.medicineCourseCellViewModel(medicineCourse: item, isArchive: isArchive, delegate: delegate)
            return cellViewModel
        })
    }
    
}
