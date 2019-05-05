import Foundation

protocol MedicineDrugServiceInterface {
    func obtainAll() -> [MedicineDrug]
    func obtainAllForCourse(medicineCourse: MedicineCourse) -> [MedicineDrug]
    
    func createOrUpdate(_ model: MedicineDrug, complition: @escaping (MedicineDrug?) -> Void)
    
    func delete(_ model: MedicineDrug) -> Bool
}
