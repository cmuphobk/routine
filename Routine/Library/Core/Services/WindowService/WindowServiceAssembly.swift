import Foundation

enum WindowServiceAssembly {
    static func build() -> WindowServiceInterface {
        let windowService = WindowService()
        return windowService
    }
}
