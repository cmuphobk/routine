import UIKit
import DateToolsSwift

let kDrugEditModuleId = "kDrugEditModule"

class DrugEditPresenter: Module, BasePresenter {
    var moduleOutput: DrugEditModuleOutput?
    weak var view: DrugEditViewInput!
    var router: DrugEditRouterInput!
    
    var name = "DrugEdit_name"
    var alias = "DrugEdit_alias"
    weak var viewController: UIViewController! {
        return self.view as? UIViewController
    }
    
    // Properties
    private var medicineCourse: MedicineCourse!
    private var drug: MedicineDrug?
    private var editMode: DrugEditMode!
    private var drugsListModuleInput: DrugsListModuleInput?
    
    var medicineCourseService: MedicineCourseServiceInterface!
    var drugsService: MedicineDrugServiceInterface!
    var localNotificationService: LocalNotificationServiceInterface?
    
    // необходимые данные для создания модели таблетки
    var drugName: String?
    var drugComment: String?
    var drugStartDate: Int?
    var drugType: MedicineType?
    var drugUnit: MedicineUnit?
    var drugTimes: [MedicineCourseTime] = []
    var drugTimesNotifications: [DateForNotification]?
    var drugEndingCourseType: EndingCourseType?
    var drugEndingCourseValue: Int?
    var drugPeriodCourseType: PeriodCourseType?
    var drugPeriodCourseValue: Int?
    var drugCourseObjectId: String?
    
    var localizeService: StringServiceInterface!
    var languageService: LanguageServiceInterface!
    
    var drugEditTableViewFactory: DrugEditTableViewFactoryInterface!
    
}

// MARK: - DrugEditModuleInput
extension DrugEditPresenter: DrugEditModuleInput {
    
    func configureModule(medicineCourse: MedicineCourse, drug: MedicineDrug?, editMode: DrugEditMode, drugsListModuleInput: DrugsListModuleInput?) {
        self.medicineCourse = medicineCourse
        self.drug = drug
        self.editMode = editMode
        self.drugsListModuleInput = drugsListModuleInput
        
        if let drug = self.drug {
            self.drugName = drug.name
            self.drugComment = drug.comment
            self.drugStartDate = drug.startDate
            self.drugType = drug.type
            self.drugUnit = drug.unit
            self.drugTimes = drug.times
            self.drugTimesNotifications = self.localNotificationService?.obtainDatesNotificationsFromDrugsModel(drug)
            self.drugEndingCourseValue = drug.endingCourseValue
            self.drugEndingCourseType = drug.endingCourseType
            self.drugPeriodCourseValue = drug.periodCourseValue
            self.drugPeriodCourseType = drug.periodCourseType
            self.drugCourseObjectId = drug.courseObjectId
        }
    }
}

// MARK: - DrugEditViewOutput
extension DrugEditPresenter: DrugEditViewOutput {
    
    func obtainTypeList() -> [SimpleComboboxUnit] {
        return MedicineType.convertToSimpleComboboxUnits(localizeService: self.localizeService)
    }
    
    func obtainUnitList() -> [SimpleComboboxUnit] {
        return self.drugType?.obtainUnitComboboxesForType(localizeService: self.localizeService) ?? []
    }
    
    func didTriggerViewReadyEvent() {
        self.view?.setupInitialState(editMode: self.editMode)
        
        self.view?.updateNavTitle(self.drug?.name ?? self.localizeService.localizeId("create_drug_title"))
        self.view?.updateTableView(model: self.drug, editMode: self.editMode)
    }
    
    func didTriggerViewWillAppear() {
        // empty
    }
    
    func closeModule() {
        self.router.closeModule()
    }
    
    func deleteButtonAction() {
        guard let containerForModal = self.router.containerForModal() else { return }
        self.view?.openModal(view: containerForModal.view) { [unowned self] (_, modal) in
            _ = self.router.deleteQuestionPopup(modal, parentViewController: containerForModal.viewController, confirmationDelegate: self)
        }
    }
    
    func drugNameChanged(_ newValue: String) {
        self.drugName = newValue
    }
    
