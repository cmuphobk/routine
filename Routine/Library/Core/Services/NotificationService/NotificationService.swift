import Foundation

final class NotificationService: NotificationServiceInterface {
    
    private var `default` = NotificationCenter.default
    
    static var shared = NotificationService()
    
    private init () {}
    
    func addObserver(_ observer: Any, selector aSelector: Selector, name aName: NSNotification.Name?, object anObject: Any?) {
        self.default.addObserver(observer, selector: aSelector, name: aName, object: anObject)
    }
    
    func post(_ notification: Notification) {
        self.default.post(notification)
    }
    
    func post(name aName: NSNotification.Name, object anObject: Any?) {
        self.default.post(name: aName, object: anObject)
    }
    
    func post(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable: Any]? = nil) {
        self.default.post(name: aName, object: anObject, userInfo: aUserInfo)
    }
    
    func removeObserver(_ observer: Any) {
        self.default.removeObserver(observer)
    }
    
    func removeObserver(_ observer: Any, name aName: NSNotification.Name?, object anObject: Any?) {
        self.default.removeObserver(observer, name: aName, object: anObject)
    }
    
}
