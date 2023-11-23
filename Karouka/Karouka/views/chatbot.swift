import SwiftUI
import Combine

struct chatbot: View {
    @State var chatMessages: [ChatMessage] = []
    @State var message: String = ""
    let openAIService = OpenAIService()
    var isLoading: Bool = OpenAIService().isLoading
    
    @State var lastMessageID: String = ""
    
    
    @State var cancellables = Set<AnyCancellable>()
    
    var body: some View {
        VStack {
            HStack {
                Text("Chat with us")
                    .font(.title)
                    .fontWeight(.bold)
                Spacer()
            }
            
            ScrollViewReader { proxy in
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVStack {
                        ForEach(chatMessages, id: \.id) { message in
                            MessageView(message: message)
                        }
                    }
                }
                .onChange(of: self.lastMessageID) { id in
                    withAnimation{
                        proxy.scrollTo(id, anchor: .bottom)
                    }
                }
            }
            
            HStack {
                TextField("Enter a message", text: $message) {}
                    .padding()
                    .background(.gray.opacity(0.4))
                    .cornerRadius(12)
                Button{
                    sendMessage()
                } label: {
                    Image(systemName: "arrow.right.circle.fill")
                        .foregroundColor(Color(red: 180/255, green: 200/255, blue: 255/255))
                        .padding(.horizontal, 5)
                        .font(.largeTitle)
                        
                }
            }
        }
        .padding()
    }
        
    func sendMessage() {
        guard !message.isEmpty else { return }
        
        let myMessage = ChatMessage(id: UUID().uuidString, content: message, createdAt: Date(), sender: .me)
        chatMessages.append(myMessage)
        lastMessageID = myMessage.id
        
        openAIService.sendMessage(message: message)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error sending message: \(error.localizedDescription)")
                    // Handle error appropriately (e.g., show an error message)
                    
                case .finished:
                    break
                }
            } receiveValue: { response in
                guard let textResponse = response.choices.first?.text.trimmingCharacters(in: .whitespacesAndNewlines.union(.init(charactersIn: "\""))) else { return }
                
                let chatGPTMessage = ChatMessage(id: response.id, content: textResponse, createdAt: Date(), sender: .chatGPT)
                
                chatMessages.append(chatGPTMessage)
                lastMessageID = chatGPTMessage.id
            }
            .store(in: &cancellables)
        
        message = ""
    }

}

struct chatbot_Previews: PreviewProvider {
    static var previews: some View {
        chatbot()
    }
}
