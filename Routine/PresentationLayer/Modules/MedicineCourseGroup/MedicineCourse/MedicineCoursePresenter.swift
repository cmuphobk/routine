import UIKit

let kMedicineCourseModuleId = "medicine_course_name"
let kMedicineCourseModuleAlias = "medicine_course_alias"

final class MedicineCoursePresenter: Module {
    weak var view: MedicineCourseViewInput?
    var router: MedicineCourseModuleRouting!
    var medicineCourseService: MedicineCourseServiceInterface!
    
    var name = kMedicineCourseModuleId
    var alias = kMedicineCourseModuleAlias
    weak var viewController: UIViewController? {
        return self.view as? UIViewController
    }
    
    private var medCourses: [MedicineCourse] = []
    private var currentType: MedicineCourseGroupType = .medicineCourseNow
    
    private enum PopUpMode {
        case create
        case rename
        case delete
    }
    private var currentPopupMode: PopUpMode = .create
    private var currentSelectIndex: Int = 0
    
    var localizeService: StringServiceInterface!
    
    var medicineCourseTableViewFactory: MedicineCourseTableViewFactoryInterface!
}

// MARK: - MedicineCourseModuleInput
extension MedicineCoursePresenter: MedicineCourseModuleInput {
    
    func configureModule() {
        // empty
    }
    
}

// MARK: - MedicineCourseViewOutput
extension MedicineCoursePresenter: MedicineCourseViewOutput {

    func didTriggerViewReadyEvent() {
        self.view?.setupInitialState()
    }
    
    func didTriggerViewWillAppear() {
        self.didTriggerSelectMedicineGroupType(self.currentType)
    }
    
    func closeModule() {
        self.router.closeModule()
    }
    
    func didTriggerOpenCreateCourseModal() {
        guard let containerForModal = self.router.containerForModal() else { return }
        self.view?.openModal(view: containerForModal.view) { [unowned self] (_, modal) in
            self.currentPopupMode = .create
            
            _ = self.router.openCreateCourseStandartModal(modal, parentViewController: containerForModal.viewController, confirmationDelegate: self)
        }
        
        
    }
    
    func rowDidPressed(index: Int) {
        self.router.openDrugsList(medCourse: self.medCourses[index])
    }
    
    func rowDidRenamed(index: Int) {
        
        guard let containerForModal = self.router.containerForModal() else { return }
        
        self.view?.openModal(view: containerForModal.view) { [unowned self] (_, modal) in
            self.currentPopupMode = .rename
            self.currentSelectIndex = index
                
            _ = self.router.openRenameCourseStandartModal(modal, parentViewController: containerForModal.viewController, confirmationDelegate: self, medCourse: self.medCourses[index])
        }
        
    }
    
    func rowDidRemoved(index: Int) {
        guard let containerForModal = self.router.containerForModal() else { return }
        self.view?.openModal(view: containerForModal.view) { [unowned self] (_, modal) in
            self.currentSelectIndex = index
            self.currentPopupMode = .delete
            
            _ = self.router.openDeleteCourseStandartModal(modal, parentViewController: containerForModal.viewController, confirmationDelegate: self)
        }
        
    }
    
    func didTriggerSelectMedicineGroupType(_ type: MedicineCourseGroupType) {
        self.medCourses.removeAll()
        self.currentType = type
        
        switch type {
        case .medicineCourseNow:
            self.medCourses = self.medicineCourseService.obtainCurrentCourses()
            self.view?.updateTableView(models: self.medCourses, isArchive: false)
        
        case .medicineCourseArchive:
                self.medCourses = self.medicineCourseService.obtainArchiveCourses()
                self.view?.updateTableView(models: self.medCourses, isArchive: true)
        }
    }
    
}

// MARK: - ConfirmationModuleModuleOutput
extension MedicineCoursePresenter: ConfirmationModuleOutput {
    
    func confirmWithMessage(_ msg: String) {
        
        self.view?.closeModal { [unowned self] _ in
            
            switch self.currentPopupMode {
            case .create:
                self.medicineCourseService.createOrUpdate( MedicineCourse(name: msg), complition: { [unowned self] _ in
                    
                    switch self.currentType {
                    case .medicineCourseNow:
                        self.medCourses = self.medicineCourseService.obtainCurrentCourses()
                    case .medicineCourseArchive:
                        self.medCourses = self.medicineCourseService.obtainArchiveCourses()
                    }
                    
                    self.view?.updateTableView(models: self.medCourses, isArchive: false)
                    
                })
                
            case .rename:
                let model = self.medCourses[self.currentSelectIndex]
                model.name = msg
                
                self.medicineCourseService.createOrUpdate(model, complition: { [unowned self] _ in
                    
                    switch self.currentType {
                    case .medicineCourseNow:
                        self.medCourses = self.medicineCourseService.obtainCurrentCourses()
                    case .medicineCourseArchive:
                        self.medCourses = self.medicineCourseService.obtainArchiveCourses()
                    }
                    
                    self.view?.updateTableView(models: self.medCourses, isArchive: false)
                    
                })
                
                
   
            case .delete:
                let isSuccess = self.medicineCourseService.delete(self.medCourses[self.currentSelectIndex])

                if isSuccess {
                    self.medCourses.remove(at: self.currentSelectIndex)
                    self.view?.deleteRowAtIndex(self.currentSelectIndex)
                }
                
            }
        }
    }
    
    func cancelWithoutMessage() {
        self.view?.closeModal { [unowned self] _ in
            self.router.closeEditStandartModal()
        }
    }
    
}
