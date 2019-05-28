import Foundation

enum WindowServiceAssembly {

    static func build() -> WindowServiceInterface {

        let windowService = WindowService.shared
        return windowService

    }

}
