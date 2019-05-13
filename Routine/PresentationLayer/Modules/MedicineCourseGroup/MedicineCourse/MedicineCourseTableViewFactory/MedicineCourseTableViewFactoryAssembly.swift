import Foundation

enum MedicineCourseTableViewFactoryAssembly {
    
    static func build() -> MedicineCourseTableViewFactoryInterface {
        
        let medCourseFactory = MedicineCourseTableViewFactory()
        
        return medCourseFactory
        
    }
    
}
