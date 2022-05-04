//
//  ProfileView.swift
//  simple
//
//

import SwiftUI

struct ProfileView: View {
    
    // - UserDefaults
    private let userDefaults = UserDefaults.standard
    
    // - UserDefaults for field "userYearOfBirth" from RegistrationView
    private let dateOfBirth = UserDefaults.standard.object(forKey: "userYearOfBirth") as? Date
    private let dateOfBirthFormatter = DateFormatter()
    
    @State private var isPresentedLogOut = false
    @State private var isPresentedEditProfile = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            VStack(alignment: .center) {
                Image("userPhotoDeafault")
                    .resizable()
                    .frame(width: 120, height: 120, alignment: .center)
                    .clipShape(Circle())
                    .overlay(Circle().stroke(Color.blue, lineWidth: 3.0))
                
                VStack(alignment: .center, spacing: 3.0) {
                    HStack(alignment: .center, spacing: 6) {
                        headerUserTextField(title: "\(userDefaults.string(forKey: "userName") ?? "Unknown")", font: .title2, fontWeight: .medium)
                        headerUserTextField(title: "\(userDefaults.string(forKey: "userSurname") ?? "Unknown")", font: .title2, fontWeight: .medium)
                    }
                    headerUserTextField(title: "Location: \(userDefaults.string(forKey: "userCountry") ?? "Unknown"), \(userDefaults.string(forKey: "userCity") ?? "Unknown")", font: .body, fontWeight: .regular)
                }
            }
            
            Form {
                Section(header: Text("Basic Information")) {
                    userTextField(title: "Age", registrationData: "\(userDefaults.integer(forKey: "userAge"))")
                    userTextField(title: "City", registrationData: "\(userDefaults.string(forKey: "userCity") ?? "Unknown")")
                    userTextField(title: "Country", registrationData: "\(userDefaults.string(forKey: "userCountry") ?? "Unknown")")
                    userTextField(title: "Year of birth", registrationData: "\(dateYearOfBirth())")
                    userTextField(title: "Email", registrationData: readSecurityDataInKeyChain(keyForSearch: "userEmail"))
                    userTextField(title: "Pasword", registrationData: readSecurityDataInKeyChain(keyForSearch: "userPassword"))

                }
            }
            
            HStack {
                Button {
                    isPresentedEditProfile.toggle()
                } label: {
                    MainButtonWithRoundedRectangle(imageName: nil, textButton: "Edit Profile!")
                }
                .padding()
                .foregroundColor(.black)
                
                Spacer()
                
                HStack {
                    Button {
                        isPresentedLogOut.toggle()
                        UserDefaults.standard.firstRegisterTapOnSave = false
                    } label: {
                        MainButtonWithRoundedRectangle(imageName: nil, textButton: "LogOut!")
                    }
                    .padding()
                    .foregroundColor(.black)
                }
            }
            .background(.clear)
            .frame(height: 50, alignment: .bottom)
        }
        .fullScreenCover(isPresented: $isPresentedLogOut, content: WelcomeScreen.init)
        .fullScreenCover(isPresented: $isPresentedEditProfile, content: RegistrationView.init)
    }
    
    private func userTextField(title: String ,registrationData: String) -> some View {
        HStack {
            Text("\(title):")
            Spacer(minLength: 20)
            Text(registrationData)
                .lineLimit(1)
        }
    }
    
    private func headerUserTextField(title: String, font: Font, fontWeight: Font.Weight) -> some View {
        Text(title)
            .font(font)
            .fontWeight(fontWeight)
            .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            .lineLimit(1)
    }
    
    private func dateYearOfBirth() -> String {
        dateOfBirthFormatter.dateFormat = "dd/MM/yyyy"
        return dateOfBirthFormatter.string(from: dateOfBirth ?? Date.now)
    }
    
    private func readSecurityDataInKeyChain(keyForSearch: String) -> String {
        var resultSearch = ""
        if let receivedData = KeyChain.load(key: keyForSearch) {
            let result = receivedData.to(type: String.self)
            resultSearch = result
            print("✅Result of saving in KeyChain: ", resultSearch)
        }
        return resultSearch
    }
}

struct PrifileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
