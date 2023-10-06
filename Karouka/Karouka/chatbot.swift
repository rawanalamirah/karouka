import SwiftUI

struct chatbot: View {
    @State private var userInput = ""
    @State private var chatMessages: [String] = []
    
    var body: some View {
        VStack {
            List(chatMessages, id: \.self) { message in
                Text(message)
            }
            
            TextField("Type your message", text: $userInput, onCommit: sendMessage)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    
    func sendMessage() {
        // Send the user's message to the chatbot API
        // Handle API response and update chatMessages with chatbots reply
        // Clear the userInput field
    }
}

struct chatbot_Previews: PreviewProvider {
    static var previews: some View {
        chatbot()
    }
}
