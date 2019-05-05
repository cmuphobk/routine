import UIKit

let kDrugDetailsModuleId = "kDrugDetailsModule"

class DrugDetailsPresenter: Module {
    var moduleOutput: DrugDetailsModuleOutput?
    weak var view: DrugDetailsViewInput?
    var router: DrugDetailsModuleRouting!
    
    var name = "DrugDetails_name"
    var alias = "DrugDetails_alias"
    weak var viewController: UIViewController? {
        return self.view as? UIViewController
    }
    
    // Properties
    private var medicineCourse: MedicineCourse!
    private var drug: MedicineDrug!
    private var drugsListModuleInput: DrugsListModuleInput!
}

// MARK: - DrugDetailsModuleInput
extension DrugDetailsPresenter: DrugDetailsModuleInput {
    
    func configureModule(medicineCourse: MedicineCourse, drug: MedicineDrug, drugsListModuleInput: DrugsListModuleInput) {
        self.medicineCourse = medicineCourse
        self.drug = drug
        self.drugsListModuleInput = drugsListModuleInput
    }
    
}

// MARK: - DrugDetailsViewOutput
extension DrugDetailsPresenter: DrugDetailsViewOutput {

    func didTriggerViewReadyEvent() {
        self.view?.setupInitialState()
        self.view?.updateNavTitle(self.drug.name)
        
        if let endDate = self.drug.endDate, endDate > Int(Date().timeIntervalSince1970 * 1000.0) {
            self.view?.enableEditButton()
        }
        if let drug = self.drug {
            self.view?.updateDetailsInfo(htmlCode: self.makeDetailInfoAsHtmlFrom(drug: drug))
        }
    }
    
    func didTriggerViewWillAppear() {
        
    }
    
    func editDrugAction() {
        if let drug = self.drug, let medicineCourse = self.medicineCourse {
            self.router.openDrigEdit(drug, medCourse: medicineCourse, drugsListModuleInput: self.drugsListModuleInput)
        }
    }
    
    func didTriggerBackAction() {
        self.router.closeModule()
    }
    
}

// MARK: - Private
extension DrugDetailsPresenter {
    
    func makeDetailInfoAsHtmlFrom(drug: MedicineDrug) -> String {
        let htmlTemplate = AppDelegate.serviceProvider.makeStringService().localizeHtmlById("drug_details_template")
        var html: String = ""
        
        html.append("<div style='padding: 2pt 16pt 2pt 16pt'>")
        
        // Заголовок
        html.append("<label class='header_text'> \(self.drug.name) </label>")
        
        // Комментарий
        if let comment = self.drug.comment {
            html.append("<label class='black_regular_text'> \(comment) </label>")
        }
        
        // Время начала и окончания приема
        if let startDate = self.drug?.startDate, let endDate = self.drug?.endDate {
        
            html.append("""
                        <table width=108% border = 0>
                            <tr valign='middle'>
                            <td class='lightGray_header' align='left' style='width:50%'>\(AppDelegate.serviceProvider.makeStringService().localizeById("beginning_of_the_reception")):</td>
                                <td class='lightGray_header' align='right' style='width:50%'>\(AppDelegate.serviceProvider.makeStringService().localizeById("end_of_the_reception")):</td>
                            </tr>
                            <tr valign='middle'>
                                <td class='black_regular_text' align='left' style='width:50%'>\(Date(timeIntervalSince1970: TimeInterval(startDate / 1000)).format(with: "dd.MM.yyyy"))</td>
                                <td class='black_regular_text' align='right' style='width:50%'>\(Date(timeIntervalSince1970: TimeInterval(endDate / 1000)).format(with: "dd.MM.yyyy"))</td>
                            </tr>
                        </table>
                        """)
        }
        
        // Период приема
        html.append("<label class='lightGray_header'> \(AppDelegate.serviceProvider.makeStringService().localizeById("periodic")) </label>")
        switch drug.periodCourseType {
        case .weekDays:
            html.append("<label class='black_regular_text'> \(DayOfWeek.stringFromBitset(UInt8(drug.periodCourseValue))) </label>")
        
        case .countDays:
            if let periodValue = DaysPeriod.fromValue(drug.periodCourseValue) {
                html.append("<label class='black_regular_text'> \(periodValue.toString()) </label>")
            }
        }
        
        // Время приема
        let medTimes = drug.times
        if medTimes.count != 0 {
            
            html.append("<label class='lightGray_header'> \(AppDelegate.serviceProvider.makeStringService().localizeById("time_of_reception")): </label>")
            
            html.append("""
                        <table class='black_regular_text' width=100% border=0 cellpadding=0>
                        <col width = 15%>
                        <col width = 25%>
                        <col width = 60%>
                        """)
            for (index, medTime) in medTimes.enumerated() {
                html.append("""
                    <tr align='left' valign='middle'>
                        <td align='left' class='lightGray_regular_text'>\(String(format: "%02d", index+1)).</td>
                        <td align='left' class='black_regular_text'>\(medTime.usageTime.toString())</td>
                        <td align='left' class='black_regular_text'>\(medTime.dose.makeDoseString()) \(self.drug.unit.pluralsStringFor(count: Int(medTime.dose)))</td>
                    </tr>
                    """)
            }
            html.append("</table>")
        }
        
        html.append("</div>")
        
        return String(format: htmlTemplate, html)
    }
}
