//
//  SearchPresenterTests.swift
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

class SearchPresenterTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: SearchPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp() {
        super.setUp()
        setupSearchPresenter()
    }
    // MARK: Test setup
    
    func setupSearchPresenter() {
        sut = SearchPresenter()
    }
    
    // MARK: Test doubles
    
    class SearchDisplayLogicSpy: SearchDisplayLogic {
        var displaySearchListCalled = false
        
        func displaySearchList(imageListModel: SearchModel.ImageModel) {
            displaySearchListCalled = true
        }
    }
    
    // MARK: Tests
    func testDisplaySearchList() {
        let spy = SearchDisplayLogicSpy()
        sut.viewController = spy
        
        let imageListModel = SearchModel.ImageModel.init(smallSizeSection: [UIImage()],
                                                         largeSizeSection: [UIImage()],
                                                         xLargeSizeSection: [UIImage()],
                                                         xxLargeSizeSection: [UIImage()])
        
        sut.presentSoftware(with: imageListModel)
        XCTAssertTrue(spy.displaySearchListCalled)
    }
    
    
}