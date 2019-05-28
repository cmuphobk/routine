import Foundation
import CoreData

protocol ConfigurableEntityInterface: class {

    func configureWithModel(_ model: IdentifierModelInterface) -> Bool

}
