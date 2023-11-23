//
//  ChatMessageModel.swift
//  Karouka
//
//  Created by Rawan Alamirah on 21/11/2023.
//

import Foundation

struct ChatMessage {
    let id: String
    let content: String
    let createdAt: Date
    let sender: MessageSender
}

enum MessageSender {
    case me
    case chatGPT
}
