import SettingsApi
import Combine
import TedoooRestApi

public class SettingsApiImpl: SettingsApi {
    
    let api: TedoooRestApi.RestApiClient
    
    public init(api: TedoooRestApi.RestApiClient) {
        self.api = api
    }
    
    public func fetchNotificationSettings() -> AnyPublisher<NotificationSettings, Error> {
        return api.requestRx(outputType: NotificationSettings.self, request: .init(path: "v2/settings/notifications", withAuth: true))
            .mapError({_ in NSError(domain: "Could not fetch", code: 1)}).eraseToAnyPublisher()
//        return Just(NotificationSettings(postNotifications: false)).delay(for: 1.0, scheduler: DispatchQueue.main).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    public  func fetchAccountSettings() -> AnyPublisher<AccountSettings, Error> {
        return api.requestRx(outputType: AccountSettings.self, request: .init(path: "v2/settings/account", withAuth: true))
            .mapError({_ in NSError(domain: "Could not fetch", code: 1)}).eraseToAnyPublisher()
//        return Just(AccountSettings(lastSeen: true, localTime: false, liveTranslations: true, language: "English", email: "morapelker@gmail.com")).delay(for: 1.0, scheduler: DispatchQueue.main).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    public func launchChangeLanguage(in navController: UINavigationController) {
        print("launch change language")
    }
    
    public func updateAvatar(avatar: String?) -> AnyPublisher<Any?, Error> {
        return api.requestRx(request: .init(path: "users/current", withAuth: true, method: .patch), parameters: [
            "avatar": avatar ?? ""
        ]).mapError({_ in NSError(domain: "Could not complete this request", code: 1)}).eraseToAnyPublisher()
//        print("update avatar", avatar)
//        return Just(nil).delay(for: 1.0, scheduler: DispatchQueue.main).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
    public func updateEmail(toEmail: String) -> AnyPublisher<Any?, Error> {
        return api.requestRx(request: .init(path: "users/current", withAuth: true, method: .patch), parameters: [
            "email": toEmail
        ]).mapError({_ in NSError(domain: "Could not complete this request", code: 1)}).eraseToAnyPublisher()
//        print("update email", toEmail)
//        return Just(nil).delay(for: 1.0, scheduler: DispatchQueue.main).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
   
    public func updatePassword(oldPassword: String, newPassword: String) -> AnyPublisher<Any?, NSError> {
        /**["oldPassword": txtCurrentPassword.text ?? "", "password": txtNewPassword.text ?? ""]**/
        return api.requestRx(request: .init(path: "users/current", withAuth: true, method: .patch), parameters: [
            "oldPassword": oldPassword,
            "password": newPassword
        ]).mapError({_ in NSError(domain: "Could not complete this request", code: 1)}).eraseToAnyPublisher()
//        print("update password", oldPassword, newPassword)
//        return Fail(error: NSError(domain: "Invalid password", code: 1)).delay(for: 1.0, scheduler: DispatchQueue.main).eraseToAnyPublisher()
//        return Just(nil).delay(for: 1.0, scheduler: DispatchQueue.main).setFailureType(to: NSError.self).eraseToAnyPublisher()
    }
    
    
    public func deleteAccount() -> AnyPublisher<DeleteAccountResult?, Never> {
        return Just(DeleteAccountResult(didDelete: false)).delay(for: 1.0, scheduler: DispatchQueue.main).eraseToAnyPublisher()
//        return Just(DeleteAccountResult(didDelete: true)).delay(for: 1.0, scheduler: DispatchQueue.main).eraseToAnyPublisher()
//        return
    }

    private struct UpdateSettingRequest: Encodable {
        
        let lastSeen: Bool?
        let localTime: Bool?
        let liveTranslation: Bool?
        let postNotifications: Bool?
        
        init(
            lastSeen: Bool? = nil,
            localTime: Bool? = nil,
            liveTranslations: Bool? = nil,
            postNotifications: Bool? = nil
        ) {
            self.lastSeen = lastSeen
            self.localTime = localTime
            self.liveTranslation = liveTranslations
            self.postNotifications = postNotifications
        }
        
    }
    
    public  func updateSettingItem(item: SettingItem, newValue: Bool) -> AnyPublisher<Any?, Error> {
        let request: UpdateSettingRequest
        switch item {
        case .lastSeen:
            request = .init(lastSeen: newValue)
        case .liveTranslations:
            request = .init(liveTranslations: newValue)
        case .postNotifications:
            request = .init(postNotifications: newValue)
        case .localTime:
            request = .init(localTime: newValue)
        }
        return api.requestRx(request: .init(path: "chat", withAuth: true, method: .patch), parameters: request).mapError({_ in NSError(domain: "Setting could not be updated", code: 1)}).eraseToAnyPublisher()
        
//        return Fail(error: NSError(domain: "", code: 1)).delay(for: 1.0, scheduler: DispatchQueue.main).eraseToAnyPublisher()
//        return Just(nil).delay(for: 1.0, scheduler: DispatchQueue.main).setFailureType(to: Error.self).eraseToAnyPublisher()
    }
    
}
