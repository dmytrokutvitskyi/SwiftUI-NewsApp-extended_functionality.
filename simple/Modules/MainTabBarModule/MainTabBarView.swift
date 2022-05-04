//
//  TabBarView.swift
//  simple
//
//

import SwiftUI

struct MainTabBarView: View {
    var body: some View {
        TabView {
            ProfileView()
                . tabItem {
                    Label("Profile", systemImage: "person.circle")
                }
            
            NewsListView()
                .tabItem {
                    Label("News", systemImage: "globe.europe.africa")
                }
            
            SettingView()
                .tabItem {
                    Label("Settings", systemImage: "list.bullet.circle.fill")
                }
        }
    }
}

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabBarView()
    }
}
