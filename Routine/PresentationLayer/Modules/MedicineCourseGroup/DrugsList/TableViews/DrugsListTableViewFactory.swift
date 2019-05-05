import UIKit

final class DrugsListTableViewFactory {
    
    static func drugsListCellViewModels(model: MedicineCourse) -> [LocalizedTableViewCellViewModel] {
        var cellObjs: [DrugCellViewModel] = []
        
        for item in model.drugs ?? [] {
            let cellViewModel = self.drugsListCellViewModel(model: item)
            cellObjs += [cellViewModel]
        }
        
        return cellObjs
    }
    
    static func drugsListCellViewModel(model: MedicineDrug) -> DrugCellViewModel {
        var times: [String] = []
        
        let medTimes = model.times
        for medTime in medTimes {
            times += [medTime.usageTime.toString()]
        }
        
        return DrugCellViewModel(type: model.type,
                              name: model.name,
                              times: times.joined(separator: "   "),
                              isOver: Int(Date().timeIntervalSince1970 * 1000.0) > (model.endDate ?? 0))
    }
}
