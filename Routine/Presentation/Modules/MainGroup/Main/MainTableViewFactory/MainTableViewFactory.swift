import UIKit

final class MainTableViewFactory: MainTableViewFactoryInterface {

    func mainCellViewModels(delegate: SectionCellViewModelDelegate) -> [RoutineTableViewCellViewModel] {
        return [
            self.makeRiskSection(delegate: delegate),
            self.makeCheckHealthSection(delegate: delegate),
            self.makeRecommendSection(delegate: delegate),
            self.makeDoctorClinicSection(delegate: delegate),
            self.makeMonitoringSection(delegate: delegate),
            self.makeCourseSection(delegate: delegate),
            self.makeArchiveSection(delegate: delegate),
            self.makeNotificationSection(delegate: delegate)
        ]
    }

    func makeRiskSection(delegate: SectionCellViewModelDelegate) -> RoutineTableViewCellViewModel {
        let viewModel = self.makeDevelopSection()
        viewModel.delegate = delegate
        viewModel.sectionViewModel.sectionImageViewModel.image = ImageProvider.mainModuleImages.percentIcon
        viewModel.sectionViewModel.sectionHeaderLabelModel.text = "risk_section_label"
        viewModel.sectionViewModel.sectionDescriptionLabelModel.text = "risk_section_description"
        viewModel.sectionDescriptionViewModel.descriptionLabelViewModel.text = "risk_description"
        return viewModel
    }

    func makeCheckHealthSection(delegate: SectionCellViewModelDelegate) -> RoutineTableViewCellViewModel {
        let viewModel = self.makeDevelopSection()
        viewModel.delegate = delegate
        viewModel.sectionViewModel.sectionImageViewModel.image = ImageProvider.mainModuleImages.drugsIcon
        viewModel.sectionViewModel.sectionHeaderLabelModel.text = "check_health_section_label"
        viewModel.sectionViewModel.sectionDescriptionLabelModel.text = "check_health_section_description"
        viewModel.sectionDescriptionViewModel.descriptionLabelViewModel.text = "check_health_description"
        return viewModel
    }

    func makeRecommendSection(delegate: SectionCellViewModelDelegate) -> RoutineTableViewCellViewModel {
        let viewModel = self.makeDevelopSection()
        viewModel.delegate = delegate
        viewModel.sectionViewModel.sectionImageViewModel.image = ImageProvider.mainModuleImages.drugsIcon
        viewModel.sectionViewModel.sectionHeaderLabelModel.text = "recommend_section_label"
        viewModel.sectionViewModel.sectionDescriptionLabelModel.text = "recommend_section_description"
        viewModel.sectionDescriptionViewModel.descriptionLabelViewModel.text = "recommend_description"
        return viewModel
    }

    func makeDoctorClinicSection(delegate: SectionCellViewModelDelegate) -> RoutineTableViewCellViewModel {
        let viewModel = self.makeDevelopSection()
        viewModel.delegate = delegate
        viewModel.sectionViewModel.sectionImageViewModel.image = ImageProvider.mainModuleImages.doctorClinicIcon
        viewModel.sectionViewModel.sectionHeaderLabelModel.text = "doctor_clinic_section_label"
        viewModel.sectionViewModel.sectionDescriptionLabelModel.text = "doctor_clinic_section_description"
        viewModel.sectionDescriptionViewModel.descriptionLabelViewModel.text = "doctor_clinic_description"
        return viewModel
    }

    func makeMonitoringSection(delegate: SectionCellViewModelDelegate) -> RoutineTableViewCellViewModel {
        let viewModel = self.makeDevelopSection()
        viewModel.delegate = delegate
        viewModel.sectionViewModel.sectionImageViewModel.image = ImageProvider.mainModuleImages.monitoringIcon
        viewModel.sectionViewModel.sectionHeaderLabelModel.text = "monitoring_section_label"
        viewModel.sectionViewModel.sectionDescriptionLabelModel.text = "monitoring_section_description"
        viewModel.sectionDescriptionViewModel.descriptionLabelViewModel.text = "monitoring_description"
        return viewModel
    }

    func makeCourseSection(delegate: SectionCellViewModelDelegate) -> RoutineTableViewCellViewModel {
        let viewModel = self.makeReleaseSection()
        viewModel.delegate = delegate
        viewModel.sectionViewModel.sectionImageViewModel.image = ImageProvider.mainModuleImages.drugsIcon
        viewModel.sectionViewModel.sectionHeaderLabelModel.text = "course_section_label"
        viewModel.sectionViewModel.sectionDescriptionLabelModel.text = "course_section_description"
        viewModel.sectionDescriptionViewModel.descriptionLabelViewModel.text = "course_description"
        return viewModel
    }

