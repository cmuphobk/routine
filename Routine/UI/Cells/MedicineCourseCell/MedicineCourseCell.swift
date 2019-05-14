import UIKit

final class MedicineCourseCell: RoutineTableViewCell<MedicineCourseCellViewModel> {
    
    @IBOutlet weak private var cardView: UIView!
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var editButton: UIButton!
    @IBOutlet weak private var drugsListText: UILabel!
    @IBOutlet weak private var startDateLabel: UILabel!
    @IBOutlet weak private var startDateValue: UILabel!
    @IBOutlet weak private var endDateLabel: UILabel!
    @IBOutlet weak private var endDateValue: UILabel!
    @IBOutlet weak private var prograssBar: StandartProgressBar!
    
    @IBOutlet weak private var cardHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak private var progressBarHeightConstraint: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.cardHeightConstraint.constant = self.viewModel.calcCardContentHeight()
        self.progressBarHeightConstraint.constant = self.viewModel.progressBarHeight
        
        self.cardView?.aroundShadow()
        
        self.titleLabel.numberOfLines = 3
        self.titleLabel.font = FontProvider.medicineCourseFonts.titleLabel
        self.titleLabel.textColor = ColorProvider.medicineCourseColors.text
        
        self.drugsListText.font = FontProvider.medicineCourseFonts.drugsList
        
        self.startDateLabel.textColor = ColorProvider.medicineCourseColors.noteText
        self.startDateLabel.font = FontProvider.medicineCourseFonts.dateLabel
        self.startDateValue.textColor = ColorProvider.medicineCourseColors.text
        self.startDateValue.font = FontProvider.medicineCourseFonts.dateLabel
        
        self.endDateLabel.textColor = ColorProvider.medicineCourseColors.noteText
        self.endDateLabel.font = FontProvider.medicineCourseFonts.dateLabel
        self.endDateValue.textColor = ColorProvider.medicineCourseColors.text
        self.endDateValue.font = FontProvider.medicineCourseFonts.dateLabel
        
        if self.viewModel.drugNames.isEmpty {
            self.startDateValue.isHidden = true
            self.endDateValue.isHidden = true
            self.prograssBar.isHidden = true
        } else {
            self.startDateValue.isHidden = false
            self.endDateValue.isHidden = false
            self.prograssBar.isHidden = false
        }
        
        if self.viewModel.isArchive {
            self.editButton.isHidden = true
        } else {
            self.editButton.isHidden = false
        }
    }
    
    override func localizationSetup() {
        self.titleLabel.text = self.viewModel.name
        
        // Форматируем список таблеток
        let drugsListAttrString: NSMutableAttributedString = NSMutableAttributedString()
        let drugsNoteAttributes = [ NSAttributedString.Key.foregroundColor: ColorProvider.medicineCourseColors.noteText,
                                    NSAttributedString.Key.font: FontProvider.medicineCourseFonts.drugsList ]
        let drugsListAttributes = [ NSAttributedString.Key.foregroundColor: ColorProvider.medicineCourseColors.text,
                                    NSAttributedString.Key.font: FontProvider.medicineCourseFonts.drugsList ]

        drugsListAttrString.append(NSAttributedString(string: "\(self.viewModel.routineDelegate?.localize("drugs") ?? ""): ",
            attributes: drugsNoteAttributes))
        
        drugsListAttrString.append(NSAttributedString(string: self.viewModel.drugNames,
                               attributes: drugsListAttributes))
        self.drugsListText.attributedText = drugsListAttrString
        
        // Определяем минимальную и максимальную дату из лекарств
        let startDate1970 = self.viewModel.drugs.map { (item) -> Int in return item.startDate }.min()
        let endDate1970 = self.viewModel.drugs.map { (item) -> Int in return (item.endDate ?? 0) }.max()
        
        let startDate = Date(timeIntervalSince1970: Double(startDate1970 ?? 0) / 1000.0)
        let endDate = Date(timeIntervalSince1970: Double(endDate1970 ?? 0) / 1000.0)
        
        self.startDateLabel.text = self.viewModel.routineDelegate?.localize("course_start") ?? ""
        self.startDateValue.text = self.viewModel.dateService.localizeDateString(date: startDate, format: "dd.MM.yyyy")
        self.endDateLabel.text = self.viewModel.routineDelegate?.localize("course_end") ?? ""
        self.endDateValue.text = self.viewModel.dateService.localizeDateString(date: endDate, format: "dd.MM.yyyy")
        
        self.prograssBar.progress = Float( Date.calcPercentPartByToday(fromDate: startDate, toDate: endDate) )
    }
    
    @IBAction private func editButtonDidPressed(_ sender: Any) {
        self.viewModel.delegate?.rowDidRenamed(cellObj: self.viewModel)
    }
    
    @IBAction private func deleteButtonDidPressed(_ sender: Any) {
        self.viewModel.delegate?.rowDidRemoved(cellObj: self.viewModel)
    }
    
}
