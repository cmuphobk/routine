
import Foundation

protocol DecodeResponseContainerInterface {
    
    associatedtype DecodeResponseType
    
    var decodeResponse: DecodeResponseType? { get set }
    
}
