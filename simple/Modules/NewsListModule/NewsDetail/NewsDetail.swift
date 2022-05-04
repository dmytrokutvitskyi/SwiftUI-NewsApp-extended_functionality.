//
//  NewsDetail.swift
//  simple
//
//

import SwiftUI

struct NewsDetail: View {
    
    var newsDetails: News
    
    @Environment(\.colorScheme) var colorScheme
    @State private var showWebView = false
    
    var body: some View {
        ScrollView {
            VStack(alignment: .center, spacing: 5) {
                
                Text(newsDetails.title ?? "News has no title")
                    .fontWeight(.medium)
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .padding()
                
                Divider()
                
                Spacer(minLength: 5)
                UrlCacheImageView(urlString: newsDetails.urlToImage)
                
                Spacer(minLength: 5)
                Text(newsDetails.description ?? "News has no description")
                    .font(.body)
                    .fontWeight(.regular)
                    .padding()
                
                Divider()
                Spacer(minLength: 5)
                
                HStack(alignment: .center) {
                    Text(newsDetails.author ?? "News has no author")
                        .fontWeight(.regular)
                        .font(.body)
                        .multilineTextAlignment(.leading)
                        .padding()
                    
                    Spacer()
                    Divider()
                    Spacer()
                    
                    Button(action: {
                        showWebView.toggle()
                    }) {
                        MainButtonWithRoundedRectangle(imageName: nil, textButton: "Open Full News")
                    }
                    .foregroundColor(.black)
                }
                .frame(width: UIScreen.main.bounds.width - (15 * 2), alignment: .center)
            }
        }
        
        .sheet(isPresented: $showWebView) {
            WebView(url: URL(string: newsDetails.url ?? "")!)
        }
        
    }
}

struct NewsListDetail_Previews: PreviewProvider {
    static var previews: some View {
        NewsDetail(newsDetails: News.init(title: "default", url: "", urlToImage: "default", author: "default", description: "default", content: "default"))
    }
}
