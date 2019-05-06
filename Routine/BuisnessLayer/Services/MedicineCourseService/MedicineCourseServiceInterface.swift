import Foundation

protocol MedicineCourseServiceInterface {
    func obtainAll() -> [MedicineCourse]
    func obtainCurrentCourses() -> [MedicineCourse]
    func obtainArchiveCourses() -> [MedicineCourse]
    
    func createOrUpdate(_ model: MedicineCourse, complition: @escaping (MedicineCourse?) -> Void)
    
    func delete(_ model: MedicineCourse) -> Bool
}
