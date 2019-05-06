import UIKit

final class DrugCell: RoutineTableViewCell<DrugCellViewModel> {
    
    @IBOutlet weak var drugImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var times: UILabel!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.contentView.backgroundColor = self.viewModel.isOver ? ColorProvider.medicineCourseColors.overDrugBackground : ColorProvider.medicineCourseColors.currentDrugBackground
        
        self.drugImage.image = MedicineType.imageBy(self.viewModel.type)
        
        self.name.font = FontProvider.medicineCourseFonts.drugName
        self.name.textColor = ColorProvider.medicineCourseColors.drugName
        
        self.times.font = FontProvider.medicineCourseFonts.drugTimes
        self.times.textColor = ColorProvider.medicineCourseColors.drugTimes
    }
    
    override func localizationSetup() {
        self.name.text = self.viewModel.name
        self.times.text = self.viewModel.times
    }

}
