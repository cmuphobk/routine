import UIKit

enum ConfirmationModuleAssembly {
    
    static func buildCourseCreatePopup(confirmationDelegate: ConfirmationModuleModuleOutput) -> InputTextPopup? {
        guard let viewController = R.storyboard.inputTextPopup.inputTextPopup() else {
            return nil
        }
        
        let presenter = ConfirmationModulePresenter(caption: "create_med_course_caption_string",
                                                   text: "create_med_course_text_string",
                                                   textFieldValue: "",
                                                   textFieldPlaceholder: "create_med_course_nameplaceholder_string",
                                                   acceptButtonText: "create_med_course_accept_string",
                                                   cancelButtonText: "create_med_course_cancel_string")
        // Inject properties
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.moduleOutput = confirmationDelegate
        
        return viewController
    }
    
    static func buildCourseRenamePopup(confirmationDelegate: ConfirmationModuleModuleOutput, medCourse: MedicineCourse) -> InputTextPopup? {
        guard let viewController = R.storyboard.inputTextPopup.inputTextPopup() else {
            return nil
        }
        
        let presenter = ConfirmationModulePresenter(caption: "rename_med_course_caption_string",
                                                   text: "rename_med_course_text_string",
                                                   textFieldValue: medCourse.name,
                                                   textFieldPlaceholder: "rename_med_course_nameplaceholder_string",
                                                   acceptButtonText: "rename_med_course_accept_string",
                                                   cancelButtonText: "rename_med_course_cancel_string")
        // Inject properties
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.moduleOutput = confirmationDelegate
        
        return viewController
    }
    
    static func buildCourseDeletePopup(confirmationDelegate: ConfirmationModuleModuleOutput) -> ConfirmDecisionPopup? {
        guard let viewController = R.storyboard.confirmDecisionPopup.confirmDecisionPopup() else {
            return nil
        }
        
        let presenter = ConfirmationModulePresenter(caption: "delete_med_course_caption_string",
                                                   text: "delete_med_course_text_string",
                                                   textFieldValue: " ",
                                                   textFieldPlaceholder: " ",
                                                   acceptButtonText: "delete_med_course_accept_string",
                                                   cancelButtonText: "delete_med_course_cancel_string")
        // Inject properties
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.moduleOutput = confirmationDelegate
        
        return viewController
    }
    
    static func buildYesNoPopup(confirmationDelegate: ConfirmationModuleModuleOutput,
                                caption: String,
                                text: String,
                                acceptButtonText: String,
                                cancelButtonText: String) -> ConfirmDecisionPopup? {
        
        guard let viewController = R.storyboard.confirmDecisionPopup.confirmDecisionPopup() else {
            return nil
        }
        
        let presenter = ConfirmationModulePresenter(caption: caption,
                                                    text: text,
                                                    textFieldValue: " ",
                                                    textFieldPlaceholder: " ",
                                                    acceptButtonText: acceptButtonText,
                                                    cancelButtonText: cancelButtonText)
        // Inject properties
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.moduleOutput = confirmationDelegate
        
        return viewController
    }
    
    static func buildCalculatorPopup(confirmationDelegate: ConfirmationModuleModuleOutput) -> CalculatorPopup? {
        guard let viewController = R.storyboard.calculatorPopup.calculatorPopup() else {
            return nil
        }
        
        let presenter = ConfirmationModulePresenter(caption: "Ввод значения",
                                                   text: "",
                                                   textFieldValue: "",
                                                   textFieldPlaceholder: "Введите количество",
                                                   acceptButtonText: "Применить",
                                                   cancelButtonText: "Отмена")
        
        // Inject properties
        viewController.presenter = presenter
        presenter.view = viewController
        presenter.moduleOutput = confirmationDelegate
        
        return viewController
    }
}
