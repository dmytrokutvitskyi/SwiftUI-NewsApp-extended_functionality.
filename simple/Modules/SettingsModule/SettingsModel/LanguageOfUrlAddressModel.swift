//
//  LanguageOfUrlAddressModel.swift
//  simple
//
//

import Foundation

enum LanguageOfUrlAddress {
    case EN
    case UA
    
    var urlCategory: String {
        switch self {
        case .EN: return "en"
        case .UA: return "ua"
        }
    }
}
