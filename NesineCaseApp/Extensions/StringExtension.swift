//
//  StringExtension.swift
//  NesineCaseApp
//
//  Created by Anıl Taha Uyar on 9.04.2022.
//

import Foundation

extension String {
    
    func toBaseUrlQuery() -> String{
        return self.replacingOccurrences(of: " ", with: "+")
    }
    
}
