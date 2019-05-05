import UIKit

final class DrugEditTableViewFactory {
    
    static func makeCellViewModelsBeforeTimes(model: MedicineDrug?, delegate: TextFieldCellProtocol & TwiceComboboxCellProtocol & SingleButtonCellProtocol & TextAreaCellProtocol & ComboboxCellProtocol) -> [LocalizedTableViewCellViewModel] {
        var cellViewModels: [LocalizedTableViewCellViewModel] = []
        
        // Общие данные
        let labelCellViewModel = LabelCellViewModel()
        
        labelCellViewModel.paddingOffsets = Offsets(top: 16.0, bottom: 8.0, left: 8.0, right: 8.0)
        
        let generalLabelCfg = LocalizedLabelViewModel()
        generalLabelCfg.text = "str_drugedit_general_data"
        generalLabelCfg.textColor = ColorProvider.medicineCourseColors.noteText
        generalLabelCfg.font = FontProvider.medicineCourseFonts.general
        
        labelCellViewModel.labelConfiguration = generalLabelCfg
        cellViewModels += [labelCellViewModel]
        
        // Наименование
        let drugNameField = LocalizedTextFieldViewModel()
        drugNameField.text = model?.name ?? ""
        drugNameField.textColor = ColorProvider.medicineCourseColors.text
        drugNameField.font = FontProvider.medicineCourseFonts.general
        drugNameField.placeholderText = "str_drugedit_name_placeholder"
        drugNameField.borderStyle = .roundedRect
        
        let textFieldCellViewModel = TextFieldCellViewModel(textFieldConfiguration: drugNameField, delegate: delegate)
        textFieldCellViewModel.paddingOffsets = Offsets(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0)
        cellViewModels += [textFieldCellViewModel]
        
        // Тип и ЕдИзмерения
        
        let twiceComboboxCellViewModel = TwiceComboboxCellViewModel(delegate: delegate)
        twiceComboboxCellViewModel.paddingOffsets = Offsets(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0)
        twiceComboboxCellViewModel.betweenSpace = 16.0
        twiceComboboxCellViewModel.betweenPosition = 0.4
        
        let typeComboboxCfg = LocalizedComboboxViewModel()
        typeComboboxCfg.viewName = "drug_type"
        if let type = model?.type {
            typeComboboxCfg.textFieldViewModel.text = type.toString()
        } else {
            typeComboboxCfg.textFieldViewModel.text = ""
        }
        typeComboboxCfg.textFieldViewModel.textColor = ColorProvider.medicineCourseColors.text
        typeComboboxCfg.textFieldViewModel.font = FontProvider.medicineCourseFonts.general
        typeComboboxCfg.textFieldViewModel.placeholderText = "str_drugedit_type_placeholder"
        typeComboboxCfg.textFieldViewModel.borderStyle = .roundedRect
        typeComboboxCfg.markViewModel.image = ImageProvider.default.triangleToBottom
    
        let unitComboboxCfg = LocalizedComboboxViewModel()
        unitComboboxCfg.viewName = "drug_unit"
        if let unit = model?.unit {
            unitComboboxCfg.textFieldViewModel.text = unit.toString()
        } else {
            unitComboboxCfg.textFieldViewModel.text = ""
        }
        unitComboboxCfg.textFieldViewModel.textColor = ColorProvider.medicineCourseColors.text
        unitComboboxCfg.textFieldViewModel.font = FontProvider.medicineCourseFonts.general
        unitComboboxCfg.textFieldViewModel.placeholderText = "str_drugedit_unit_placeholder"
        unitComboboxCfg.textFieldViewModel.borderStyle = .roundedRect
        unitComboboxCfg.markViewModel.image = ImageProvider.default.triangleToBottom
        
        twiceComboboxCellViewModel.leftCombobox = typeComboboxCfg
        twiceComboboxCellViewModel.rightCombobox = unitComboboxCfg
        cellViewModels += [twiceComboboxCellViewModel]
        
        // Продолжительность приема
        let longtimeLabelcell = LabelCellViewModel()
        
        longtimeLabelcell.paddingOffsets = Offsets(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0)
        
        let longtimeLabelCfg = LocalizedLabelViewModel()
        longtimeLabelCfg.text = "str_drugedit_longtime_data"
        longtimeLabelCfg.textColor = ColorProvider.medicineCourseColors.noteText
        longtimeLabelCfg.font = FontProvider.medicineCourseFonts.general
        
        longtimeLabelcell.labelConfiguration = longtimeLabelCfg
        cellViewModels += [longtimeLabelcell]
        
        // Начало и Конец приема
        let beginEndComboboxCellViewModel = TwiceComboboxCellViewModel(delegate: delegate)
        
        beginEndComboboxCellViewModel.paddingOffsets = Offsets(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0)
        beginEndComboboxCellViewModel.betweenSpace = 16.0
        beginEndComboboxCellViewModel.betweenPosition = 0.5
        
        let beginComboboxCfg = LocalizedComboboxViewModel()
        beginComboboxCfg.viewName = "start_using"
        if let beginDate = model?.startDate {
            beginComboboxCfg.textFieldViewModel.text = Date(timeIntervalSince1970: Double(beginDate / 1000)).format(with: "dd.MM.yyyy")
        } else {
            beginComboboxCfg.textFieldViewModel.text = ""
        }
        beginComboboxCfg.textFieldViewModel.textColor = ColorProvider.medicineCourseColors.text
        beginComboboxCfg.textFieldViewModel.font = FontProvider.medicineCourseFonts.general
        beginComboboxCfg.textFieldViewModel.placeholderText = "str_drugedit_begin_use_placeholder"
        beginComboboxCfg.textFieldViewModel.borderStyle = .roundedRect
        beginComboboxCfg.markViewModel.image = ImageProvider.default.triangleToBottom
        
        let endComboboxCfg = LocalizedComboboxViewModel()
        endComboboxCfg.viewName = "end_using"
        endComboboxCfg.textFieldViewModel.text = ""
        if let endingType = model?.endingCourseType, let endingValue = model?.endingCourseValue {
            endComboboxCfg.textFieldViewModel.text = EndingCourseType.pluralsStringBy(endingType, count: endingValue)
        } else {
            endComboboxCfg.textFieldViewModel.text = ""
        }
        endComboboxCfg.textFieldViewModel.textColor = ColorProvider.medicineCourseColors.text
        endComboboxCfg.textFieldViewModel.font = FontProvider.medicineCourseFonts.general
        endComboboxCfg.textFieldViewModel.placeholderText = "str_drugedit_end_use_placeholder"
        endComboboxCfg.textFieldViewModel.borderStyle = .roundedRect
        endComboboxCfg.markViewModel.image = ImageProvider.default.triangleToRight
        
        beginEndComboboxCellViewModel.leftCombobox = beginComboboxCfg
        beginEndComboboxCellViewModel.rightCombobox = endComboboxCfg
        
        cellViewModels += [beginEndComboboxCellViewModel]
        
        // Периодичность
        let periodCellViewModel = LabelCellViewModel()
        periodCellViewModel.paddingOffsets = Offsets(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0)
        
        let periodLabelCfg = LocalizedLabelViewModel()
        periodLabelCfg.text = "str_drugedit_period_data"
        periodLabelCfg.textColor = ColorProvider.medicineCourseColors.noteText
        periodLabelCfg.font = FontProvider.medicineCourseFonts.general
        
        periodCellViewModel.labelConfiguration = periodLabelCfg
        cellViewModels += [periodCellViewModel]
        
        // Выбор переодичности
        let comboboxCellViewModel = ComboboxCellViewModel(delegate: delegate)
        
            let periodComboboxCfg = LocalizedComboboxViewModel()
            periodComboboxCfg.viewName = "periodic"
        
        if let type = model?.periodCourseType, let value = model?.periodCourseValue {
            switch type {
            case .weekDays:
                periodComboboxCfg.textFieldViewModel.text = DayOfWeek.stringFromBitset(UInt8(value))
            case .countDays:
                periodComboboxCfg.textFieldViewModel.text = DaysPeriod.fromValue(value)?.toString() ?? ""
            }
        } else {
            periodComboboxCfg.textFieldViewModel.text = ""
        }
            periodComboboxCfg.textFieldViewModel.textColor = ColorProvider.medicineCourseColors.text
            periodComboboxCfg.textFieldViewModel.font = FontProvider.medicineCourseFonts.general
            periodComboboxCfg.textFieldViewModel.placeholderText = "str_drugedit_period_data_paceholder"
            periodComboboxCfg.textFieldViewModel.borderStyle = .roundedRect
            periodComboboxCfg.markViewModel.image = ImageProvider.default.triangleToRight
        
        comboboxCellViewModel.combobox = periodComboboxCfg
        comboboxCellViewModel.paddingOffsets = Offsets(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0)

        cellViewModels += [comboboxCellViewModel]
        
        // Время приема
        let timesCellCellViewModel = LabelCellViewModel()
        
        timesCellCellViewModel.paddingOffsets = Offsets(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0)
        
        let timesLabelCfg = LocalizedLabelViewModel()
        timesLabelCfg.text = "str_drugedit_times"
        timesLabelCfg.textColor = ColorProvider.medicineCourseColors.noteText
        timesLabelCfg.font = FontProvider.medicineCourseFonts.general
        
        timesCellCellViewModel.labelConfiguration = timesLabelCfg
        cellViewModels += [timesCellCellViewModel]
        
        return cellViewModels
    }

