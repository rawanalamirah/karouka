import SwiftUI

struct signup: View {
    @State private var isUserAgreePolicy = false

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
                    
                    Text("Sign up")
                        .font(.custom("Avenir-Medium", size: 30).bold())
                        .padding(.bottom)
                        .padding(.top, 90)
                        .padding(.trailing, 240)
                    
                    Section{
                        Text("Create an account:")
                            .font(.custom("Avenir-Medium", size: 20))
                            .padding(.bottom, 20)
                        
                        Text("Enter your first name:")
                            .padding(.trailing, 187)
                        TextField("First name", text: .constant(""))
                            .padding(.bottom, 32)
                        
                        Text("Enter your Last name:")
                            .padding(.trailing, 184)
                        TextField("Last name", text: .constant(""))
                            .padding(.bottom, 32)
                        
                        Text("Enter your e-mail:")
                            .padding(.trailing, 214)
                        TextField("Enter your e-mail", text: .constant(""))
                            .keyboardType(.emailAddress)
                            .padding(.bottom, 32)
                        
                        Text("Confirm e-mail:")
                            .padding(.trailing, 232)
                        TextField("Confirm email", text: .constant(""))
                            .keyboardType(.emailAddress)
                            .padding(.bottom, 32)
                    }
                    
                    Section {
                        Text("Create a username:")
                            .padding(.trailing, 200)
                        TextField("Create a username", text: .constant(""))
                            .padding(.bottom, 32)
                        
                        Text("Create a password:")
                            .padding(.trailing, 203)
                        SecureField("Create your password", text: .constant(""))
                            .padding(.bottom, 32)
                        
                        Text("Repeat password:")
                            .padding(.trailing, 214)
                        SecureField("Repeat password", text: .constant(""))
                            .padding(.bottom, 32)
                        
                        Toggle(isOn: $isUserAgreePolicy) {
                            Text("By signing up, I agree to the Terms and Conditions and Privacy Policy")
                                .foregroundColor(.pink)
                                .lineLimit(3)
                        
                    }
                        
                    }
            
                    NavigationLink(destination: homepage()) {
                        Text("Sign Up")
                            .font(.headline)
                            .foregroundColor(.white)
                            .frame(width: 350, height: 50)
                            .background(.purple)
                            .cornerRadius(15)
                    }
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
