//
//  PreviewInteractorTests.swift
//  NesineCaseApp
//
//  Created by Anıl Taha Uyar on 13.04.2022.
//  Copyright (c) 2022 ___ORGANIZATIONNAME___. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

@testable import NesineCaseApp
import XCTest

class PreviewInteractorTests: XCTestCase
{
    
    var sut: PreviewInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupPreviewInteractor()
    }
    // MARK: Test setup
    
    func setupPreviewInteractor() {
        sut = PreviewInteractor()
    }
    
    // MARK: Test doubles
    
    class PreviewPresentationLogicSpy: PreviewPresentationLogic {
        var presentImageCalled = false
        
        func presentImage(image: UIImage) {
            presentImageCalled = true
        }
    }
    // MARK: Tests
    func testpresentImage() {
        let spy = PreviewPresentationLogicSpy()
        sut.presenter = spy
        sut.image = UIImage(named: "Default")!
        sut.getImage()
        
        XCTAssertTrue(spy.presentImageCalled)
        
    }
}
