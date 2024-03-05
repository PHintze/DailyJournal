//
//  SecurityController.swift
//  DailyJournal
//
//  Created by Pascal Hintze on 29.02.2024.
//

import Foundation
import LocalAuthentication

@MainActor
class SecurityController: ObservableObject {
    var error: NSError?

    @Published var isLocked: Bool = UserDefaults.standard.object(forKey: "isLocked") as? Bool ?? false
    @Published var isAppLockEnabled: Bool = UserDefaults.standard.object(forKey: "isAppLockEnabled") as? Bool ?? false
}

extension SecurityController {

    func authenticate() {
        let context = LAContext()
        let reason = "Authenticate yourself to unlock Locker"
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,
                                   localizedReason: reason) { success, error in
                Task { @MainActor in
                    if success {
                        self.isLocked = false
                        UserDefaults.standard.set(self.isLocked, forKey: "isLocked")
                    } else {
                        print(error ?? "Authentication Failed")
                    }
                }
            }
        }
    }

}

extension SecurityController {

    func appLockStateChange(_ isEnabled: Bool) {
        let context = LAContext()
        let reason = "Authenticate to toggle App Lock"
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
                Task { @MainActor in
                    if success {
                        self.isLocked = false
                        UserDefaults.standard.set(false, forKey: "isLocked")
                        self.isAppLockEnabled = isEnabled
                        UserDefaults.standard.set(self.isAppLockEnabled, forKey: "isAppLockEnabled")
                    } else {
                        print(error ?? "Authentication Failed")
                    }
                }
            }
        }
    }

}

extension SecurityController {

    func showLockedViewIfEnabled() {
        if isAppLockEnabled {
            isLocked = true
            UserDefaults.standard.set(true, forKey: "isLocked")

            authenticate()
        } else {
            isLocked = false
            UserDefaults.standard.set(false, forKey: "isLocked")
        }
    }

    func lockApp() {
        if isAppLockEnabled {
            isLocked = true
            UserDefaults.standard.set(true, forKey: "isLocked")
        } else {
            isLocked = false
            UserDefaults.standard.set(false, forKey: "isLocked")
        }
    }

}
