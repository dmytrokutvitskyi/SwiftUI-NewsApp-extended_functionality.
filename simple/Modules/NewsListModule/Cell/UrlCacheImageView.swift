//
//  UrlCacheImageView.swift
//  simple
//
//

import SwiftUI

struct UrlCacheImageView: View {
    
    @ObservedObject var urlImageModel: UrlCacheImageModel
    static var defaultImage = UIImage(named: "breakingNews")
    
    init(urlString: String?) {
        urlImageModel = UrlCacheImageModel(urlString: urlString)
    }
    
    var body: some View {
        Image(uiImage: urlImageModel.image ?? UrlCacheImageView.defaultImage!)
            .resizable()
            .scaledToFill()
            .frame(height: 200)
            .frame(maxWidth: UIScreen.main.bounds.width - (15 * 2), alignment: .center)
            .cornerRadius(15)
            .shadow(color: Color.secondary, radius: 10)
    }
}

struct UrlCacheImageView_Previews: PreviewProvider {
    static var previews: some View {
        UrlCacheImageView(urlString: "")
    }
}
