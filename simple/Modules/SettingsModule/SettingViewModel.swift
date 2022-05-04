//
//  SettingViewModel.swift
//  simple
//
//

import Foundation

class SettingViewModel: ObservableObject {
    
    let category: [String] = ["Ukraine", "Sport"]
    let language: [String] = ["UK", "EN"]
    
    @Published var indexOfSelectedCategory: Int = 0 {
        didSet {
#warning("If DEBUG - PRINT REMOVE")
            print("didSet-*-indexOfSelectedCategory: \(indexOfSelectedCategory)")
            if indexOfSelectedCategory == 0 {
                selectedСategory = CategoryOfUrlAddress.ukraine.urlCategory
            } else if indexOfSelectedCategory == 1 {
                selectedСategory = CategoryOfUrlAddress.sport.urlCategory
            }
        }
    }
    
    @Published var selectedСategory: String = "" {
        didSet {
#warning("If DEBUG - PRINT REMOVE")
            print("didSet-*-selectedСategory: \(selectedСategory)")
        }
    }
}
