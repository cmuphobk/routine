import Foundation

final class StorageService: StorageServiceInterface {

    static var shared = StorageService()

    private init () {}

    private var standart = UserDefaults.standard

    func object(forKey defaultName: String) -> Any? {
        return self.standart.object(forKey: defaultName)
    }

    func set(_ value: Any?, forKey defaultName: String) {
        self.standart.set(value, forKey: defaultName)
    }

    func removeObject(forKey defaultName: String) {
        self.standart.removeObject(forKey: defaultName)
    }

    func string(forKey defaultName: String) -> String? {
        return self.standart.string(forKey: defaultName)
    }

    func array(forKey defaultName: String) -> [Any]? {
        return self.standart.array(forKey: defaultName)
    }

    func dictionary(forKey defaultName: String) -> [String: Any]? {
        return self.standart.dictionary(forKey: defaultName)
    }

    func data(forKey defaultName: String) -> Data? {
        return self.standart.data(forKey: defaultName)
    }

    func stringArray(forKey defaultName: String) -> [String]? {
        return self.standart.stringArray(forKey: defaultName)
    }

    func integer(forKey defaultName: String) -> Int {
        return self.standart.integer(forKey: defaultName)
    }

    func float(forKey defaultName: String) -> Float {
        return self.standart.float(forKey: defaultName)
    }

    func double(forKey defaultName: String) -> Double {
        return self.standart.double(forKey: defaultName)
    }

    func bool(forKey defaultName: String) -> Bool {
        return self.standart.bool(forKey: defaultName)
    }

    func url(forKey defaultName: String) -> URL? {
        return self.standart.url(forKey: defaultName)
    }

    func set(_ value: Int, forKey defaultName: String) {
        self.standart.set(value, forKey: defaultName)
    }

    func set(_ value: Float, forKey defaultName: String) {
        self.standart.set(value, forKey: defaultName)
    }

    func set(_ value: Double, forKey defaultName: String) {
        self.standart.set(value, forKey: defaultName)
    }

    func set(_ value: Bool, forKey defaultName: String) {
        self.standart.set(value, forKey: defaultName)
    }

    func set(_ url: URL?, forKey defaultName: String) {
        self.standart.set(url, forKey: defaultName)
    }

    func synchronize() -> Bool {
        return self.standart.synchronize()
    }

}
