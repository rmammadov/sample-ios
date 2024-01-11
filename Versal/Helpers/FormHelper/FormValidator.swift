//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import UIKit

public typealias ValidationResult = (Bool, String, ValidationType)

public enum ValidationType {
    case accountNumber // i.e. bank account number
    case addressCity
    case addressCountry
    case addressLine1
    case addressPostcode
    case addressRegion
    case address // i.e. blockchain and address
    case amount
    case bankName
    case birthday
    case blockchain
    case checkBoxTerms
    case confirmPassword
    case country
    case currency
    case currentPassword
    case email
    case firstName
    case general
    case lastName
    case name
    case nationalIdNumber
    case newPassword
    case password
    case phoneNumber
    case routingNumber
    case timezone
    case transferAmount
    case username
    case walletAddress
    case walletName
}

protocol FormValidator {
    func handleError(_ error: Error)
    func handleError401()
    func handleError404()
    func handleErrors(_ errors: [ValidationResult])
    @discardableResult func handleValidationType(_ validationResult: ValidationResult) -> Bool

    // MARK: - Call These Functions To Check Validations
    func requireAccountNumberValidation(_ text: String?, _ validationType: ValidationType, _ title: String) -> ValidationResult
    func requireConfirmPassword(_ password: String?, _ confirmPassword: String?) -> ValidationResult
    func requireEmail(_ text: String?, _ title: String) -> ValidationResult
    func requireGenericValidation(_ text: String?, _ validationType: ValidationType) -> ValidationResult
    func requireGenericValidation(_ text: String?, _ validationType: ValidationType, _ existingText: String?) -> ValidationResult
    func requirePassword(_ text: String?, _ title: String) -> ValidationResult
    func requireRoutingNumberValidation(_ text: String?, _ validationType: ValidationType, _ title: String) -> ValidationResult
    func requireSecurePassword(_ text: String?, _ validationType: ValidationType, _ title: String) -> ValidationResult
    func requireValidEmail(_ text: String?, _ title: String) -> ValidationResult

    // MARK: - Base Validation Function
    func validateText(_ validateText: String?, _ rules: [FormValidError], _ existingText: String?) throws -> String
}

extension FormValidator {
    func handleError(_ error: Error) {
        // We expect all errors to be WelliWalletErrors
        if let error = error as? WelliWalletError {
            if let errors = error.errors {
                // Convert the errors into validation results that the controller can process
                handleErrors(errors.uniqued { $0.parameter }.map { $0.code!.validationResult })
            } else if error.status == 401 {
                // Each controller may handle the 401 differently
                handleError401()
            } else if error.status == 404 {
                // Each controller may handle the 404 differently
                handleError404()
            } else {
                // There was some other rare/unexpected http status
                handleErrors([ValidationResult(false, L10N.get(.serverError(.general)), .general)])
            }
        } else {
            // There was an unexpected error in the promise chain. All we can do is log it.
            Log.error(error)
        }
    }

    func handleError401() {}

    func handleError404() {}

    func handleErrors(_ errors: [ValidationResult]) {
        errors.forEach { handleValidationType($0) }
    }

    @discardableResult func handleValidationType(_: ValidationResult) -> Bool {
        return true
    }

    // MARK: - Handle Validation Responses
    func requireAccountNumberValidation(_ text: String?, _ validationType: ValidationType, _ title: String) -> ValidationResult {
        do {
            let genericValidation = try validateText(text, [
                .empty(name: ""),
                .minimumLengthAccountNumber(name: title, length: LengthConstants.MinimumLengthAccountNumber)
            ])
            return (true, genericValidation, validationType)
        } catch {
            return (false, "\(error)", validationType)
        }
    }

    func requireConfirmPassword(_ password: String?, _ confirmPassword: String?) -> ValidationResult {
        do {
            let password = try validateText(password, [
                .empty(name: ""),
                .confirmPassword(password: confirmPassword)
            ])
            return (true, password, .confirmPassword)
        } catch {
            return (false, "\(error)", .confirmPassword)
        }
    }

    func requireEmail(_ text: String?, _ title: String = "\(L10N.get(.validation(.email)))") -> ValidationResult {
        do {
            let email = try validateText(text, [.empty(name: title)])
            return (true, email, .email)
        } catch {
            return (false, "\(error)", .email)
        }
    }

