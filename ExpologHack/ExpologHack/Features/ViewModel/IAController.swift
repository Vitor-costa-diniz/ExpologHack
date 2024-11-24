//
//  IAController.swift
//  ExpologHack
//
//  Created by Matheus Meneses on 24/11/24.
//

import Foundation
import OpenAI

struct Message: Identifiable {
    var id: UUID = .init()
    var content: String
    var isUser: Bool
}

class IAController: ObservableObject {
    @Published var messages: [Message] = []
    @Published var response: String = ""
    
    let openAI = OpenAI(apiToken: "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")
    
    func sendNewMessage(departure: String, content: [String]) {
        let message = "Os endereços apresentados \(content) correspondem a uma rota de entrega que saira do endereço \(departure), baseado nisso avalie o percurso entre os locais e ordene em um array com a melhor ordem de paradas. como resposta quero apenas os endereços ordenados, separados por vírgula"
        let userMessage = Message(content: message, isUser: true)
        self.messages.append(userMessage)
    }
    
    func getBotReply() {
        let query = ChatQuery(
            messages: self.messages.map({
                .init(role: .user, content: $0.content)!
            }),
            model: .gpt3_5Turbo
        )
        
        openAI.chats(query: query) { result in
            switch result {
            case .success(let success):
                guard let choice = success.choices.first else {
                    return
                }
                guard let message = choice.message.content?.string else { return }
                DispatchQueue.main.async {
                    self.response = message
                }
            case .failure(let failure):
                print(failure)
            }
        }
    }
}
