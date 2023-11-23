import SwiftUI

struct signup: View {
    @State private var isUserAgreePolicy = false
    @State private var fullName = ""
    @State private var email = ""
    @State private var infant = ""
    @State private var profilepic = ""
    @State private var cribID = ""
    @State private var ConfirmE = ""
    @State private var password = ""
    @State private var ConfirmP = ""
    @EnvironmentObject var viewModel: AuthViewModel
    
    var body: some View {
        NavigationView{
            ScrollView{
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
                        .autocapitalization(.words)
                        
                        
                        InputView(text: $email, title: "Enter your email", placeholder: "email")
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                        
                        
                        InputView(text: $infant, title: "Enter your Baby's name", placeholder: "Infant")
                        .autocapitalization(.none)
                        }
                    
                        InputView(text: $cribID, title: "Enter the KaroukaID", placeholder: "ID")
                        .autocapitalization(.none)
                    
                   
                        
                    InputView(text: $password, title: "Enter your Password", placeholder: "Password", isSecuredField: true)
                    .autocapitalization(.none)
                    
                        
                    ZStack(alignment: .trailing) {
                        
                        VStack {InputView(text: $ConfirmP, title: "Confirm your Password", placeholder: "Password", isSecuredField: true)
                        .autocapitalization(.none)
                        }
                        if !password.isEmpty && !ConfirmP.isEmpty {
                            if password == ConfirmP {
                                Image(systemName: "checkmark.circle.fill")
                                    .imageScale(.large)
                                    .foregroundColor(Color(.green))
                            } else {
                                Image(systemName: "xmark.circle.fill")
                                    .imageScale(.large)
                                    .foregroundColor(Color(.red))
                            }
                        }
                    }
                        
                        Toggle(isOn: $isUserAgreePolicy) {
                            Text("By signing up, I agree to the Terms and Conditions and Privacy Policy")
                                .foregroundColor(.pink)
                                .lineLimit(3)
                        
                    
                        
                    }
            
                    Button {
                       
                        Task{
                            try await viewModel.createUser(withEmail: email, password: password, fullname: fullName, infant: infant, cribID: cribID, profilepic: "person")
                        
                            
                        }
                            
                    }
                label: {
                    Text("Signup")
                        .font(.headline)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width - 30, height: 50)
                        
                }.background(Color(red: 190/255, green: 150/255, blue: 255/255))
                        .disabled(!formIsValid)
                        .opacity(formIsValid ? 1.0 : 0.5)
                        .cornerRadius(15)
                }
                .padding(.horizontal, 24)
                .padding(.vertical, 16)
            }.ignoresSafeArea()
                
        
    }.navigationBarBackButtonHidden(false)
}
}

extension signup: AuthenticationFormProtocol {
    var formIsValid: Bool {
        return email.contains("@")
        && ConfirmP == password
        && password.count > 5
        && isUserAgreePolicy
    }
    
    
}

struct SignUp_Previews: PreviewProvider {
    static var previews: some View {
        signup()
    }
}
