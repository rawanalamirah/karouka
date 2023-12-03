//
//  OpenAIService.swift
//  Karouka
//
//  Created by Rawan Alamirah on 03/12/2023.
//

import Foundation
import Alamofire

class OpenAIService {
    let endpointUrl = "https://api.openai.com/v1/chat/completions"
    
    func sendMessage(messages: [Message]) async throws -> OpenAIChatResponse {
        let openAIMessages = messages.map({ OpenAIChatMessage(role: $0.role, content: $0.content) })
        let body = OpenAIChatBody(model: "gpt-3.5-turbo", messages: openAIMessages)
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(Constants.openAIAPIKey)"
        ]

        return try await withCheckedThrowingContinuation { continuation in
            AF.request(endpointUrl, method: .post, parameters: body, encoder: JSONParameterEncoder.default, headers: headers)
                .validate()
                .responseDecodable(of: OpenAIChatResponse.self) { response in
                    switch response.result {
                    case .success(let value):
                        continuation.resume(returning: value)
                    case .failure(let error):
                        continuation.resume(throwing: error)
                    }
                }
        }
    }


    }

enum ChatServiceError: Error {
    case invalidResponse
    case decodingError
}

struct OpenAIChatBody: Encodable {
    let model: String
    let messages: [OpenAIChatMessage]
}

struct OpenAIChatMessage: Codable {
    let role: SenderRole
    let content: String
}

enum SenderRole: String, Codable {
    case system
    case user
    case assistant
}

struct OpenAIChatResponse: Decodable {
    let choices: [OpenAIChatChoice]
}

struct OpenAIChatChoice: Decodable {
    let message: OpenAIChatMessage
}
