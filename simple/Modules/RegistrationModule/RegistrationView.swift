//
//  RegistrationView.swift
//  simple
//
//

import SwiftUI

enum TextFieldForm {
    case userName, userSurname, userCity, userCountry, userEmail, userPassword
}

struct RegistrationView: View {
    
    // - UserDefaults
    private let userDefaults = UserDefaults.standard
    
    // - Navigation
    @State private var isShowMainView = false
    @Environment(\.presentationMode) var presentationMode
    
    // - ImagePickerView
    @State private var image: Image? = Image("userPhotoDeafault")
    @State private var shouldPresentImagePicker = false
    @State private var shouldPresentActionScheet = false
    @State private var shouldPresentCamera = false
    
    // - SavaUserDataTextField
    @State private var userName: String = ""
    @State private var userSurname: String = ""
    @State private var userAge: Int = 0
    @State private var userCity: String = ""
    @State private var userCountry: String = ""
    @State private var userYearOfBirth = Date()
    @State private var userEmail: String = ""
    @State private var userPassword: String = ""
    
    // - KeyBoard select
    @FocusState private var focusedTextField: TextFieldForm?
    
    // - ShowValidationError
    @State private var isShowValidationError = false
    
    var body: some View {
        NavigationView {
            VStack {
                image!
                    .resizable()
                    .frame(width: 120, height: 120, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.blue, lineWidth: 3.0))
                    .onTapGesture {
                        self.shouldPresentActionScheet = true
                    }
                    .sheet(isPresented: $shouldPresentImagePicker) {
                        ImagePickerView(sourceType: self.shouldPresentCamera ? .camera : .photoLibrary,
                                        image: self.$image, isPresented: self.$shouldPresentImagePicker)
                    }
                    .actionSheet(isPresented: $shouldPresentActionScheet) { () -> ActionSheet in
                        ActionSheet(title: Text("Choose mode"),
                                    message: Text("Please choose your preferred mode to set your profile image"),
                                    buttons: [ActionSheet.Button.default(Text("Camera"), action: {
                            
                            self.shouldPresentImagePicker = true
                            self.shouldPresentCamera = true
                        }), ActionSheet.Button.default(Text("Photo Library"), action: {
                            self.shouldPresentImagePicker = true
                            self.shouldPresentCamera = false
                        }),ActionSheet.Button.cancel()])
                    }
                
                Form {
                    TextField("Name", text: $userName)
                        .disableAutocorrection(true)
                        .submitLabel(.next)
                        .focused($focusedTextField, equals: .userName)
                    
                    TextField("Surname", text: $userSurname)
                        .textContentType(.familyName)
                        .disableAutocorrection(true)
                        .submitLabel(.next)
                        .focused($focusedTextField, equals: .userSurname)
                    
                    HStack {
                        Text("Age:")
                        Spacer()
                        Picker("age", selection: $userAge) {
                            ForEach(0...100, id: \.self) { index in
                                Text("\(index)")
                            }
                        }
                        .pickerStyle(.menu)
                    }
                    
                    TextField("Country", text: $userCountry)
                        .disableAutocorrection(true)
                        .submitLabel(.next)
                        .focused($focusedTextField, equals: .userCountry)
                    
                    TextField("City", text: $userCity)
                        .disableAutocorrection(true)
                        .submitLabel(.next)
                        .focused($focusedTextField, equals: .userCity)
                    
                    DatePicker("Year Of Birth:", selection: $userYearOfBirth,in: ...Date(), displayedComponents:.date)
                    
                    TextField("Email", text: $userEmail)
                        .textContentType(.emailAddress)
                        .disableAutocorrection(true)
                        .submitLabel(.next)
                        .focused($focusedTextField, equals: .userEmail)
                    
                    SecureTextField(text: $userPassword)
                        .textContentType(.password)
                        .disableAutocorrection(true)
                        .submitLabel(.done)
                        .focused($focusedTextField, equals: .userPassword)
                }
                
                .onSubmit {
                    switch focusedTextField {
                    case .userName:
                        focusedTextField = .userSurname
                    case .userSurname:
                        focusedTextField = .userCountry
                    case .userCountry:
                        focusedTextField = .userCity
                    case .userCity:
                        focusedTextField = .userEmail
                    case .userEmail:
                        focusedTextField = .userPassword
                    default:
                        focusedTextField = nil
                    }
                }
                
                .overlay {
                    Button(action: {
                        saveUserDataInUserDefaults()
                        isShowMainView.toggle()
                    }) {
                        MainButtonWithRoundedRectangle(imageName: "highlighter", textButton: "Save!")
                    }
                    .padding()
                    .foregroundColor(.black)
                    .offset(y: 150)
                }
            }
            .navigationBarTitle("", displayMode: .inline)
            .navigationBarItems(leading: Button(action: {
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Cancel")
            })
        }
        
        .fullScreenCover(isPresented: $isShowMainView, content: MainTabBarView.init)
        .alert(isPresented: $isShowValidationError) {
            Alert(title: Text("Validation Error!"),
                  message: Text("Сheck if the fields are filled and try again!"),
                  primaryButton:
                    .destructive(Text("Try again")) {
                        saveUserDataInUserDefaults()
                    }, secondaryButton: .cancel())
        }
    }
    
    private func saveUserDataInUserDefaults() {
        if userName.count >= 3 && userSurname.count >= 3 && userCity.count >= 3 && userCountry.count >= 3 && userEmail.count >= 6 && userPassword.count >= 3 {
            UserDefaults.standard.firstRegisterTapOnSave = true
            
            userDefaults.set(userName, forKey: "userName")
            userDefaults.set(userSurname, forKey: "userSurname")
            userDefaults.set(userAge, forKey: "userAge")
            userDefaults.set(userCity, forKey: "userCity")
            userDefaults.set(userCountry, forKey: "userCountry")
            userDefaults.set(userYearOfBirth, forKey: "userYearOfBirth")
            
            saveDataInKeyChain(secureData: userEmail, key: "userEmail")
            saveDataInKeyChain(secureData: userPassword, key: "userPassword")
        } else {
            isShowValidationError.toggle()
        }
    }
    
    private func saveDataInKeyChain(secureData: String, key: String) {
        let secureData = Data(from: secureData)
        let statusSave = KeyChain.save(key: key, data: secureData)
        print("⚠️StatusCode Save in KeyChain:", statusSave)
    }
}

struct RegisterView_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationView()
    }
}
