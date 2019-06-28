import Foundation

protocol NotificationServiceInterface: class {

    func addObserver(_ observer: Any,
                     selector aSelector: Selector,
                     name aName: NSNotification.Name?,
                     object anObject: Any?)

    func post(_ notification: Notification)

    func post(name aName: NSNotification.Name, object anObject: Any?)

    func post(name aName: NSNotification.Name, object anObject: Any?, userInfo aUserInfo: [AnyHashable: Any]?)

    func removeObserver(_ observer: Any)

    func removeObserver(_ observer: Any, name aName: NSNotification.Name?, object anObject: Any?)

}
