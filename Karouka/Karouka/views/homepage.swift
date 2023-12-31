import SwiftUI

struct homepage: View {
    @EnvironmentObject var viewModel : AuthViewModel
    @State private var selectedIndex = 0

    var body: some View {
        NavigationView {
            TabView(selection: $selectedIndex) {
                
                home()
                    .tag(0)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }


                chatbot()
                    .tag(1)
                    .tabItem {
                        Image(systemName: "message.fill")
                        Text("Chat")
                    }


                history()
                    .tag(2)
                    .tabItem {
                        Image(systemName: "clock.fill")
                        Text("History")
                    }
                    

                profile()
                    .tag(3)
                    .tabItem {
                        Image(systemName: "person.fill")
                        Text("Profile")
                    }

            }
            .accentColor(Color(red: 180/255, green: 200/255, blue: 255/255))
            .onAppear {
                UITabBar.appearance().barTintColor = UIColor.white
            }

        }
    }
}

struct HomePage_Previews: PreviewProvider {
    static var previews: some View {
        homepage()
    }
}


