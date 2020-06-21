//
//  PLBaseMediaCell.swift
//  DesignPatterns
//
//  Created by Nikita Benin on 20.06.2020.
//  Copyright © 2020 Nikita Benin. All rights reserved.
//

import UIKit
import Kingfisher

class PLBaseMediaCell: UICollectionViewCell {
    
    // MARK: - Static properties
    static var reuseIdentifier: String {
        return "\(self)"
    }
    
    func setImageForUrl(url: URL?, completion: @escaping (UIImage?) -> Void) {
        guard let url = url else { return }
        KingfisherManager.shared.retrieveImage(with: url) { (result) in
            switch result {
                case .success(let retrieveImageResult):
                    completion(retrieveImageResult.image)
                case .failure(let kingfisherError):
                    completion(nil)
                    print("Error:", kingfisherError.localizedDescription)
            }
        }
    }
}
