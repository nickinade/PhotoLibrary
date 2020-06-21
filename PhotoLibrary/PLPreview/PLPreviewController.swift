//
//  PLPreviewController.swift
//  DesignPatterns
//
//  Created by Nikita Benin on 20.06.2020.
//  Copyright © 2020 Nikita Benin. All rights reserved.
//

import UIKit

protocol PLPreviewControllerDelegate {
    func scrollToCurrentItem(indexPath: IndexPath)
}

class PLPreviewController: UIViewController {

    // MARK: - UI Elements
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.register(PLPreviewCell.self, forCellWithReuseIdentifier: PLPreviewCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Variables
    var configuration: PLConfiguration
    var delegate: PLPreviewControllerDelegate?
    
    init(with configuration: PLConfiguration){
        self.configuration = configuration
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        view.backgroundColor = .black
    }
    
    // MARK: - Setup views
    private func setupViews(){
        collectionView.frame = view.bounds
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
}

extension PLPreviewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return UIScreen.main.bounds.size
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

extension PLPreviewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("did tap photo")
        configuration.currentIndexPath = indexPath
        delegate?.scrollToCurrentItem(indexPath: indexPath)
        self.dismiss(animated: true, completion: nil)
    }
}

extension PLPreviewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return configuration.mediaItems.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PLPreviewCell.reuseIdentifier, for: indexPath) as? PLPreviewCell {
            cell.setCell(item: configuration.mediaItems[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
}
