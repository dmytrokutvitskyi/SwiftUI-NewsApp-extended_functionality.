//
//  CategoryOfUrlAddressModel.swift
//  simple
//
//

import Foundation

enum CategoryOfUrlAddress {
    case ukraine
    case sport
    
    var urlCategory: String {
        switch self {
        case .ukraine: return "http_Ukraine"
        case .sport: return "http_Sport"
        }
    }
}
