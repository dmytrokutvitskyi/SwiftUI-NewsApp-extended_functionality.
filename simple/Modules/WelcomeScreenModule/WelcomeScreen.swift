//
//  LoginView .swift
//  simple
//
//

import SwiftUI

struct WelcomeScreen: View {
    
    @AppStorage("firstShowWelcomeScreen")
    var firstShowWelcomeScreen: Bool = false
    
    // - Navigation
    @State private var isPresentedRegistrationView = false
    @State private var isPresentedSignUpView = false
    
    // - colorScheme
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            Text(LocalizedStringKey("sessionIsNotActive"))
                .font(.title2)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            
            Divider()
            
            VStack(spacing: 10) {
                Button {
                    isPresentedRegistrationView.toggle()
                } label: {
                    mainButtonOnLogOut(title: LocalizedStringKey("registration"),
                                       image: "swift")
                }
                
                Button {
                    isPresentedSignUpView.toggle()
                } label: {
                    mainButtonOnLogOut(title: LocalizedStringKey("signUp"),
                                       image: "checkmark.seal")
                }
            }
        }
        .fullScreenCover(isPresented: $isPresentedRegistrationView, content: RegistrationView.init)
        .fullScreenCover(isPresented: $isPresentedSignUpView, content: SignUpView.init)
        
        .onAppear(perform: {
            UserDefaults.standard.firstShowWelcomeScreen = true
        })
    }
    
    private func mainButtonOnLogOut(title: LocalizedStringKey, image: String?) -> some View {
        HStack {
            Text(title)
                .font(.system(size: 20))
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            
            Image(systemName: image ?? "")
                .resizable()
                .frame(width: 25, height: 25)
        }
    }
}

struct LogOutView__Previews: PreviewProvider {
    static var previews: some View {
        WelcomeScreen()
    }
}