    func makeArchiveSection(delegate: SectionCellViewModelDelegate) -> RoutineTableViewCellViewModel {
        let viewModel = self.makeDevelopSection()
        viewModel.delegate = delegate
        viewModel.sectionViewModel.sectionImageViewModel.image = ImageProvider.mainModuleImages.archiveIcon
        viewModel.sectionViewModel.sectionHeaderLabelModel.text = "archive_section_label"
        viewModel.sectionViewModel.sectionDescriptionLabelModel.text = "archive_section_description"
        viewModel.sectionDescriptionViewModel.descriptionLabelViewModel.text = "archive_description"
        return viewModel
    }

    func makeNotificationSection(delegate: SectionCellViewModelDelegate) -> RoutineTableViewCellViewModel {
        let viewModel = self.makeDevelopSection()
        viewModel.delegate = delegate
        viewModel.sectionViewModel.sectionImageViewModel.image = ImageProvider.mainModuleImages.notificationIcon
        viewModel.sectionViewModel.sectionHeaderLabelModel.text = "notification_section_label"
        viewModel.sectionViewModel.sectionDescriptionLabelModel.text = "notification_section_description"
        viewModel.sectionDescriptionViewModel.descriptionLabelViewModel.text = "notification_description"
        return viewModel
    }

    func makeDevelopSection() -> SectionCellViewModel {
        let viewModel = SectionCellViewModel(routineDelegate: AppDelegate.serviceProvider.makeStringService())
        let blueViewColor = ColorProvider.mainModuleColors.blueViewColor
        let descriptionLabelViewModelFont = FontProvider.mainModuleFonts.sectionDescriptionLabel
        let descriptionLabelViewModelBackgroundColor = ColorProvider.mainModuleColors.whiteColor
        let sectionHeaderViewModel = viewModel.sectionHeaderViewModel
        let sectionViewModel = viewModel.sectionViewModel
        let sectionDescriptionViewModel = viewModel.sectionDescriptionViewModel

        viewModel.paddingOffsets = PaddingOffsets(top: 10.0, bottom: 10.0, left: 14.0, right: 14.0)
        viewModel.paddingViewCornerRadius = 5.0
        viewModel.contentViewColor = ColorProvider.mainModuleColors.whiteColor

        sectionHeaderViewModel.paddingOffsets = PaddingOffsets(top: 0.0, bottom: 0.0, left: 16.0, right: 16.0)
        sectionHeaderViewModel.infoIconViewModel.image = ImageProvider.mainModuleImages.infoIcon
        sectionHeaderViewModel.infoIconViewModel.contentMode = .scaleAspectFit
        sectionHeaderViewModel.infoIconViewModel.backgroundColor = blueViewColor
        sectionHeaderViewModel.textLabelViewModel.text = "section_in_develop"
        sectionHeaderViewModel.textLabelViewModel.textColor = ColorProvider.mainModuleColors.whiteColor
        sectionHeaderViewModel.textLabelViewModel.font = FontProvider.mainModuleFonts.sectionHeaderLabel
        sectionHeaderViewModel.textLabelViewModel.backgroundColor = blueViewColor
        sectionHeaderViewModel.backgroundColor = blueViewColor
        sectionHeaderViewModel.delegate = viewModel
        sectionHeaderViewModel.closeButtonViewModel.image = ImageProvider.mainModuleImages.questionIcon
        sectionHeaderViewModel.closeButtonViewModel.backgroundColor = blueViewColor

        sectionViewModel.paddingOffsets = PaddingOffsets(top: 16.0, bottom: 16.0, left: 20.0, right: 20.0)
        sectionViewModel.sectionImageViewModel.image = ImageProvider.mainModuleImages.notificationIcon
        sectionViewModel.sectionImageViewModel.contentMode = .scaleAspectFit
        sectionViewModel.sectionImageViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
        sectionViewModel.sectionHeaderLabelModel.textColor = ColorProvider.mainModuleColors.blackTextColor
        sectionViewModel.sectionHeaderLabelModel.font = FontProvider.mainModuleFonts.sectionLabel
        sectionViewModel.sectionHeaderLabelModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
        sectionViewModel.sectionHeaderLabelModel.numberOfLines = 0
        sectionViewModel.sectionDescriptionLabelModel.textColor = ColorProvider.mainModuleColors.blackTextColor
        sectionViewModel.sectionDescriptionLabelModel.font = FontProvider.mainModuleFonts.sectionDescriptionLabel
        sectionViewModel.sectionDescriptionLabelModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
        sectionViewModel.sectionDescriptionLabelModel.numberOfLines = 0
        sectionViewModel.sectionArrowImageViewModel.image = UIImage()
        sectionViewModel.sectionArrowImageViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor

        sectionDescriptionViewModel.paddingOffsets = PaddingOffsets(top: 16.0, bottom: 16.0, left: 20.0, right: 20.0)
        sectionDescriptionViewModel.descriptionLabelViewModel.textColor = ColorProvider.mainModuleColors.blackTextColor
        sectionDescriptionViewModel.descriptionLabelViewModel.font = descriptionLabelViewModelFont
        sectionDescriptionViewModel.descriptionLabelViewModel.backgroundColor = descriptionLabelViewModelBackgroundColor
        sectionDescriptionViewModel.descriptionLabelViewModel.numberOfLines = 0

        return viewModel
    }

