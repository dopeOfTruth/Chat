//
//  AuthError.swift
//  IChat
//
//  Created by Михаил Красильник on 19.04.2021.
//

import Foundation

enum AuthError {
    case notFilled
    case invalidEmail
    case passwordNotMatched
    case unknownError
    case serverError
}


extension AuthError: LocalizedError {
    
    private var errorDescription: String {
        
        switch self {
        
        case .notFilled:
            return NSLocalizedString("Filling all fields", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Invalid email", comment: "")
        case .passwordNotMatched:
            return NSLocalizedString("Passwords is not matched", comment: "")
        case .unknownError:
            return NSLocalizedString("Unknown errror", comment: "")
        case .serverError:
            return NSLocalizedString("Server is not available", comment: "")
        }
    }
}
