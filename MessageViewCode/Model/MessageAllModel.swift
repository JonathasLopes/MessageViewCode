//
//  MessageAllModel.swift
//  MessageViewCode
//
//  Created by Jonathas Lopes on 07/02/24.
//

import Foundation

class Message {
    var text:String?
    var userId:String?
    
    init(dictionary: [String:Any]) {
        self.text = dictionary["text"] as? String
        self.userId = dictionary["userId"] as? String
    }
}

class Conversation {
    var name:String?
    var lastMessage:String?
    var recipientId:String?
    
    init(dictionary: [String:Any]) {
        self.name = dictionary["name"] as? String
        self.lastMessage = dictionary["lastMessage"] as? String
        self.recipientId = dictionary["recipientId"] as? String
    }
}

class User {
    var name:String?
    var email:String?
    
    init(dictionary: [String:Any]) {
        self.name = dictionary["name"] as? String
        self.email = dictionary["email"] as? String
    }
}

class Contact {
    var name:String?
    var id:String?
    
    init(dictionary: [String:Any]?) {
        self.name = dictionary?["name"] as? String
        self.id = dictionary?["id"] as? String
    }
    
    convenience init(name:String?, id:String?) {
        self.init(dictionary: nil)
        self.name = name
        self.id = id
    }
}
