import Foundation
import UIKit

// FIXME: - all factory to instance and protocol
final class DrugPeriodicEditTableViewFactory {
    
    static func makeDays(withValue: Int) -> [RoutineTableViewCellViewModel] {
        
        var cellViewModels: [RoutineTableViewCellViewModel] = []
        
        for item in DayOfWeek.allCases {
            
            let labelAndMarkCellViewModel = self.makeDay(text: item.toFullString(), isSelected: item.checkIfExist(UInt8(withValue)))
            
            cellViewModels += [labelAndMarkCellViewModel]
            
        }
        
        let labelAndMarkCellViewModel = self.makeDay(text: AppDelegate.serviceProvider.makeStringService().localizeById("full_allday"), isSelected: UInt8(withValue) == DayOfWeek.allDay)
        
        cellViewModels += [labelAndMarkCellViewModel]
                
        return cellViewModels
    }
    
    static func makeDay(text: String, isSelected: Bool) -> RoutineTableViewCellViewModel {
        
        let labelAndMarkCellViewModel = LabelAndMarkCellViewModel()
        labelAndMarkCellViewModel.isSelected = isSelected
        
        labelAndMarkCellViewModel.paddingOffsets = Offsets(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0)
        labelAndMarkCellViewModel.betweenSpace = 12.0
        
        let labelCfg = RoutineLabelViewModel()
        labelCfg.text = text
        labelCfg.textColor = ColorProvider.medicineCourseColors.text
        labelCfg.font = FontProvider.medicineCourseFonts.general
        
        let markIcon = RoutineImageViewModel()
        markIcon.image = ImageProvider.drugEditImages.periodCheckMarkIcon
        markIcon.contentMode = .scaleAspectFill
        markIcon.width = 12.0
        markIcon.height = 8.0
        
        labelAndMarkCellViewModel.label = labelCfg
        labelAndMarkCellViewModel.image = markIcon
        
        return labelAndMarkCellViewModel
        
    }
    
    static func makeCountDays(withValue: Int) -> [RoutineTableViewCellViewModel] {
        
        var cellViewModels: [RoutineTableViewCellViewModel] = []
        
        for item in DaysPeriod.allCases {
            
            let labelAndMarkCellViewModel = LabelAndMarkCellViewModel()
            
            labelAndMarkCellViewModel.paddingOffsets = Offsets(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0)
            labelAndMarkCellViewModel.betweenSpace = 12.0
            
            let labelCfg = RoutineLabelViewModel()
            labelCfg.text = item.toString()
            labelCfg.textColor = ColorProvider.medicineCourseColors.text
            labelCfg.font = FontProvider.medicineCourseFonts.general
            
            let markIcon = RoutineImageViewModel()
            markIcon.image = ImageProvider.drugEditImages.periodCheckMarkIcon
            markIcon.contentMode = .scaleAspectFill
            markIcon.width = 12.0
            markIcon.height = 8.0
            
            labelAndMarkCellViewModel.label = labelCfg
            labelAndMarkCellViewModel.image = markIcon
            
            cellViewModels += [labelAndMarkCellViewModel]
            
        }
        
        return cellViewModels
    }
    
}
