
import UIKit

final class MedicineCourseTableViewFactory {
    
    static func medicineCourseCellViewModel(medicineCourse: MedicineCourse, isArchive: Bool, delegate: MedicineCourseCellProtocol) -> LocalizedTableViewCellViewModel {
        let cellViewModel = MedicineCourseCellViewModel(name: medicineCourse.name, drugs: medicineCourse.drugs ?? [], isArchive: isArchive, delegate: delegate)
        return cellViewModel
    }
    
    static func medicineCourseCellViewModels(models: [MedicineCourse], isArchive: Bool, delegate: MedicineCourseCellProtocol) -> [LocalizedTableViewCellViewModel] {
        return models.map({ [unowned delegate] (item) -> LocalizedTableViewCellViewModel in
            let cellViewModel = self.medicineCourseCellViewModel(medicineCourse: item, isArchive: isArchive, delegate: delegate)
            return cellViewModel
        })
    }
    
}