    static func makeCellObjectsAfterTimes(model: MedicineDrug?, delegate: TextFieldCellProtocol & TwiceComboboxCellProtocol & SingleButtonCellProtocol & TextAreaCellProtocol, editMode: DrugEditMode) -> [LocalizedTableViewCellViewModel] {
        
        var cellViewModels: [LocalizedTableViewCellViewModel] = []
        
        // Строка для добавления времени приема
        let imageAndLabelCellViewModel = ImageAndLabelCellViewModel()
        imageAndLabelCellViewModel.viewName = "add_times_view_model"
        
        imageAndLabelCellViewModel.paddingOffsets = Offsets(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0)
        imageAndLabelCellViewModel.betweenSpace = 12.0
        
        let addTimesIcon = LocalizedImageViewModel()
        addTimesIcon.image = ImageProvider.drugEditImages.addTimesIcon
        addTimesIcon.contentMode = .scaleAspectFill
        addTimesIcon.width = 24.0
        addTimesIcon.height = 24.0
        
        let addTimesLabelCfg = LocalizedLabelViewModel()
        addTimesLabelCfg.text = "str_drugedit_add_times"
        addTimesLabelCfg.textColor = ColorProvider.medicineCourseColors.text
        addTimesLabelCfg.font = FontProvider.medicineCourseFonts.general
        
        imageAndLabelCellViewModel.image = addTimesIcon
        imageAndLabelCellViewModel.label = addTimesLabelCfg
        cellViewModels += [imageAndLabelCellViewModel]
        
        // Рекомендации
        let recomendationCellViewModel = LabelCellViewModel()
        
        recomendationCellViewModel.paddingOffsets = Offsets(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0)
        
        let recomendationsLabelCfg = LocalizedLabelViewModel()
        recomendationsLabelCfg.text = "str_drugedit_recomendations"
        recomendationsLabelCfg.textColor = ColorProvider.medicineCourseColors.noteText
        recomendationsLabelCfg.font = FontProvider.medicineCourseFonts.general
        
        recomendationCellViewModel.labelConfiguration = recomendationsLabelCfg
        cellViewModels += [recomendationCellViewModel]
        
        // Ввод рекомендаций
        let commentTextAreaCellViewModel = TextAreaCellViewModel(delegate: delegate)
        commentTextAreaCellViewModel.paddingOffsets = Offsets(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0)
        
        let textAreaCfg = LocalizedTextViewModel()
        textAreaCfg.viewName = "comment_textarea"
        if let comment = model?.comment {
            textAreaCfg.text = comment
        } else {
            textAreaCfg.text = ""
        }
        textAreaCfg.textColor = ColorProvider.medicineCourseColors.noteText
        textAreaCfg.font = FontProvider.medicineCourseFonts.general
        textAreaCfg.height = 100
        
        commentTextAreaCellViewModel.textAreaConfiguration = textAreaCfg
        cellViewModels += [commentTextAreaCellViewModel]
        
        // Кнопка удаления
        if editMode == .edit {
            let singleButtonCellViewModel = SingleButtonCellViewModel(delegate: delegate)
            singleButtonCellViewModel.paddingOffsets = Offsets(top: 8.0, bottom: 128.0, left: 8.0, right: 8.0)
            
            let deleteButtonCellCfg = LocalizedButtonViewModel()
            deleteButtonCellCfg.viewName = "delete_button"
            
            deleteButtonCellCfg.text = "str_drugedit_delete_button_text"
            deleteButtonCellCfg.textColor = ColorProvider.medicineCourseColors.deleteButtonTextColor
            deleteButtonCellCfg.font = FontProvider.medicineCourseFonts.buttonFont
            deleteButtonCellCfg.height = 56.0
            deleteButtonCellCfg.backgroundColor = ColorProvider.medicineCourseColors.deleteButtonColor
            deleteButtonCellCfg.cornerRadius = 5.0
            
            singleButtonCellViewModel.buttonConfiguration = deleteButtonCellCfg
            cellViewModels += [singleButtonCellViewModel]
        }
        
        return cellViewModels
    }
    
