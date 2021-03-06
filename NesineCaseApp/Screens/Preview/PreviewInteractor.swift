//
//  PreviewInteractor.swift
//  NesineCaseApp
//
//  Created by Anıl Taha Uyar on 12.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

protocol PreviewBusinessLogic {
    func getImage()
}

protocol PreviewDataStore {
    var image: UIImage? { get set}
    
}

class PreviewInteractor: PreviewBusinessLogic, PreviewDataStore {
    var presenter: PreviewPresentationLogic?
    var image: UIImage?
    
    // MARK: Protocol
    func getImage() {
        if let image = image {
            self.presenter?.presentImage(image: image)
        }
    }
}
