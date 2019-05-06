import UIKit

final class DrugCellViewModel: RoutineTableViewCellViewModel {
    let kContentOffsets: Offsets = Offsets(top: 20.0, bottom: 16.0, left: 56.0, right: 58.0)
    
    let type: MedicineType
    let name: String
    let times: String
    let isOver: Bool
    
    init(type: MedicineType, name: String, times: String, isOver: Bool) {
        self.type = type
        self.name = name
        self.times = times
        self.isOver = isOver
        
        super.init()
    }
    
    override var reuseIdentifier: String {
        return "DrugCell"
    }
    
    override var cellOwner: CellOwner {
        return .nib(value: UINib(nibName: self.reuseIdentifier, bundle: nil))
    }
    
    override func heightForWidth(_ width: CGFloat) -> CGFloat {
        let leftAndRightOffset: CGFloat =  self.kContentOffsets.left + self.kContentOffsets.right
        
        let nameSize = FontProvider.medicineCourseFonts.drugName.sizeOfString(string: self.name, constrainedToWidth: Double(width - leftAndRightOffset) )
        let timesSize = FontProvider.medicineCourseFonts.drugTimes.sizeOfString(string: self.times, constrainedToWidth: Double(width - (self.kContentOffsets.left + 42 + 96) ) )
        
        return self.kContentOffsets.top + nameSize.height + 12 + timesSize.height + self.kContentOffsets.bottom
    }
    
}
