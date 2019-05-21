import UIKit

let kDrugsListModuleId = "kDrugsListModule"

final class DrugsListPresenter: Module {
    var moduleOutput: DrugsListModuleOutput?
    weak var view: DrugsListViewInput!
    var router: DrugsListModuleRouting!
    
    var name = "DrugsList_name"
    var alias = "DrugsList_alias"
    weak var viewController: UIViewController! {
        return self.view as? UIViewController
    }
    
    // Properties
    private var medicineCourse: MedicineCourse?
    
    var localizeService: StringServiceInterface!
    var drugsListTableViewFactory: DrugsListTableViewFactoryInterface! 
}

// MARK: - DrugsListModuleInput
extension DrugsListPresenter: DrugsListModuleInput {
    
    func configureModule(selectedMedCourse: MedicineCourse) {
        self.medicineCourse = selectedMedCourse
    }
    
    func updateDrug(_ drug: MedicineDrug) {
        if self.medicineCourse?.drugs != nil {
            if self.medicineCourse?.drugs?.firstIndex(of: drug) == nil {
                self.medicineCourse?.drugs?.append(drug)
            }
        } else {
            self.medicineCourse?.drugs = [drug]
        }
        
        guard let medicineCourse = self.medicineCourse else { return }
        self.view?.updateTableViewWithMedicineCourse(medicineCourse)
        
    }
    
    func removeDrug(_ drug: MedicineDrug) {
        if let index = self.medicineCourse?.drugs?.lastIndex(of: drug) {
            self.medicineCourse?.drugs?.remove(at: index)
            self.view?.removeDrug(drug, forIndex: index)
        }
    }
}

// MARK: - DrugsListViewOutput
extension DrugsListPresenter: DrugsListViewOutput {
    func backButtonPressed() {
        self.router.closeModule()
    }
    

    func didTriggerViewReadyEvent() {
        self.view?.setupInitialState()
        self.view?.updateNavTitle(self.medicineCourse?.name ?? "")
        
        if let medCourse = self.medicineCourse {
            self.view?.updateTableViewWithMedicineCourse(medCourse)
            
            if medCourse.endDate == 0 || medCourse.endDate > Int(Date().timeIntervalSince1970 * 1000.0) {
                self.view?.enableCreateButton()
            }
        }
    }
    
    func didTriggerViewWillAppear() {
        // empty
    }
    
    func createDrugButtonDidPressed() {
        if let medCourse = self.medicineCourse {
            self.router.openCreateDrugsForCourse(medCourse, drugsListModuleInput: self)
        }
    }
    
    func rowDidPressed(index: Int) {
        if let drug = self.medicineCourse?.drugs?[index], let medicineCourse = self.medicineCourse {
            self.router.openDrugDetails(drug, medicineCourse: medicineCourse, drugsListModuleInput: self)
        }
    }
    
}