    func drugTypeChanged(_ index: Int) {
        let type = MedicineType.allCases[index]
        self.drugType = type
        self.view?.updateDrugType(self.drugType)
        
        self.drugUnit = nil
        self.view?.updateDrugUnit(self.drugUnit)
    }
    
    func drugUnitChanged(_ index: Int) {
        let unit = self.drugType?.obtainUnitsForType()[index]
        self.drugUnit = unit
        self.view?.updateDrugUnit(unit)
    }
    
    func startDateChanged(_ date: Date) {
        let date = Calendar.current.date(bySettingHour: 0, minute: 0, second: 0, of: date)!
        self.drugStartDate = Int(date.timeIntervalSince1970 * 1000.0)
        self.view?.updateStartDate(date)
    }
    
    func usageTimeChanged(index: Int, date: Date) {
        
        var drugTime = self.drugTimes[index]
        drugTime.usageTime.setTime(milisec: Int(date.timeIntervalFromStartDay))
        
        self.drugTimes[index] = drugTime
    }
    
    func usageTimeChanged(index: Int, value: Double) {
        var drugTime = self.drugTimes[index]
        drugTime.dose = value
        self.drugTimes[index] = drugTime
    }
    
    func usageTimeAdd() {
        self.drugTimes.append(MedicineCourseTime(dose: 0.0, usageTime: Time(hours: 0, minutes: 0)))
    }
    
    func drugCommentChanged(_ newText: String) {
        self.drugComment = newText
    }
    
    func rowDidPressed(index: Int) {
        // empty
    }
    
    func acceptDrug() {
        guard let editMode = self.editMode else { return }
        
        if  self.drugName != nil     &&
            self.drugName!.count > 0 &&
            self.drugType != nil     &&
            self.drugUnit != nil     &&
            self.drugStartDate != nil &&
            self.drugEndingCourseValue != nil &&
            self.drugPeriodCourseValue != nil &&
            self.drugEndingCourseType != nil &&
            self.drugPeriodCourseType != nil &&
            self.drugTimes.count > 0 {
            
            let drugTimesSorted = self.drugTimes.sorted { (left, right) -> Bool in
                return left.usageTime.rawValue() < right.usageTime.rawValue()
            }
            
            // Собираем таблетку
            let drugForUpdate = MedicineDrug(name: self.drugName!,
                                             comment: self.drugComment ?? "",
                                             type: self.drugType!,
                                             unit: self.drugUnit!,
                                             startDate: self.drugStartDate!,
                                             endingCourseValue: self.drugEndingCourseValue!,
                                             endingCourseType: self.drugEndingCourseType!,
                                             periodCourseValue: self.drugPeriodCourseValue!,
                                             periodCourseType: self.drugPeriodCourseType!,
                                             times: drugTimesSorted
            )
            drugForUpdate.courseObjectId = self.medicineCourse.objectId
            
            // В зависимости от режима или наличия изменяем медкурс
            if self.medicineCourse.drugs != nil {
                switch editMode {
                case .create:
                    
                    //создаем препарат
                    self.drugsService.createOrUpdate(drugForUpdate) { [unowned self] (newDrug) in
                        
                        guard let newDrug = newDrug else { return }
                        
                        //привязываем к курсу
                        self.medicineCourse.drugs?.append(newDrug)
                        
                        //сохраняем курс
                        self.medicineCourseService.createOrUpdate(self.medicineCourse) { [unowned self] (_) in
                            
                            //просим обновиться препаратами список препаратов
                            self.drugsListModuleInput?.updateDrug(newDrug)
                        }
                    }
                    
                case .edit:
                    if let drug = self.drug, let idx = self.medicineCourse?.drugs?.indexOf(drug) {
                        drugForUpdate.objectId = drug.objectId ?? ""
                        
                        //обновляем препарат
                        self.drugsService.createOrUpdate(drugForUpdate) { [unowned self] (newDrug) in
                            
                            guard let newDrug = newDrug else { return }
                            
                            //привязываем к курсу
                            self.medicineCourse.drugs?[idx] = newDrug
                            
                            //сохраняем курс
                            self.medicineCourseService.createOrUpdate(self.medicineCourse) { [unowned self] (_) in
                                
                                //просим обновиться препаратами список препаратов
                                self.drugsListModuleInput?.updateDrug(newDrug)
                            }
                            
                        }
                    }
                }
            } else {
                //создаем препарат
                self.drugsService.createOrUpdate(drugForUpdate) { [unowned self] (newDrug) in
                    
                    guard let newDrug = newDrug else { return }
                    
                    //привязываем к курсу
                    self.medicineCourse.drugs = [newDrug]
                    
                    //сохраняем курс
                    self.medicineCourseService.createOrUpdate(self.medicineCourse) { [unowned self] (_) in
                        
                        //просим обновиться препаратами список препаратов
                        self.drugsListModuleInput?.updateDrug(newDrug)
                    }
                }
            }
            
            self.router.closeModuleWithEditMode(self.editMode)
        } else {
            self.router.showMessageWithText(self.localizeService.localizeId("drug_edit_fillerror"))
        }
    }
    
