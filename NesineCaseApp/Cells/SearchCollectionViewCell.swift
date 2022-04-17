//
//  SearchCollectionViewCell.swift
//  NesineCaseApp
//
//  Created by Anıl Taha Uyar on 9.04.2022.
//

import Foundation
import UIKit
import Kingfisher

class SearchCollectionViewCell: UICollectionViewCell {
    
    fileprivate let image: UIImageView = {
        let iv = UIImageView()
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        contentView.addSubview(image)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
       
        image.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        image.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true

        
    }
    func configureCell(screenshot: UIImage){
        DispatchQueue.main.async { [weak self] in
            self?.image.image = screenshot

        }
    }
    
}
