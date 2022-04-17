//
//  SearchPresenter.swift
//  NesineCaseApp
//
//  Created by Anıl Taha Uyar on 9.04.2022.
//  Copyright (c) 2022 AntaApp. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit


protocol SearchPresentationLogic: AnyObject {
    func presentEmptySoftware()
}

final class SearchPresenter: SearchPresentationLogic {
    weak var viewController: SearchDisplayLogic?
    
    func presentEmptySoftware() {
        viewController?.displayEmptySearchList()
    }
    
}
