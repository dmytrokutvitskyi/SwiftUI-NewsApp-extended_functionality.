//
//  LoginView.swift
//  simple
//
//

import SwiftUI

enum TextFieldSignUp {
    case email, password
}

struct SignUpView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @FocusState private var focusedTextField: TextFieldSignUp?
    
    @State private var isPresentedMainView = false
    @State private var isSignUpError = false
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    TextField("Email", text: $email)
                        .textContentType(.emailAddress)
                        .disableAutocorrection(true)
                        .submitLabel(.next)
                        .focused($focusedTextField, equals: .email)
                    
                    SecureTextField(text: $password)
                        .textContentType(.password)
                        .disableAutocorrection(true)
                        .submitLabel(.done)
                        .focused($focusedTextField, equals: .password)
                }
                .background(.red)
                .frame(width: UIScreen.main.bounds.width, height: 200, alignment: .center)
                
                .onSubmit {
                    switch focusedTextField {
                    case .email:
                        focusedTextField = .password
                    default:
                        focusedTextField = nil
                    }
                }
                
                .overlay {
                    Button {
                        if password == readKeyChainForСheckPassword(keyForSearch: "userPassword")
                            && email == readKeyChainForСheckPassword(keyForSearch: "userEmail") {
                            isPresentedMainView.toggle()
                            print("Sign UP -> Done✅")
                        } else {
                            isSignUpError.toggle()
                            print("Sign UP -> Fail❌")
                        }
                    } label: {
                        MainButtonWithRoundedRectangle(imageName: nil, textButton: "SignUp")
                    }
                    .padding()
                    .offset(y: 70)
                }
            }
            .navigationBarTitle("SignUp", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cancel")
            })
            
            .fullScreenCover(isPresented: $isPresentedMainView, content: MainTabBarView.init)
            
            .alert(isPresented: $isSignUpError) {
                Alert(title: Text("Wrong password/Email..."),
                      message: Text("Check your [Password] and [Email] and try again"),
                      dismissButton: .cancel()
                )}
        }
    }
    
    private func readKeyChainForСheckPassword(keyForSearch: String) -> String {
        var resultSearchInKeyChain = ""
        if let receivedData = KeyChain.load(key: keyForSearch) {
            let result = receivedData.to(type: String.self)
            resultSearchInKeyChain = result
        }
        return resultSearchInKeyChain
    }
}

struct Login_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
