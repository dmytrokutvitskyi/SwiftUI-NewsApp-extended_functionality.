//
//  NewsListViewModel.swift
//  simple
//
//

import Foundation

class NewsLlistViewModel: ObservableObject {
    
    @Published var newsList:[News] = []
    @Published var isRequestError = false
    @Published var textError: String = ""
    
    func fetchAllNews() async {
        do {
            let newsList = try await Webservice.getNewsList()
            DispatchQueue.main.async {
                self.newsList = newsList
            }
            
        } catch  {
            print("❌ ERROR REQUEST:\(error.localizedDescription) 🔴")
            DispatchQueue.main.async {
                self.textError = "\(error.localizedDescription)"
                self.isRequestError = true
            }
        }
    }
}
