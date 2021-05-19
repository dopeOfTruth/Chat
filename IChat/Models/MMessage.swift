//
//  MMessage.swift
//  IChat
//
//  Created by Михаил Красильник on 26.04.2021.
//

import Foundation
import FirebaseFirestore
import MessageKit

struct imageItem: MediaItem {
    var url: URL?
    
    var image: UIImage?
    
    var placeholderImage: UIImage
    
    var size: CGSize
}

struct MMessage: Hashable, MessageType {
    
    let content: String
    var sentDate: Date
    let id: String?
    
    var sender: SenderType
    
    var messageId: String {
        return id ?? UUID().uuidString
    }
    
    var kind: MessageKind {
        if let image = image {
            let imageItem = imageItem(url: nil, image: nil, placeholderImage: image, size: image.size)
            return .photo(imageItem)
        } else {
            return .text(content)
        }
    }
    
    var image: UIImage? = nil
    var downloadURL: URL? = nil

    init(user: MUser, content: String) {
        self.content = content
        sentDate = Date()
        sender = Sender(senderId: user.id, displayName: user.username)
        id = nil
    }
    
    init(user: MUser, image: UIImage) {
        sentDate = Date()
        sender = Sender(senderId: user.id, displayName: user.username)
        self.image = image
        content = ""
        id = nil
    }
    
    init?(document: QueryDocumentSnapshot) {
        let data = document.data()
        guard let sentDate = data["created"] as? Timestamp,
              let senderId = data["senderId"] as? String,
              let senderUsername = data["senderName"] as? String
        else { return nil }
        
        self.id = document.documentID
        self.sentDate = sentDate.dateValue()
        sender = Sender(senderId: senderId, displayName: senderUsername)
        
        if  let content = data["content"] as? String {
            self.content = content
            self.downloadURL = nil
        } else if let urlString = data["url"] as? String, let url = URL(string: urlString) {
            self.downloadURL = url
            self.content = ""
        } else {
            return nil
        }
        
        
    }
    
    var representaztion: [String: Any] {
        var rep: [String: Any] = [
            "created": sentDate,
            "senderId": sender.senderId,
            "senderName": sender.displayName
        ]
        
        if let url = downloadURL {
            rep["url"] = url.absoluteString
        } else {
            rep["content"] = content
        }
        return rep
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(messageId)
    }
    
    static func == (lhs: MMessage, rhs: MMessage) -> Bool {
        lhs.messageId == rhs.messageId
    }
}
