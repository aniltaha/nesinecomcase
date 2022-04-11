//
//  SearchViewController.swift
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

protocol SearchDisplayLogic: AnyObject
{
    func displaySearchList(listViewModel: [SearchModel.ResultModel])
    func displaySearchList(imageListModel: SearchModel.ImageModel)

}

class SearchViewController: UIViewController, SearchDisplayLogic {
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var listViewModel: [SearchModel.ResultModel] = []
    private var imageListModel: SearchModel.ImageModel?
    let headerId = "headerId"
    let categoryHeaderId = "categoryHeaderId"

    fileprivate let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "SearchCollectionViewCell")
        cv.register(FileCategoryHeaderView.self, forSupplementaryViewOfKind: "categoryHeaderId", withReuseIdentifier: "headerId")
        return cv
    }()
    
    
    private func secondLayoutSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.33),
                                              heightDimension: .absolute(100))
        
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = .init(top: 0, leading: 0, bottom: 15, trailing: 15)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .estimated(500))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets.leading = 15
        
        section.boundarySupplementaryItems = [
            NSCollectionLayoutBoundarySupplementaryItem(layoutSize: .init(widthDimension:
                                                                                .fractionalWidth(1), heightDimension: .estimated(44)), elementKind: "categoryHeaderId", alignment:
                                                                .topLeading)
        ]
        
        return section
    }
    

    
    
    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
   
    // MARK: Setup
    
    private func setup() {
        let viewController = self
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUISearchController()
        setupCollectionView()
    }
    
    // MARK: Setup UI Elements
    
    func setupUISearchController() {
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.autocapitalizationType = .none
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true

    }

    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                            constant: 20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                constant: 20).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -20).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                               constant: -20).isActive = true
        collectionView.collectionViewLayout = createCompositionalLayout()

        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {

        return UICollectionViewCompositionalLayout { (sectionNumber, env) -> NSCollectionLayoutSection? in

         switch sectionNumber {

         case 0: return self.secondLayoutSection()
         case 1: return self.secondLayoutSection()
         default: return self.secondLayoutSection()
         }
       }
    }
    
    // MARK: Protocols
    
    func displaySearchList(listViewModel: [SearchModel.ResultModel]) {
        self.listViewModel = listViewModel
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func displaySearchList(imageListModel: SearchModel.ImageModel) {
        self.imageListModel = imageListModel
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}

extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar: UISearchBar = searchController.searchBar
        let searchText: String = searchBar.text ?? ""
        if searchText.count <= 2 {
            DispatchQueue.main.async {
                self.imageListModel?.smallSizeSection.removeAll()
                self.imageListModel?.largeSizeSection.removeAll()
                self.imageListModel?.xLargeSizeSection.removeAll()
                self.imageListModel?.xxLargeSizeSection.removeAll()
                self.collectionView.reloadData()
            }
            return
        }
        interactor?.getSoftware(with: searchText)
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2.3, height: collectionView.frame.width/1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
            
        case 0:
            return imageListModel?.smallSizeSection.count ?? 0
        case 1:
            return imageListModel?.largeSizeSection.count ?? 0
        case 2:
            return imageListModel?.xLargeSizeSection.count ?? 0
        case 3:
            return imageListModel?.xxLargeSizeSection.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
        cell.backgroundColor = .gray
        var image = UIImage.init()
        if let imageListModel = imageListModel {
            let smallSizeCount = imageListModel.smallSizeSection.count
            let largeSizeCount = imageListModel.largeSizeSection.count
            let xLargeSizeCount = imageListModel.xLargeSizeSection.count
            let xxLargeSizeCount = imageListModel.xxLargeSizeSection.count
            
            let firstSectionCount = smallSizeCount
            let secondSectionCount = firstSectionCount + largeSizeCount
            let thirdSectionCount = secondSectionCount + xLargeSizeCount
            let fourthSectionCount = thirdSectionCount + xLargeSizeCount


            if smallSizeCount > 0 && indexPath.row < smallSizeCount  {
                image = imageListModel.smallSizeSection[indexPath.row]
            }
            else if largeSizeCount > 0 && indexPath.row < secondSectionCount  {
                image = imageListModel.largeSizeSection[indexPath.row]
            }
            else if xLargeSizeCount > 0 && indexPath.row < thirdSectionCount  {
                image = imageListModel.xLargeSizeSection[indexPath.row]
            }
            else if xxLargeSizeCount > 0 &&  indexPath.row < fourthSectionCount{
                image = imageListModel.xxLargeSizeSection[indexPath.row]
            }
            
        }
        cell.configureCell(screenshot: image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        router?.routeToDetailPage(with: listViewModel[indexPath.row])
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerId, for: indexPath) as! FileCategoryHeaderView
        var headerText = ""
        guard let imageListModel = imageListModel else {
            if (indexPath.section == 0) {
                header.label.text = "No Data"
                return header
            }
            header.label.text = ""
            return header
        }
        
        if (imageListModel.smallSizeSection.isEmpty &&
            imageListModel.largeSizeSection.isEmpty &&
            imageListModel.xLargeSizeSection.isEmpty &&
            imageListModel.xxLargeSizeSection.isEmpty) {
            if(indexPath.section == 0) {
                header.label.text = "No Data"
                return header
            }
            header.label.text = ""
            return header
        }
        
        switch indexPath.section {
        case 0:
            headerText = "0-100"
        case 1:
            headerText = "100-250"
        case 2:
            headerText = "250-500"
        case 3:
            headerText = "500+"
        default:
            headerText = ""
        }

        header.label.text = headerText
        return header
    }
    

}

