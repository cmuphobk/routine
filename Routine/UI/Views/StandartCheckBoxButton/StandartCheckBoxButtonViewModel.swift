import Foundation


class StandartCheckBoxButtonViewModel: RoutineButtonViewModel {
    
    var windowService: WindowServiceInterface
    
    init(routineDelegate: RoutineDelegate?, windowService: WindowServiceInterface) {
        self.windowService = windowService
        super.init(routineDelegate: routineDelegate)
    }
    
}