    static func makeTimeCellViewModel(model: MedicineDrug?, delegate: UsingTimesCellViewModelDelegate) -> [UsingTimesCellViewModel] {
        
        var array: [UsingTimesCellViewModel] = []
        
        guard let times = model?.times else { return []}
        
        for (index, drugTime) in times.enumerated() {
            
            let timesNumberLabelCfg = LocalizedLabelViewModel()
            timesNumberLabelCfg.text = String(format: "%02d.", index + 1)
            timesNumberLabelCfg.textColor = ColorProvider.medicineCourseColors.noteText
            timesNumberLabelCfg.font = FontProvider.medicineCourseFonts.general
            
            let timesComboboxCfg = LocalizedComboboxViewModel()
            timesComboboxCfg.textFieldViewModel.text = drugTime.usageTime.toString()
            timesComboboxCfg.textFieldViewModel.textColor = ColorProvider.medicineCourseColors.text
            timesComboboxCfg.textFieldViewModel.font = FontProvider.medicineCourseFonts.general
            timesComboboxCfg.textFieldViewModel.placeholderText = "str_drugedit_times_time_placeholder"
            timesComboboxCfg.textFieldViewModel.borderStyle = .roundedRect
            timesComboboxCfg.markViewModel.image = ImageProvider.default.triangleToBottom
            timesComboboxCfg.textFieldViewModel.height = 44.0
            
            let countField = LocalizedTextFieldViewModel()
            countField.text = drugTime.dose.makeDoseString()
            countField.textColor = ColorProvider.medicineCourseColors.text
            countField.font = FontProvider.medicineCourseFonts.general
            countField.placeholderText = "str_drugedit_times_dose_placeholder"
            countField.borderStyle = .roundedRect
            countField.height = 44.0
            countField.keyboardType = .decimalPad
            
            let usingTimesCellViewModel = UsingTimesCellViewModel()
            
            usingTimesCellViewModel.numberLabel = timesNumberLabelCfg
            usingTimesCellViewModel.timesBox = timesComboboxCfg
            usingTimesCellViewModel.countField = countField
            usingTimesCellViewModel.delegate = delegate
            
            usingTimesCellViewModel.paddingOffsets = Offsets(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0)
            
            array += [usingTimesCellViewModel]
            
        }
        
        return array
    }

