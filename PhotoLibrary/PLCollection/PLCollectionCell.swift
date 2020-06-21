//
//  PLCollectionCell.swift
//  DesignPatterns
//
//  Created by Nikita Benin on 20.06.2020.
//  Copyright © 2020 Nikita Benin. All rights reserved.
//

import UIKit

class PLCollectionCell: PLBaseMediaCell {
    
    
    // MARK: - UI Elements
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setCell(item: PLMediaItem) {
        backgroundColor = .white
        
        if item.image != nil {
            imageView.image = item.image
        } else if item.url != nil {
            setImageForUrl(url: item.url, completion:{ [weak self] (image) in
                self?.imageView.image = image
            })
        }
    }
    
    // MARK: - Setup Views
    private func setupViews(){
        addSubview(imageView)
    }
    
    private func setupConstraints() {
        imageView.frame = bounds
    }
}
