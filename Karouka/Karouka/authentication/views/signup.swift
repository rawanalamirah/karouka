import SwiftUI

struct signup: View {
    @State private var isUserAgreePolicy = false
    @State private var fullName = ""
    @State private var email = ""
    @State private var ConfirmE = ""
    @State private var password = ""
    @State private var ConfirmP = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView{
            ScrollView {
                VStack{
                    Image("cribtoy")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 350, height: 200)
                    .padding(.top)
                    
                    Spacer()
                    
                    HStack {
                        Text("Sign up")
                            .font(.custom("Avenir-Medium", size: 30).bold())
                            .padding(.bottom)
                            .padding(.top, 90)
                        Spacer()

                    }
                    
                    Text("Create an account:")
                            .font(.custom("Avenir-Medium", size: 20))
                            .padding(.bottom, 20)
                        
                    Section {
                        InputView(text: $fullName, title: "Enter your full name:", placeholder: "full Name")
                        .disableAutocorrection(true)
                        
                        
                        InputView(text: $email, title: "Enter your email", placeholder: "email")
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        
                        
                    InputView(text: $ConfirmE, title: "Confirm your email", placeholder: "email")
                    .keyboardType(.emailAddress)
                    .autocapitalization(.none)
                    }
                    
                        
                    InputView(text: $password, title: "Enter your Password", placeholder: "Password", isSecuredField: true)
                    .autocapitalization(.none)
                        
                    InputView(text: $ConfirmP, title: "Confirm your Password", placeholder: "Password", isSecuredField: true)
                    .autocapitalization(.none)
                        
                        Toggle(isOn: $isUserAgreePolicy) {
                            Text("By signing up, I agree to the Terms and Conditions and Privacy Policy")
                                .foregroundColor(.pink)
                                .lineLimit(3)
                        
                    
                        
                    }
            
                    Button {
                       
                        Task{
                            try await viewModel.createUser(withEmail: email, password: password, fullname: fullName)
                        }
                            
                    }
                label: {
                    Text("Signup")
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
struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        signup()
    }
}