    static func makeTimeCellViewModel(index: Int, delegate: UsingTimesCellViewModelDelegate) -> UsingTimesCellViewModel {
        
        let timesNumberLabelCfg = LocalizedLabelViewModel()
        timesNumberLabelCfg.text = String(format: "%02d.", index)
        timesNumberLabelCfg.textColor = ColorProvider.medicineCourseColors.noteText
        timesNumberLabelCfg.font = FontProvider.medicineCourseFonts.general
        
        let timesComboboxCfg = LocalizedComboboxViewModel()
        timesComboboxCfg.textFieldViewModel.text = ""
        timesComboboxCfg.textFieldViewModel.textColor = ColorProvider.medicineCourseColors.text
        timesComboboxCfg.textFieldViewModel.font = FontProvider.medicineCourseFonts.general
        timesComboboxCfg.textFieldViewModel.placeholderText = "str_drugedit_times_time_placeholder"
        timesComboboxCfg.textFieldViewModel.borderStyle = .roundedRect
        timesComboboxCfg.markViewModel.image = ImageProvider.default.triangleToBottom
        timesComboboxCfg.textFieldViewModel.height = 44.0
        
        let countField = LocalizedTextFieldViewModel()
        countField.text = ""
        countField.textColor = ColorProvider.medicineCourseColors.text
        countField.font = FontProvider.medicineCourseFonts.general
        countField.placeholderText = "str_drugedit_times_dose_placeholder"
        countField.borderStyle = .roundedRect
        countField.height = 44.0
        countField.keyboardType = .decimalPad
        
        let usingTimesCellViewModel = UsingTimesCellViewModel()
 
        usingTimesCellViewModel.viewName = "using_times_cell"
        usingTimesCellViewModel.numberLabel = timesNumberLabelCfg
        usingTimesCellViewModel.timesBox = timesComboboxCfg
        usingTimesCellViewModel.countField = countField
        usingTimesCellViewModel.delegate = delegate
        
        usingTimesCellViewModel.paddingOffsets = Offsets(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0)
        
        return usingTimesCellViewModel
        
    }

}
