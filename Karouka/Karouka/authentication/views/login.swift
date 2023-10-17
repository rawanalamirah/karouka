import SwiftUI
import Firebase

struct login: View {
    @State private var email = ""
    @State private var password = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack{
                    //Image
                    Image("cribtoy")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350, height: 200)
                    .padding(.top)
                    
                    //Form Title
                    HStack{
                    Text("Log in")
                        .font(.custom("Avenir-Medium", size: 30).bold())
                        .padding(.bottom, 20)
                        .padding(.top, 100)
                    Spacer()
                    }
                    
                    
                    Text("Enter your details to continue")
                            .font(.custom("Avenir-Medium", size: 20))
                    Spacer()
                    
                    //Form Fields
                    VStack (alignment: .leading) {

                    Text("Email Address")
                        .foregroundColor(Color(.darkGray))
                        .fontWeight(.semibold)
                    TextField("Enter your e-mail", text: .constant(""))
                        .keyboardType(.emailAddress)
                        
                        Divider()
                    Text("Password")
                            .foregroundColor(Color(.darkGray))
                            .fontWeight(.semibold)
                            .padding(.top, 32)
                    SecureField("Enter your password", text: .constant(""))

                        
                        Divider()
                     
                    }
                    
                    Button {
                        Task{
                            try await viewModel.signIn(withEmail: email, password: password)
                        }
                    }
                label: {
                    Text("Log In")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                        
                }.background(.purple)
                        .cornerRadius(15)
                    
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
