//
//  ChatViewModel.swift
//  Karouka
//
//  Created by Rawan Alamirah on 03/12/2023.
//

import Foundation

extension chatbot {
    class ChatModel: ObservableObject {
        @Published var messages: [Message] = []
        @Published var currentInput: String = ""
        private let openAIService = OpenAIService()
        func sendMessage() {
            let newMessage = Message(id: UUID(), role: .user, content: currentInput, createAt: Date())
            messages.append(newMessage)
            currentInput = ""
            
            Task {
                let response = try await openAIService.sendMessage(messages: messages)
                guard let recievedOpenAIMessage = response.choices.first?.message else {
                    print("no received")
                    return
                }
                let receivedMessage = Message(id: UUID(), role: recievedOpenAIMessage.role, content: recievedOpenAIMessage.content, createAt: Date())
                await MainActor.run {
                    messages.append(receivedMessage)
                }
                
            }
        }
    }
}

struct Message: Decodable {
    let id: UUID
    let role: SenderRole
    let content: String
    let createAt: Date
}
