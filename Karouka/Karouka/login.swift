import SwiftUI

struct login: View {
    var body: some View {
        NavigationView{
            ScrollView {
                VStack{
                    Image("cribtoy")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350, height: 200)
                    .padding(.top)
                    
                    
                    Text("Log in")
                        .font(.custom("Avenir-Medium", size: 30).bold())
                        .padding(.bottom, 30)
                        .padding(.top, 130)
                        .padding(.trailing, 260)
                    
                        Section(header: Text("Enter your details to continue").font(.custom("Avenir-Medium", size: 20))) {
                            TextField("Enter your e-mail", text: .constant(""))
                                .keyboardType(.emailAddress)
                                .padding(.bottom, 32)
                            
                            SecureField("Enter your password", text: .constant(""))
                                .padding(.bottom, 32)
                        }.listStyle(GroupedListStyle())
                    
                    
                    NavigationLink(destination: homepage()) {
                        Text("Log In")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 350, height: 50)
                            .background(.purple)
                            .cornerRadius(15)
                    }.padding(.top, 30)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)

            }.ignoresSafeArea()
        }
    }

}
struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        login()
    }
}
