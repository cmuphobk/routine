import Foundation

enum MainTableViewFactoryAssembly {

    static func build() -> MainTableViewFactoryInterface {

        let mainFactory = MainTableViewFactory()

        return mainFactory

    }

}
