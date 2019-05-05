import Foundation

class MedicineCourse: IdentifierModelInterface {
    
    var objectId: String?
    var name: String
    
    private var privateDrugs: [MedicineDrug]?
    var drugs: [MedicineDrug]? {
        get {
            guard var drugs = self.privateDrugs else { return nil }
            drugs.sort(by: { (drug1, drug2) -> Bool in
                return drug1.name < drug2.name
            })
            return drugs
        }
        set {
            self.privateDrugs = newValue
        }
    }
    
    var startDate: Int {
        var minStartDate = Int.max
        self.drugs?.forEach({ (drug) in
            let drugStartDate = drug.startDate
            minStartDate = drugStartDate < minStartDate ? drugStartDate : minStartDate
        })
        return minStartDate
    }
    
    var endDate: Int {
        var maxEndDate = 0
        self.drugs?.forEach({ (drug) in
            let drugEndDate = drug.endDate ?? 0
            maxEndDate = drugEndDate > maxEndDate ? drugEndDate : maxEndDate
        })
        return maxEndDate
    }
    
    init(entity: MedicineCourseEntity) {
        
        self.objectId = entity.objectID.uriRepresentation().absoluteString
        self.name = entity.name ?? ""
        
        if let drugsEntities = entity.drugs?.allObjects as? [MedicineDrugEntity] {
            
            for drugEntity in drugsEntities {
                
                if self.drugs == nil {
                    self.drugs = []
                }
                
                self.drugs?.append(MedicineDrug(entity: drugEntity))
                
            }
            
        }
        
    }
    
    init(name: String) {
        self.name = name
    }
    
}
