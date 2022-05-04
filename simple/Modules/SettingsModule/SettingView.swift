//
//  SettingView.swift
//  simple
//
//

import SwiftUI

struct SettingView: View {
    
    @StateObject private var settingViewModel = SettingViewModel()
    @State private var indexCategory: Int = 0
    @State private var newsLanguage: Int = 0
    
    var body: some View {
        NavigationView {
            Form {
                HStack {
                    Text("Category:")
                    Spacer()
                    VStack {
                        Picker("Select category", selection: $indexCategory) {
                            ForEach(settingViewModel.category.indices, id: \.self) { index in                                Text(settingViewModel.category[index])
                            }
                        }
                        .pickerStyle(.menu)
                        .onChange(of: indexCategory) { newValue in
                            settingViewModel.indexOfSelectedCategory = indexCategory
#warning("If DEBUG - PRINT REMOVE")
                            print("Category:\(newValue)")
                        }
                    }
                }
                
                HStack {
                    Text("News language:")
                    Spacer()
                    VStack {
                        Picker("News language", selection: $newsLanguage) {
                            ForEach(settingViewModel.language.indices, id: \.self) { index in                                Text(settingViewModel.language[index])
                            }
                        }
                        .pickerStyle(.menu)
                        .onChange(of: newsLanguage) { newValue in
#warning("If DEBUG - PRINT REMOVE")
                            print("News language:\(newValue)")
                        }
                    }
                }
                
                .navigationTitle("Settings:")
            }
        }
        
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingView()
    }
}
