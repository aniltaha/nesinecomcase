//
//  PreviewViewControllerTests.swift
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

class PreviewViewControllerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: PreviewViewController!
    var window: UIWindow!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        window = UIWindow()
        setupPreviewViewController()
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())

    }
    
    override func tearDown() {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupPreviewViewController() {
        sut = PreviewViewController()
    }
    
    // MARK: Test doubles
    
    class PreviewBusinessLogicSpy: PreviewBusinessLogic {
        
        var getImageCalled = false
        
        func getImage() {
            getImageCalled = true
        }
    }
    
    // MARK: Tests
 
    func testGetImage() {
        let spy = PreviewBusinessLogicSpy()
        sut.interactor = spy
        sut.viewDidLoad()
        XCTAssertTrue(spy.getImageCalled)
    }
    
}