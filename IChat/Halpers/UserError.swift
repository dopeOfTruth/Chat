//
//  UserError.swift
//  IChat
//
//  Created by Михаил Красильник on 24.04.2021.
//

import Foundation

enum UserError {
    case notFilled
    case photoNotExist
    case canNotGetUserInfo
    case canNotUnwrapeToMUser
}

extension UserError: LocalizedError {
    
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Filling all fields", comment: "")
        case .photoNotExist:
            return NSLocalizedString("Photo not exist", comment: "")
        case .canNotGetUserInfo:
            return NSLocalizedString("Can't get user info", comment: "")
        case .canNotUnwrapeToMUser:
            return NSLocalizedString("Can't unwrape document", comment: "")
        }
    }
}
