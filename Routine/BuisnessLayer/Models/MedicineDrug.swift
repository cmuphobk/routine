import Foundation

//по каждому MedicineDrugEnity сохраняются массивы notifications в cache с ключем "MedicineDrug.objectId_notifications"
//в сервисе создания сущности при получении objectId он сохраняется в модель и сразу же через MedicineDrug.notifications получаються ключи к нотификациям
//в момент создания модели из UI или ее редактирования: старые notifications удаляються, новые создаются в кеше
//при создании MedicineDrug модели из Entity: notifications достаются из кеша
class MedicineDrug: IdentifierModelInterface {
    
    var objectId: String?
    var name: String
    var comment: String?
    var startDate: Int
    var type: MedicineType
    var unit: MedicineUnit
    
    private var timesPrivate: [MedicineCourseTime]?
    var times: [MedicineCourseTime] {
        get {
            guard let timesPrivate = self.timesPrivate  else { return [] }
            let drugTimesSorted = timesPrivate.sorted { (left, right) -> Bool in
                return left.usageTime.rawValue() < right.usageTime.rawValue()
            }
            return drugTimesSorted
        }
        set {
            self.timesPrivate = newValue
        }
    }
    
    var endingCourseValue: Int
    var endingCourseType: EndingCourseType
    
    var periodCourseValue: Int
    var periodCourseType: PeriodCourseType
    
    var courseObjectId: String?
    
    // MARK: - Computed props
    
    var endDate: Int? {
        let timestamps = AppDelegate.serviceProvider.makeLocalNotificationService().obtainDatesNotificationsFromDrugsModel(self)
        return timestamps.last?.timestamp
    }
    
    init (name: String, comment: String, type: MedicineType, unit: MedicineUnit, startDate: Int, endingCourseValue: Int, endingCourseType: EndingCourseType, periodCourseValue: Int, periodCourseType: PeriodCourseType, times: [MedicineCourseTime]?) {
        
        self.name = name
        self.comment = comment
        self.type = type
        self.unit = unit
        self.startDate = startDate
        
        self.endingCourseValue = endingCourseValue
        self.endingCourseType = endingCourseType
        self.periodCourseValue = periodCourseValue
        self.periodCourseType = periodCourseType
        
        self.times = times ?? []
        
    }
    
    init(entity: MedicineDrugEntity) {
        self.objectId = entity.objectID.uriRepresentation().absoluteString
        self.name = entity.name ?? ""
        self.comment = entity.comment ?? ""
        self.startDate = Int(entity.startDate)
        self.endingCourseValue = Int(entity.endingCourseValue)
        self.periodCourseValue = Int(entity.periodCourseValue)
        
        guard let type = MedicineType.fromValue( Int(entity.type) ) else {
            abort()
        }
        self.type = type
        
        guard let unit = MedicineUnit.fromValue( Int(entity.unit) ) else {
            abort()
        }
        self.unit = unit
        
        guard let endingCourseType = EndingCourseType(rawValue: Int(entity.endingCourseType)) else {
            abort()
        }
        self.endingCourseType = endingCourseType
        
        guard let periodCourseType = PeriodCourseType(rawValue: Int(entity.periodCourseType)) else {
            abort()
        }
        self.periodCourseType = periodCourseType
        
        if let timesEntities = entity.times?.allObjects as? [MedicineCourseTimeEntity] {
            for timeEntity in timesEntities {
                self.times.append(MedicineCourseTime(entity: timeEntity))
            }
        }
        
    }
    
}

extension MedicineDrug: Equatable {
    
    static func == (lhs: MedicineDrug, rhs: MedicineDrug) -> Bool {
        return lhs.objectId == rhs.objectId
    }
    
}