    func makeReleaseSection() -> SectionCellViewModel {
        let viewModel = SectionCellViewModel(routineDelegate: AppDelegate.serviceProvider.makeStringService())
        let blueViewColor = ColorProvider.mainModuleColors.blueViewColor
        let descriptionLabelViewModelFont = FontProvider.mainModuleFonts.sectionDescriptionLabel
        let descriptionLabelViewModelBackgroundColor = ColorProvider.mainModuleColors.whiteColor
        let sectionHeaderViewModel = viewModel.sectionHeaderViewModel
        let sectionViewModel = viewModel.sectionViewModel
        let sectionDescriptionViewModel = viewModel.sectionDescriptionViewModel
        viewModel.paddingOffsets = PaddingOffsets(top: 10.0, bottom: 10.0, left: 14.0, right: 14.0)
        viewModel.paddingViewCornerRadius = 5.0
        viewModel.contentViewColor = ColorProvider.mainModuleColors.whiteColor
        sectionHeaderViewModel.paddingOffsets = PaddingOffsets(top: 0.0, bottom: 0.0, left: 16.0, right: 16.0)
        sectionHeaderViewModel.infoIconViewModel.image = ImageProvider.mainModuleImages.infoIcon
        sectionHeaderViewModel.infoIconViewModel.contentMode = .scaleAspectFit
        sectionHeaderViewModel.infoIconViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
        sectionHeaderViewModel.textLabelViewModel.textColor = ColorProvider.mainModuleColors.whiteColor
        sectionHeaderViewModel.delegate = viewModel
        sectionHeaderViewModel.closeButtonViewModel.image = ImageProvider.mainModuleImages.questionIcon
        sectionHeaderViewModel.closeButtonViewModel.tintColor = blueViewColor
        sectionViewModel.paddingOffsets = PaddingOffsets(top: 16.0, bottom: 16.0, left: 20.0, right: 20.0)
        sectionViewModel.sectionImageViewModel.image = ImageProvider.mainModuleImages.drugsIcon
        sectionViewModel.sectionImageViewModel.contentMode = .scaleAspectFit
        sectionViewModel.sectionImageViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
        sectionViewModel.sectionHeaderLabelModel.textColor = ColorProvider.mainModuleColors.blackTextColor
        sectionViewModel.sectionHeaderLabelModel.font = FontProvider.mainModuleFonts.sectionLabel
        sectionViewModel.sectionHeaderLabelModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
        sectionViewModel.sectionHeaderLabelModel.numberOfLines = 0
        sectionViewModel.sectionDescriptionLabelModel.textColor = ColorProvider.mainModuleColors.blackTextColor
        sectionViewModel.sectionDescriptionLabelModel.font = FontProvider.mainModuleFonts.sectionDescriptionLabel
        sectionViewModel.sectionDescriptionLabelModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
        sectionViewModel.sectionDescriptionLabelModel.numberOfLines = 0
        sectionViewModel.sectionArrowImageViewModel.image = ImageProvider.mainModuleImages.arrowIcon
        sectionViewModel.sectionArrowImageViewModel.backgroundColor = ColorProvider.mainModuleColors.whiteColor
        sectionDescriptionViewModel.paddingOffsets = PaddingOffsets(top: 16.0, bottom: 16.0, left: 20.0, right: 20.0)
        sectionDescriptionViewModel.descriptionLabelViewModel.textColor = ColorProvider.mainModuleColors.blackTextColor
        sectionDescriptionViewModel.descriptionLabelViewModel.font = descriptionLabelViewModelFont
        sectionDescriptionViewModel.descriptionLabelViewModel.backgroundColor = descriptionLabelViewModelBackgroundColor
        sectionDescriptionViewModel.descriptionLabelViewModel.numberOfLines = 0
        return viewModel
    }
}
