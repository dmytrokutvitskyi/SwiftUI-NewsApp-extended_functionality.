//
//  MainButtonWithRoundedRectangle.swift
//  simple
//
//

import SwiftUI

struct MainButtonWithRoundedRectangle: View {
    
    @Environment(\.colorScheme) var colorScheme
    
    var imageName: String?
    var textButton: String
    
    init(imageName: String?, textButton: String) {
        self.imageName = imageName
        self.textButton = textButton
    }
    
    var body: some View {
        HStack {
            Image(systemName:  imageName ?? "")
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
            Text(textButton)
                .fontWeight(.bold)
                .font(.callout)
                .foregroundColor(colorScheme == .dark ? Color.white : Color.black)
                .padding(.all, 5)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(colorScheme == .dark ? Color.white : Color.black, lineWidth: 1)
                )
        }
    }
}

struct MainButtonWithRoundEdges__Previews: PreviewProvider {
    static var previews: some View {
        MainButtonWithRoundedRectangle(imageName: "lol", textButton: "jopa")
    }
}
