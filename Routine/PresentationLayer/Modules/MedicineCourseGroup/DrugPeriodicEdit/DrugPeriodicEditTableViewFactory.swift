import Foundation
import UIKit

// FIXME: - all factory to instance and protocol
final class DrugPeriodicEditTableViewFactory {
    
    static func makeDays(withValue: Int) -> [RoutineTableViewCellViewModel] {
        
        var cellViewModels: [RoutineTableViewCellViewModel] = []
        
        for item in DayOfWeek.allCases {
            
            let labelAndMarkCellViewModel = self.makeDay(text: item.toFullString(localizeService: AppDelegate.serviceProvider.makeStringService()),
                                                         isSelected: item.checkIfExist(UInt8(withValue)))
            
            cellViewModels += [labelAndMarkCellViewModel]
            
        }
        
        let labelAndMarkCellViewModel = self.makeDay(text: AppDelegate.serviceProvider.makeStringService().localizeId("full_allday"), isSelected: UInt8(withValue) == DayOfWeek.allDay)
        
        cellViewModels += [labelAndMarkCellViewModel]
                
        return cellViewModels
    }
    
    static func makeDay(text: String, isSelected: Bool) -> RoutineTableViewCellViewModel {
        
        let labelAndMarkCellViewModel = LabelAndMarkCellViewModel(routineDelegate: AppDelegate.serviceProvider.makeStringService())
        labelAndMarkCellViewModel.isSelected = isSelected
        
        labelAndMarkCellViewModel.paddingOffsets = Offsets(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0)
        labelAndMarkCellViewModel.betweenSpace = 12.0
        
        let labelCfg = RoutineLabelViewModel(routineDelegate: AppDelegate.serviceProvider.makeStringService())
        labelCfg.text = text
        labelCfg.textColor = ColorProvider.medicineCourseColors.text
        labelCfg.font = FontProvider.medicineCourseFonts.general
        
        let markIcon = RoutineImageViewModel(routineDelegate: AppDelegate.serviceProvider.makeStringService())
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
            
            let labelAndMarkCellViewModel = LabelAndMarkCellViewModel(routineDelegate: AppDelegate.serviceProvider.makeStringService())
            
            labelAndMarkCellViewModel.paddingOffsets = Offsets(top: 8.0, bottom: 8.0, left: 8.0, right: 8.0)
            labelAndMarkCellViewModel.betweenSpace = 12.0
            
            let labelCfg = RoutineLabelViewModel(routineDelegate: AppDelegate.serviceProvider.makeStringService())
            labelCfg.text = item.toString(localizeService: AppDelegate.serviceProvider.makeStringService())
            labelCfg.textColor = ColorProvider.medicineCourseColors.text
            labelCfg.font = FontProvider.medicineCourseFonts.general
            
            let markIcon = RoutineImageViewModel(routineDelegate: AppDelegate.serviceProvider.makeStringService())
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
