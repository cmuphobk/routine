import Foundation


class StandartAcceptButtonViewModel: RoutineButtonViewModel {
    
    var windowService: WindowServiceInterface
    
    init(routineDelegate: RoutineDelegate?, windowService: WindowServiceInterface) {
        self.windowService = windowService
        super.init(routineDelegate: routineDelegate)
    }
    
}
