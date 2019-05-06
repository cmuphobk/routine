import UIKit

protocol MedicineCourseCellProtocol: class {
    func rowDidRenamed(cellObj: MedicineCourseCellViewModel)
    func rowDidRemoved(cellObj: MedicineCourseCellViewModel)
}

final class MedicineCourseCellViewModel: RoutineTableViewCellViewModel {
    //constants
    let kCardOffsets: Offsets = Offsets(top: 8.0, bottom: 8.0, left: 16.0, right: 16.0)
    let kContentOffsets: Offsets = Offsets(top: 16.0, bottom: 16.0, left: 16.0, right: 16.0)
    let progressBarHeight: CGFloat = 8.0

    //configurable properties
    let name: String
    let drugs: [MedicineDrug]
    let isArchive: Bool
    weak var delegate: MedicineCourseCellProtocol?
    var cellWidth: CGFloat = 0.0
    
    var drugNames: String {
        return self.drugs.map { (item) -> String in return item.name }.joined(separator: ", ")
    }
    
    init(name: String, drugs: [MedicineDrug], isArchive: Bool, delegate: MedicineCourseCellProtocol) {
        self.name = name
        self.drugs = drugs
        self.isArchive = isArchive
        self.delegate = delegate
        
        super.init()
    }
    
    override var reuseIdentifier: String {
        return "MedicineCourseCell"
    }
    override var cellOwner: CellOwner {
        return .nib(value: UINib(nibName: self.reuseIdentifier, bundle: nil))
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        self.cellWidth = width
        return self.kCardOffsets.top + self.calcCardContentHeight() + self.kContentOffsets.bottom
    }

}

extension MedicineCourseCellViewModel {
    func calcCardContentHeight() -> CGFloat {
        
        let leftAndRightOffset: CGFloat = self.kCardOffsets.left + self.kContentOffsets.left + self.kCardOffsets.left + self.kContentOffsets.left
        let actionIconsWidthWithConstraint: CGFloat = (24.0 + 12.0 + 24.0 + 12.0)
        
        let titleSize = FontProvider.medicineCourseFonts.titleLabel.sizeOfString(string: self.name,
                                                                                      constrainedToWidth: Double(self.cellWidth - leftAndRightOffset - actionIconsWidthWithConstraint))
        let drugsSize = FontProvider.medicineCourseFonts.drugsList.sizeOfString(string: "\(AppDelegate.serviceProvider.makeStringService().localizeById("drugs")): \(self.drugNames)",
                                                                                     constrainedToWidth: Double(self.cellWidth - leftAndRightOffset))
        let beginDateLineSize = FontProvider.medicineCourseFonts.dateLabel.sizeOfString(string: AppDelegate.serviceProvider.makeStringService().localizeById("course_start"),
                                                                                        constrainedToWidth: Double(self.cellWidth - leftAndRightOffset))
        let endDateLineSize = FontProvider.medicineCourseFonts.dateLabel.sizeOfString(string: AppDelegate.serviceProvider.makeStringService().localizeById("course_end"),
                                                                                constrainedToWidth: Double(self.cellWidth - leftAndRightOffset))
        
        return self.kContentOffsets.top + titleSize.height + 16.0 + drugsSize.height + 24.0 + beginDateLineSize.height + 2.0 + endDateLineSize.height + self.progressBarHeight + self.kCardOffsets.bottom
    }
}
