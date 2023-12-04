import SwiftUI
import Combine

struct chatbot: View {
    @ObservedObject var chatModel = ChatModel()
    var body: some View {
        VStack {
            ScrollView {
                LazyVStack {
                    ForEach(chatModel.messages.filter({$0.role != .system}), id: \.id) { message in
                        messageView(message: message)
                        
                    }
                }
                
            }
            HStack {
                TextField("Enter a message", text: $chatModel.currentInput) {
                }
                .padding()
                .background(.gray.opacity(0.1))
                .cornerRadius(12)
                Button{
                    chatModel.sendMessage()
                } label: {
                    Text("Send")
                        .foregroundColor(.white)
                        .frame(width: 80, height: 45, alignment: .center)
                        .background(Color(red: 180/255, green: 200/255, blue: 255/255))
                        .cornerRadius(12)
                }.background(Color.clear)
            }
        }
        .padding()
    }
    
    func messageView(message: Message) -> some View {
        HStack {
            if message.role == .user {Spacer()}
            Text(message.content)
                .foregroundColor(message.role == .user ? .white : .black)
                .padding()
                .background(message.role == .user ? Color(red: 180/255, green: 200/255, blue: 255/255) : .gray.opacity (0.1))
                .cornerRadius(16)
            if message.role == .assistant {Spacer()}
        }
    }
}
    
    
struct chatbot_Previews: PreviewProvider {
    static var previews: some View {
        chatbot()
    }
}