    func requireGenericValidation(_ text: String?, _ validationType: ValidationType) -> ValidationResult {
        do {
            let genericValidation = try validateText(text, [.empty(name: "")])
            return (true, genericValidation, validationType)
        } catch {
            return (false, "\(error)", validationType)
        }
    }

    func requireGenericValidation(_ text: String?, _ validationType: ValidationType, _ existingText: String?) -> ValidationResult {
        do {
            let genericValidation = try validateText(text, [.requiredWhenExisting(name: "")], existingText)
            return (true, genericValidation, validationType)
        } catch {
            return (false, "\(error)", validationType)
        }
    }

    func requirePassword(_ text: String?, _ title: String = "\(L10N.get(.validation(.password)))") -> ValidationResult {
        do {
            let password = try validateText(text, [.empty(name: title)])
            return (true, password, .password)
        } catch {
            return (false, "\(error)", .password)
        }
    }

    func requireRoutingNumberValidation(_ text: String?, _ validationType: ValidationType, _ title: String) -> ValidationResult {
        do {
            let genericValidation = try validateText(text, [
                .empty(name: ""),
                .minimumLengthRoutingNumber(name: title, length: LengthConstants.MinimumLengthRoutingNumber)
            ])
            return (true, genericValidation, validationType)
        } catch {
            return (false, "\(error)", validationType)
        }
    }

    func requireSecurePassword(_ text: String?, _ validationType: ValidationType = .password, _ title: String = "\(L10N.get(.validation(.password)))") -> ValidationResult {
        do {
            let password = try validateText(text, [
                .empty(name: title),
                .minimumLengthPassword(name: title, length: LengthConstants.MinimumLengthPassword),
                .hasNumbers,
                .hasUppercase,
                .hasLowercase
            ])
            return (true, password, validationType)
        } catch {
            return (false, "\(error)", validationType)
        }
    }

    func requireValidEmail(_ text: String?, _ title: String = "\(L10N.get(.validation(.email)))") -> ValidationResult {
        do {
            let email = try validateText(text, [.empty(name: title), .validEmail])
            return (true, email, .email)
        } catch {
            return (false, "\(error)", .email)
        }
    }

    // Base Validation Function
    func validateText(_ validateText: String?, _ rules: [FormValidError], _ existingText: String? = nil) throws -> String { // swiftlint:disable:this cyclomatic_complexity
        for rule in rules {
            switch rule {
            case let .confirmPassword(matchText):
                guard let text = validateText, text == matchText else {
                    throw FormValidError.confirmPassword(password: matchText)
                }
            case let .empty(name):
                guard let text = validateText, !text.isEmptyOrWhitespace else {
                    throw FormValidError.empty(name: name)
                }
            case let .requiredWhenExisting(field):
                if let existingText = existingText, !existingText.isEmptyOrWhitespace {
                    if let text = validateText, text.isEmptyOrWhitespace {
                        throw FormValidError.empty(name: field)
                    }
                }
            case let .maximumLength(name, value):
                guard let text = validateText, text.count <= value else {
                    throw FormValidError.maximumLength(name: name, length: value)
                }
            case let .minimumLengthAccountNumber(name, value):
                guard let text = validateText, text.count >= value else {
                    throw FormValidError.minimumLengthAccountNumber(name: name, length: value)
                }
            case let .minimumLengthPassword(name, value):
                guard let text = validateText, text.count >= value else {
                    throw FormValidError.minimumLengthPassword(name: name, length: value)
                }
            case let .minimumLengthRoutingNumber(name, value):
                guard let text = validateText, text.count >= value else {
                    throw FormValidError.minimumLengthRoutingNumber(name: name, length: value)
                }
            case .validEmail:
                guard let text = validateText, text.isValidEmailFormat else {
                    throw FormValidError.validEmail
                }
            case .hasNumbers:
                guard let text = validateText, text.containsNumbers else {
                    throw FormValidError.hasNumbers
                }
            case .hasLowercase:
                guard let text = validateText, text.containsLowercase else {
                    throw FormValidError.hasLowercase
                }
            case .hasUppercase:
                guard let text = validateText, text.containsUppercase else {
                    throw FormValidError.hasUppercase
                }
            default: break
            }
        }

        return validateText ?? ""
    }
}
