//
//  ContentView.swift
//  simple
//
//

import SwiftUI

struct NewsListView: View {
    
    @StateObject private var newsListViewModel = NewsLlistViewModel()
    
    var body: some View {
        NavigationView {
            List (newsListViewModel.newsList, id: \.id) { data in
                ZStack(alignment: .leading) {
                    NavigationLink(destination: NewsDetail(newsDetails: data)) {
                        EmptyView()
                    }
                    .opacity(0)
                    NewsListCell(newsList: data)
                }
            }
            .listStyle(.plain)
            .frame(alignment: .center)
            .navigationBarTitle(Text("News List:"))
        }
        
        .task {
            await newsListViewModel.fetchAllNews()
        }
        
        .alert(isPresented: $newsListViewModel.isRequestError) {
            Alert(title: Text("The request failed"),
                  message: Text(newsListViewModel.textError),
                  primaryButton: .destructive(Text("Try again")) {
                
                Task {
                    await newsListViewModel.fetchAllNews()
                }
            }, secondaryButton: .cancel())
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewsListView()
    }
}