    func endUsingDidPressed() {
        self.router.openEndUsageEditScreen(moduleOutput: self)
    }
    
    func periodicDidPressed() {
        if let type = self.drugPeriodCourseType, let value = self.drugPeriodCourseValue {
            self.router.openPeriodicEditScreen(moduleOutput: self, periodType: type, periodValue: value)
        } else {
            self.router.openPeriodicEditScreen(moduleOutput: self, periodType: PeriodCourseType.weekDays, periodValue: 0)
        }
    }
}

// MARK: - ConfirmationModuleModuleOutput
extension DrugEditPresenter: ConfirmationModuleOutput {
    
    func confirmWithMessage(_ msg: String) {
        guard let editMode = self.editMode else { return }
        
        self.view?.closeModal { [unowned self] (_) in
            
            switch editMode {
            case .create:
                self.router.closeModuleWithEditMode(self.editMode)
                
            case .edit:
                if let drug = self.drug {
                    
                    //удаляем препарат
                    _ = self.drugsService.delete(drug)
                    
                    //просим обновиться препаратами список препаратов
                    self.drugsListModuleInput?.removeDrug(drug)
                }
                self.router.closeModuleWithEditMode(self.editMode)
            }
            
            self.router.closeStandartModal()

        }
        
    }
    
    func cancelWithoutMessage() {
        
        self.view?.closeModal { [unowned self] (_) in
            self.router.closeStandartModal()
        }
        
    }
    
}

// MARK: - DrugTimesEditModuleOutput
extension DrugEditPresenter: DrugTimesEditModuleOutput {
    
    func acceptNewTimes(newDrugEndingCourseType: EndingCourseType, newDrugEndingCourseValue: Int) {
        self.drugEndingCourseType = newDrugEndingCourseType
        self.drugEndingCourseValue = newDrugEndingCourseValue
        
        self.view?.updateEndingTime( newDrugEndingCourseType.toPluralsString(count: newDrugEndingCourseValue, localizeService: self.localizeService))
    }
    
}

// MARK: - DrugPeriodicEditModuleOutput
extension DrugEditPresenter: DrugPeriodicEditModuleOutput {
    
    func acceptNewPeriod(newDrugPeriodCourseType: PeriodCourseType, newDrugPeriodCourseValue: Int) {
        self.drugPeriodCourseType = newDrugPeriodCourseType
        self.drugPeriodCourseValue = newDrugPeriodCourseValue
        
        var valueString: String = ""
        
        switch newDrugPeriodCourseType {
        case .weekDays:
            valueString = DayOfWeek.stringFromBitset(UInt8(newDrugPeriodCourseValue), localizeService: self.localizeService)
        case .countDays:
            valueString = DaysPeriod.fromValue(newDrugPeriodCourseValue)?.toString(localizeService: self.localizeService) ?? ""
        }
        
        self.view?.updatePeriodTime(valueString)
    }
    
}
