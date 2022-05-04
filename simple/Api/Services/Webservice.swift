//
//  Webservice .swift
//  simple
//
//

import Foundation

class Webservice {
    
    static let baseUrlString = "https://newsapi.org/v2/"
    static let newsCategory = "top-headlines?country="
    static let newsLanguage = "us"
    
    static func getNewsList() async throws -> [News] {
        let urlString = "\(baseUrlString)\(newsCategory)\(newsLanguage)&apiKey=\(APIKey.key)"
        
        guard let url = URL(string: urlString) else {
            throw FetcherError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try? JSONDecoder().decode(NewsEnvelope.self, from: data)
        
        guard let response = response else {
            throw FetcherError.missingData
        }
        print("✅ Response: statusCode: \(response.status ?? "_"), Response: \(response.totalResults), articles: \(response.articles) 🟢")
        return response.articles
    }
}
