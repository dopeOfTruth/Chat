//
//  MUser.swift
//  IChat
//
//  Created by Михаил Красильник on 18.04.2021.
//

import Foundation
import FirebaseFirestore

struct MUser: Hashable, Decodable {
    var username: String
    var email: String
    var avatarStringURL: String
    var description: String
    var sex: String
    var id: String
    
    var representation: [String: Any] {
        var rep = ["username": username]
        rep["email"] = email
        rep["avatarStringURL"] = avatarStringURL
        rep["description"] = description
        rep["sex"] = sex
        rep["id"] = id
        return rep
    }
    
    init(username: String,email: String, avatarStringURL: String, description: String, sex: String, id: String) {
        
        self.username = username
        self.avatarStringURL = avatarStringURL
        self.description = description
        self.email = email
        self.id = id
        self.sex = sex 
    }
    
    init?(document: DocumentSnapshot) {
        guard let data = document.data() else { return nil }
        guard let username = data["username"] as? String,
              let avatarStringURL = data["avatarStringURL"] as? String,
              let description = data["description"] as? String,
              let email = data["email"] as? String,
              let id = data["id"] as? String,
              let sex = data["sex"] as? String
              else { return nil }
        
        self.username = username
        self.avatarStringURL = avatarStringURL
        self.description = description
        self.email = email
        self.id = id
        self.sex = sex 
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data() 
        guard let username = data["username"] as? String,
              let avatarStringURL = data["avatarStringURL"] as? String,
              let description = data["description"] as? String,
              let email = data["email"] as? String,
              let id = data["id"] as? String,
              let sex = data["sex"] as? String
              else { return nil }
        
        self.username = username
        self.avatarStringURL = avatarStringURL
        self.description = description
        self.email = email
        self.id = id
        self.sex = sex
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    static func == (lhs: MUser, rhs: MUser) -> Bool {
        lhs.id == rhs.id
    }
    
    func contains(filter: String?) -> Bool {
        guard let filter = filter else { return true }
        if filter.isEmpty { return true }
        let lowercasedFilter = filter.lowercased()
        return username.lowercased().contains(lowercasedFilter)
    }
}
