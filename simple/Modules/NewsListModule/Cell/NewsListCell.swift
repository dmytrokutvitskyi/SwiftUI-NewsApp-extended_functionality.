//
//  NewsListCell.swift
//  simple
//
//

import SwiftUI

struct NewsListCell: View {
    
    var newsList: News
    
    var body: some View {
        VStack(alignment: .center, spacing: 15) {
            UrlCacheImageView(urlString: newsList.urlToImage)
            
            Text(newsList.title ?? "News headline missing...")
                .font(.system(.body, design: .rounded))
                .multilineTextAlignment(.leading)
                .lineLimit(3)
                .frame(maxWidth: .infinity)
        }
        .padding(.vertical, 15)
        
    }
}

struct NewsListCell_Previews: PreviewProvider {
    static var previews: some View {
        NewsListCell(newsList: News.init(title: "default", url: "", urlToImage: "default", author: "default", description: "default", content: "default"))
    }
}
