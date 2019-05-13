import UIKit

final class MainTableViewFactory {
    
    static func mainCellViewModels(delegate: SectionCellViewModelDelegate) -> [SectionCellViewModel] {
        var cellObjs: [SectionCellViewModel] = []
        
        if true {
            let cellObj = SectionCellViewModel(routineDelegate: AppDelegate.serviceProvider.makeStringService())
            
            cellObj.delegate = delegate
            
            cellObj.paddingOffsets = Offsets(top: 20.0, bottom: 10.0, left: 14.0, right: 14.0)
            cellObj.paddingViewCornerRadius = 5.0
            
            cellObj.sectionHeaderViewModel.paddingOffsets = Offsets(top: 0.0, bottom: 0.0, left: 16.0, right: 16.0)
            cellObj.sectionHeaderViewModel.infoIconViewModel.image = ImageProvider.mainModuleImages.infoIcon
            cellObj.sectionHeaderViewModel.infoIconViewModel.contentMode = .scaleAspectFit
            cellObj.sectionHeaderViewModel.infoIconViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.textLabelViewModel.text = "section_in_develop"
            cellObj.sectionHeaderViewModel.textLabelViewModel.textColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionHeaderViewModel.textLabelViewModel.font = FontProvider.mainModuleFonts.sectionHeaderLabel
            cellObj.sectionHeaderViewModel.textLabelViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.delegate = cellObj
            
            cellObj.sectionHeaderViewModel.closeButtonViewModel.image = ImageProvider.mainModuleImages.questionIcon
            cellObj.sectionHeaderViewModel.closeButtonViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            
            cellObj.sectionViewModel.paddingOffsets = Offsets(top: 16.0, bottom: 16.0, left: 20.0, right: 20.0)
            cellObj.sectionViewModel.sectionImageViewModel.image = ImageProvider.mainModuleImages.percentIcon
            cellObj.sectionViewModel.sectionImageViewModel.contentMode = .scaleAspectFit
            cellObj.sectionViewModel.sectionImageViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionViewModel.sectionHeaderLabelModel.text = "risk_section_label"
            cellObj.sectionViewModel.sectionHeaderLabelModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionViewModel.sectionHeaderLabelModel.font = FontProvider.mainModuleFonts.sectionLabel
            cellObj.sectionViewModel.sectionHeaderLabelModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionViewModel.sectionHeaderLabelModel.numberOfLines = 0
            
            cellObj.sectionViewModel.sectionDescriptionLabelModel.text = "risk_section_description"
            cellObj.sectionViewModel.sectionDescriptionLabelModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionViewModel.sectionDescriptionLabelModel.font = FontProvider.mainModuleFonts.sectionDescriptionLabel
            cellObj.sectionViewModel.sectionDescriptionLabelModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionViewModel.sectionDescriptionLabelModel.numberOfLines = 0
            
            cellObj.sectionViewModel.sectionArrowImageViewModel.image = UIImage()
            cellObj.sectionViewModel.sectionArrowImageViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionDescriptionViewModel.paddingOffsets = Offsets(top: 16.0, bottom: 16.0, left: 20.0, right: 20.0)
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.text = "risk_description"
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.font = FontProvider.mainModuleFonts.sectionDescriptionLabel
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.numberOfLines = 0
            
            cellObjs += [cellObj]
        }
        
        if true {
            let cellObj = SectionCellViewModel(routineDelegate: AppDelegate.serviceProvider.makeStringService())
            
            cellObj.delegate = delegate
            
            cellObj.paddingOffsets = Offsets(top: 10.0, bottom: 10.0, left: 14.0, right: 14.0)
            cellObj.paddingViewCornerRadius = 5.0
            
            cellObj.sectionHeaderViewModel.paddingOffsets = Offsets(top: 0.0, bottom: 0.0, left: 16.0, right: 16.0)
            cellObj.sectionHeaderViewModel.infoIconViewModel.image = ImageProvider.mainModuleImages.infoIcon
            cellObj.sectionHeaderViewModel.infoIconViewModel.contentMode = .scaleAspectFit
            cellObj.sectionHeaderViewModel.infoIconViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.textLabelViewModel.text = "section_in_develop"
            cellObj.sectionHeaderViewModel.textLabelViewModel.textColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionHeaderViewModel.textLabelViewModel.font = FontProvider.mainModuleFonts.sectionHeaderLabel
            cellObj.sectionHeaderViewModel.textLabelViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.delegate = cellObj
            
            cellObj.sectionHeaderViewModel.closeButtonViewModel.image = ImageProvider.mainModuleImages.questionIcon
            cellObj.sectionHeaderViewModel.closeButtonViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            
            cellObj.sectionViewModel.paddingOffsets = Offsets(top: 16.0, bottom: 16.0, left: 20.0, right: 20.0)
            cellObj.sectionViewModel.sectionImageViewModel.image = ImageProvider.mainModuleImages.drugsIcon
            cellObj.sectionViewModel.sectionImageViewModel.contentMode = .scaleAspectFit
            cellObj.sectionViewModel.sectionImageViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionViewModel.sectionHeaderLabelModel.text = "check_health_section_label"
            cellObj.sectionViewModel.sectionHeaderLabelModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionViewModel.sectionHeaderLabelModel.font = FontProvider.mainModuleFonts.sectionLabel
            cellObj.sectionViewModel.sectionHeaderLabelModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionViewModel.sectionHeaderLabelModel.numberOfLines = 0
            
            cellObj.sectionViewModel.sectionDescriptionLabelModel.text = "check_health_section_description"
            cellObj.sectionViewModel.sectionDescriptionLabelModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionViewModel.sectionDescriptionLabelModel.font = FontProvider.mainModuleFonts.sectionDescriptionLabel
            cellObj.sectionViewModel.sectionDescriptionLabelModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionViewModel.sectionDescriptionLabelModel.numberOfLines = 0
            
            cellObj.sectionViewModel.sectionArrowImageViewModel.image = UIImage()
            cellObj.sectionViewModel.sectionArrowImageViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionDescriptionViewModel.paddingOffsets = Offsets(top: 16.0, bottom: 16.0, left: 20.0, right: 20.0)
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.text = "check_health_description"
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.font = FontProvider.mainModuleFonts.sectionDescriptionLabel
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.numberOfLines = 0
            
            cellObjs += [cellObj]
        }
        
        if true {
            let cellObj = SectionCellViewModel(routineDelegate: AppDelegate.serviceProvider.makeStringService())
            
            cellObj.delegate = delegate
            
            cellObj.paddingOffsets = Offsets(top: 10.0, bottom: 20.0, left: 14.0, right: 14.0)
            cellObj.paddingViewCornerRadius = 5.0
            
            cellObj.sectionHeaderViewModel.paddingOffsets = Offsets(top: 0.0, bottom: 0.0, left: 16.0, right: 16.0)
            cellObj.sectionHeaderViewModel.infoIconViewModel.image = ImageProvider.mainModuleImages.infoIcon
            cellObj.sectionHeaderViewModel.infoIconViewModel.contentMode = .scaleAspectFit
            cellObj.sectionHeaderViewModel.infoIconViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.textLabelViewModel.text = "section_in_develop"
            cellObj.sectionHeaderViewModel.textLabelViewModel.textColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionHeaderViewModel.textLabelViewModel.font = FontProvider.mainModuleFonts.sectionHeaderLabel
            cellObj.sectionHeaderViewModel.textLabelViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.delegate = cellObj
            
            cellObj.sectionHeaderViewModel.closeButtonViewModel.image = ImageProvider.mainModuleImages.questionIcon
            cellObj.sectionHeaderViewModel.closeButtonViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            
            cellObj.sectionViewModel.paddingOffsets = Offsets(top: 16.0, bottom: 16.0, left: 20.0, right: 20.0)
            cellObj.sectionViewModel.sectionImageViewModel.image = ImageProvider.mainModuleImages.drugsIcon
            cellObj.sectionViewModel.sectionImageViewModel.contentMode = .scaleAspectFit
            cellObj.sectionViewModel.sectionImageViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionViewModel.sectionHeaderLabelModel.text = "recommend_section_label"
            cellObj.sectionViewModel.sectionHeaderLabelModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionViewModel.sectionHeaderLabelModel.font = FontProvider.mainModuleFonts.sectionLabel
            cellObj.sectionViewModel.sectionHeaderLabelModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionViewModel.sectionHeaderLabelModel.numberOfLines = 0
            
            cellObj.sectionViewModel.sectionDescriptionLabelModel.text = "recommend_section_description"
            cellObj.sectionViewModel.sectionDescriptionLabelModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionViewModel.sectionDescriptionLabelModel.font = FontProvider.mainModuleFonts.sectionDescriptionLabel
            cellObj.sectionViewModel.sectionDescriptionLabelModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionViewModel.sectionDescriptionLabelModel.numberOfLines = 0
            
            cellObj.sectionViewModel.sectionArrowImageViewModel.image = UIImage()
            cellObj.sectionViewModel.sectionArrowImageViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionDescriptionViewModel.paddingOffsets = Offsets(top: 16.0, bottom: 16.0, left: 20.0, right: 20.0)
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.text = "recommend_description"
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.font = FontProvider.mainModuleFonts.sectionDescriptionLabel
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.numberOfLines = 0
            
            cellObjs += [cellObj]
        }

        if true {
            let cellObj = SectionCellViewModel(routineDelegate: AppDelegate.serviceProvider.makeStringService())
            
            cellObj.delegate = delegate
            
            cellObj.paddingOffsets = Offsets(top: 20.0, bottom: 10.0, left: 14.0, right: 14.0)
            cellObj.paddingViewCornerRadius = 5.0
            cellObj.contentViewColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionHeaderViewModel.paddingOffsets = Offsets(top: 0.0, bottom: 0.0, left: 16.0, right: 16.0)
            cellObj.sectionHeaderViewModel.infoIconViewModel.image = ImageProvider.mainModuleImages.infoIcon
            cellObj.sectionHeaderViewModel.infoIconViewModel.contentMode = .scaleAspectFit
            cellObj.sectionHeaderViewModel.infoIconViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.textLabelViewModel.text = "section_in_develop"
            cellObj.sectionHeaderViewModel.textLabelViewModel.textColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionHeaderViewModel.textLabelViewModel.font = FontProvider.mainModuleFonts.sectionHeaderLabel
            cellObj.sectionHeaderViewModel.textLabelViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.delegate = cellObj
            
            cellObj.sectionHeaderViewModel.closeButtonViewModel.image = ImageProvider.mainModuleImages.questionIcon
            cellObj.sectionHeaderViewModel.closeButtonViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            
            cellObj.sectionViewModel.paddingOffsets = Offsets(top: 16.0, bottom: 16.0, left: 20.0, right: 20.0)
            cellObj.sectionViewModel.sectionImageViewModel.image = ImageProvider.mainModuleImages.doctorClinicIcon
            cellObj.sectionViewModel.sectionImageViewModel.contentMode = .scaleAspectFit
            cellObj.sectionViewModel.sectionImageViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionViewModel.sectionHeaderLabelModel.text = "doctor_clinic_section_label"
            cellObj.sectionViewModel.sectionHeaderLabelModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionViewModel.sectionHeaderLabelModel.font = FontProvider.mainModuleFonts.sectionLabel
            cellObj.sectionViewModel.sectionHeaderLabelModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionViewModel.sectionHeaderLabelModel.numberOfLines = 0
            
            cellObj.sectionViewModel.sectionDescriptionLabelModel.text = "doctor_clinic_section_description"
            cellObj.sectionViewModel.sectionDescriptionLabelModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionViewModel.sectionDescriptionLabelModel.font = FontProvider.mainModuleFonts.sectionDescriptionLabel
            cellObj.sectionViewModel.sectionDescriptionLabelModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionViewModel.sectionDescriptionLabelModel.numberOfLines = 0
            
            cellObj.sectionViewModel.sectionArrowImageViewModel.image = UIImage()
            cellObj.sectionViewModel.sectionArrowImageViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionDescriptionViewModel.paddingOffsets = Offsets(top: 16.0, bottom: 16.0, left: 20.0, right: 20.0)
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.text = "doctor_clinic_description"
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.font = FontProvider.mainModuleFonts.sectionDescriptionLabel
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.numberOfLines = 0
            
            cellObjs += [cellObj]
        }
        
        if true {
            let cellObj = SectionCellViewModel(routineDelegate: AppDelegate.serviceProvider.makeStringService())
            
            cellObj.delegate = delegate
            
            cellObj.paddingOffsets = Offsets(top: 10.0, bottom: 10.0, left: 14.0, right: 14.0)
            cellObj.paddingViewCornerRadius = 5.0
            cellObj.contentViewColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionHeaderViewModel.paddingOffsets = Offsets(top: 0.0, bottom: 0.0, left: 16.0, right: 16.0)
            cellObj.sectionHeaderViewModel.infoIconViewModel.image = ImageProvider.mainModuleImages.infoIcon
            cellObj.sectionHeaderViewModel.infoIconViewModel.contentMode = .scaleAspectFit
            cellObj.sectionHeaderViewModel.infoIconViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.textLabelViewModel.text = "section_in_develop"
            cellObj.sectionHeaderViewModel.textLabelViewModel.textColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionHeaderViewModel.textLabelViewModel.font = FontProvider.mainModuleFonts.sectionHeaderLabel
            cellObj.sectionHeaderViewModel.textLabelViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.delegate = cellObj
            
            cellObj.sectionHeaderViewModel.closeButtonViewModel.image = ImageProvider.mainModuleImages.questionIcon
            cellObj.sectionHeaderViewModel.closeButtonViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            
            cellObj.sectionViewModel.paddingOffsets = Offsets(top: 16.0, bottom: 16.0, left: 20.0, right: 20.0)
            cellObj.sectionViewModel.sectionImageViewModel.image = ImageProvider.mainModuleImages.monitoringIcon
            cellObj.sectionViewModel.sectionImageViewModel.contentMode = .scaleAspectFit
            cellObj.sectionViewModel.sectionImageViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionViewModel.sectionHeaderLabelModel.text = "monitoring_section_label"
            cellObj.sectionViewModel.sectionHeaderLabelModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionViewModel.sectionHeaderLabelModel.font = FontProvider.mainModuleFonts.sectionLabel
            cellObj.sectionViewModel.sectionHeaderLabelModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionViewModel.sectionHeaderLabelModel.numberOfLines = 0
            
            cellObj.sectionViewModel.sectionDescriptionLabelModel.text = "monitoring_section_description"
            cellObj.sectionViewModel.sectionDescriptionLabelModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionViewModel.sectionDescriptionLabelModel.font = FontProvider.mainModuleFonts.sectionDescriptionLabel
            cellObj.sectionViewModel.sectionDescriptionLabelModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionViewModel.sectionDescriptionLabelModel.numberOfLines = 0
            
            cellObj.sectionViewModel.sectionArrowImageViewModel.image = UIImage()
            cellObj.sectionViewModel.sectionArrowImageViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionDescriptionViewModel.paddingOffsets = Offsets(top: 16.0, bottom: 16.0, left: 20.0, right: 20.0)
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.text = "monitoring_description"
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.font = FontProvider.mainModuleFonts.sectionDescriptionLabel
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.numberOfLines = 0
            
            cellObjs += [cellObj]
        }
        
        if true {
            let cellObj = SectionCellViewModel(routineDelegate: AppDelegate.serviceProvider.makeStringService())
            cellObj.viewName = kMedicineCourseModuleId
            
            cellObj.delegate = delegate
            
            cellObj.paddingOffsets = Offsets(top: 10.0, bottom: 10.0, left: 14.0, right: 14.0)
            cellObj.paddingViewCornerRadius = 5.0
            cellObj.contentViewColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionHeaderViewModel.paddingOffsets = Offsets(top: 0.0, bottom: 0.0, left: 16.0, right: 16.0)
            cellObj.sectionHeaderViewModel.infoIconViewModel.image = ImageProvider.mainModuleImages.infoIcon
            cellObj.sectionHeaderViewModel.infoIconViewModel.contentMode = .scaleAspectFit
            cellObj.sectionHeaderViewModel.infoIconViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionHeaderViewModel.textLabelViewModel.textColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionHeaderViewModel.delegate = cellObj
            
            cellObj.sectionHeaderViewModel.closeButtonViewModel.image = ImageProvider.mainModuleImages.questionIcon
            cellObj.sectionHeaderViewModel.closeButtonViewModel.tintColor = ColorProvider.mainModuleColors.blueViewColor
            
            cellObj.sectionViewModel.paddingOffsets = Offsets(top: 16.0, bottom: 16.0, left: 20.0, right: 20.0)
            cellObj.sectionViewModel.sectionImageViewModel.image = ImageProvider.mainModuleImages.drugsIcon
            cellObj.sectionViewModel.sectionImageViewModel.contentMode = .scaleAspectFit
            cellObj.sectionViewModel.sectionImageViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionViewModel.sectionHeaderLabelModel.text = "course_section_label"
            cellObj.sectionViewModel.sectionHeaderLabelModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionViewModel.sectionHeaderLabelModel.font = FontProvider.mainModuleFonts.sectionLabel
            cellObj.sectionViewModel.sectionHeaderLabelModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionViewModel.sectionHeaderLabelModel.numberOfLines = 0
            
            cellObj.sectionViewModel.sectionDescriptionLabelModel.text = "course_section_description"
            cellObj.sectionViewModel.sectionDescriptionLabelModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionViewModel.sectionDescriptionLabelModel.font = FontProvider.mainModuleFonts.sectionDescriptionLabel
            cellObj.sectionViewModel.sectionDescriptionLabelModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionViewModel.sectionDescriptionLabelModel.numberOfLines = 0
            
            cellObj.sectionViewModel.sectionArrowImageViewModel.image = ImageProvider.mainModuleImages.arrowIcon
            cellObj.sectionViewModel.sectionArrowImageViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionDescriptionViewModel.paddingOffsets = Offsets(top: 16.0, bottom: 16.0, left: 20.0, right: 20.0)
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.text = "course_description"
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.font = FontProvider.mainModuleFonts.sectionDescriptionLabel
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.numberOfLines = 0
            
            cellObjs += [cellObj]
        }
        
        if true {
            let cellObj = SectionCellViewModel(routineDelegate: AppDelegate.serviceProvider.makeStringService())
            
            cellObj.delegate = delegate
            
            cellObj.paddingOffsets = Offsets(top: 10.0, bottom: 10.0, left: 14.0, right: 14.0)
            cellObj.paddingViewCornerRadius = 5.0
            cellObj.contentViewColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionHeaderViewModel.paddingOffsets = Offsets(top: 0.0, bottom: 0.0, left: 16.0, right: 16.0)
            cellObj.sectionHeaderViewModel.infoIconViewModel.image = ImageProvider.mainModuleImages.infoIcon
            cellObj.sectionHeaderViewModel.infoIconViewModel.contentMode = .scaleAspectFit
            cellObj.sectionHeaderViewModel.infoIconViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.textLabelViewModel.text = "section_in_develop"
            cellObj.sectionHeaderViewModel.textLabelViewModel.textColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionHeaderViewModel.textLabelViewModel.font = FontProvider.mainModuleFonts.sectionHeaderLabel
            cellObj.sectionHeaderViewModel.textLabelViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.delegate = cellObj
            
            cellObj.sectionHeaderViewModel.closeButtonViewModel.image = ImageProvider.mainModuleImages.questionIcon
            cellObj.sectionHeaderViewModel.closeButtonViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            
            cellObj.sectionViewModel.paddingOffsets = Offsets(top: 16.0, bottom: 16.0, left: 20.0, right: 20.0)
            cellObj.sectionViewModel.sectionImageViewModel.image = ImageProvider.mainModuleImages.archiveIcon
            cellObj.sectionViewModel.sectionImageViewModel.contentMode = .scaleAspectFit
            cellObj.sectionViewModel.sectionImageViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionViewModel.sectionHeaderLabelModel.text = "archive_section_label"
            cellObj.sectionViewModel.sectionHeaderLabelModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionViewModel.sectionHeaderLabelModel.font = FontProvider.mainModuleFonts.sectionLabel
            cellObj.sectionViewModel.sectionHeaderLabelModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionViewModel.sectionHeaderLabelModel.numberOfLines = 0
            
            cellObj.sectionViewModel.sectionDescriptionLabelModel.text = "archive_section_description"
            cellObj.sectionViewModel.sectionDescriptionLabelModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionViewModel.sectionDescriptionLabelModel.font = FontProvider.mainModuleFonts.sectionDescriptionLabel
            cellObj.sectionViewModel.sectionDescriptionLabelModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionViewModel.sectionDescriptionLabelModel.numberOfLines = 0
            
            cellObj.sectionViewModel.sectionArrowImageViewModel.image = UIImage()
            cellObj.sectionViewModel.sectionArrowImageViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionDescriptionViewModel.paddingOffsets = Offsets(top: 16.0, bottom: 16.0, left: 20.0, right: 20.0)
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.text = "archive_description"
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.font = FontProvider.mainModuleFonts.sectionDescriptionLabel
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.numberOfLines = 0
            
            cellObjs += [cellObj]
        }
        
        if true {
            let cellObj = SectionCellViewModel(routineDelegate: AppDelegate.serviceProvider.makeStringService())
            
            cellObj.delegate = delegate
            
            cellObj.paddingOffsets = Offsets(top: 10.0, bottom: 10.0, left: 14.0, right: 14.0)
            cellObj.paddingViewCornerRadius = 5.0
            cellObj.contentViewColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionHeaderViewModel.paddingOffsets = Offsets(top: 0.0, bottom: 0.0, left: 16.0, right: 16.0)
            cellObj.sectionHeaderViewModel.infoIconViewModel.image = ImageProvider.mainModuleImages.infoIcon
            cellObj.sectionHeaderViewModel.infoIconViewModel.contentMode = .scaleAspectFit
            cellObj.sectionHeaderViewModel.infoIconViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.textLabelViewModel.text = "section_in_develop"
            cellObj.sectionHeaderViewModel.textLabelViewModel.textColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionHeaderViewModel.textLabelViewModel.font = FontProvider.mainModuleFonts.sectionHeaderLabel
            cellObj.sectionHeaderViewModel.textLabelViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            cellObj.sectionHeaderViewModel.delegate = cellObj
            
            cellObj.sectionHeaderViewModel.closeButtonViewModel.image = ImageProvider.mainModuleImages.questionIcon
            cellObj.sectionHeaderViewModel.closeButtonViewModel.backgroundColor = ColorProvider.mainModuleColors.blueViewColor
            
            cellObj.sectionViewModel.paddingOffsets = Offsets(top: 16.0, bottom: 16.0, left: 20.0, right: 20.0)
            cellObj.sectionViewModel.sectionImageViewModel.image = ImageProvider.mainModuleImages.notificationIcon
            cellObj.sectionViewModel.sectionImageViewModel.contentMode = .scaleAspectFit
            cellObj.sectionViewModel.sectionImageViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionViewModel.sectionHeaderLabelModel.text = "notification_section_label"
            cellObj.sectionViewModel.sectionHeaderLabelModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionViewModel.sectionHeaderLabelModel.font = FontProvider.mainModuleFonts.sectionLabel
            cellObj.sectionViewModel.sectionHeaderLabelModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionViewModel.sectionHeaderLabelModel.numberOfLines = 0
            
            cellObj.sectionViewModel.sectionDescriptionLabelModel.text = "notification_section_description"
            cellObj.sectionViewModel.sectionDescriptionLabelModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionViewModel.sectionDescriptionLabelModel.font = FontProvider.mainModuleFonts.sectionDescriptionLabel
            cellObj.sectionViewModel.sectionDescriptionLabelModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionViewModel.sectionDescriptionLabelModel.numberOfLines = 0
            
            cellObj.sectionViewModel.sectionArrowImageViewModel.image = UIImage()
            cellObj.sectionViewModel.sectionArrowImageViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            
            cellObj.sectionDescriptionViewModel.paddingOffsets = Offsets(top: 16.0, bottom: 16.0, left: 20.0, right: 20.0)
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.text = "notification_description"
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.textColor = ColorProvider.mainModuleColors.blackTextColor
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.font = FontProvider.mainModuleFonts.sectionDescriptionLabel
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
            cellObj.sectionDescriptionViewModel.descriptionLabelViewModel.numberOfLines = 0
            
            cellObjs += [cellObj]
        }
        
        return cellObjs
    }
    
}
