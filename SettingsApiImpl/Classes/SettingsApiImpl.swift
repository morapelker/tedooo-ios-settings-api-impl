import SettingsApi
import Combine

public class SettingsApiImpl: SettingsApi {

    
    
    public func launchChangeLanguage(in navController: UINavigationController) {
        print("launch change language")
    }
    
    public func updateAvatar(avatar: String?) -> AnyPublisher<Any?, Error> {
        print("update avatar", avatar)
        return Just(nil).delay(for: 1.0, scheduler: DispatchQueue.main).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    public func updateEmail(toEmail: String) -> AnyPublisher<Any?, Error> {
        print("update email", toEmail)
        return Just(nil).delay(for: 1.0, scheduler: DispatchQueue.main).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    public  func fetchAccountSettings() -> AnyPublisher<AccountSettings, Error> {
        return Just(AccountSettings(lastSeen: true, localTime: false, liveTranslations: true, language: "English", email: "morapelker@gmail.com")).delay(for: 1.0, scheduler: DispatchQueue.main).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
   
    public func updatePassword(oldPassword: String, newPassword: String) -> AnyPublisher<String, NSError> {
        print("update password", oldPassword, newPassword)
//        return Fail(error: NSError(domain: "Invalid password", code: 1)).delay(for: 1.0, scheduler: DispatchQueue.main).eraseToAnyPublisher()
        return Just("new token").delay(for: 1.0, scheduler: DispatchQueue.main).setFailureType(to: NSError.self).eraseToAnyPublisher()
    }
    
    
    public func deleteAccount() -> AnyPublisher<DeleteAccountResult?, Never> {
        return Just(DeleteAccountResult(didDelete: false)).delay(for: 1.0, scheduler: DispatchQueue.main).eraseToAnyPublisher()
//        return Just(DeleteAccountResult(didDelete: true)).delay(for: 1.0, scheduler: DispatchQueue.main).eraseToAnyPublisher()
//        return
    }

    
    public func fetchNotificationSettings() -> AnyPublisher<NotificationSettings, Error> {
        return Just(NotificationSettings(postNotifications: false)).delay(for: 1.0, scheduler: DispatchQueue.main).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    public  func updateSettingItem(item: SettingItem, newValue: Bool) -> AnyPublisher<Any?, Error> {
        print("update settings item", item, newValue)
//        return Fail(error: NSError(domain: "", code: 1)).delay(for: 1.0, scheduler: DispatchQueue.main).eraseToAnyPublisher()
        return Just(nil).delay(for: 1.0, scheduler: DispatchQueue.main).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
}
