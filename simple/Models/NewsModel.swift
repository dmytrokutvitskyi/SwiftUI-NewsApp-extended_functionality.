//
//  NewsModel.swift
//  simple
//
//

import Foundation

struct NewsEnvelope: Codable {
    let status: String?
    let totalResults: Int
    let articles: [News]
}

struct News: Codable, Identifiable {
    
    var id = UUID()
    let title: String?
    let url: String?
    let urlToImage: String?
    let author: String?
    let description: String?
    let content: String?
    
    private enum CodingKeys: String, CodingKey {
        case title = "title"
        case url = "url"
        case urlToImage = "urlToImage"
        case author = "author"
        case description = "description"
        case content = "content"
    }
}
