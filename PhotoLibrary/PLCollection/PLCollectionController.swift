//
//  PLCollectionController.swift
//  DesignPatterns
//
//  Created by Nikita Benin on 20.06.2020.
//  Copyright © 2020 Nikita Benin. All rights reserved.
//

import UIKit

struct PLMediaItem {
    var name: String?
    var image: UIImage?
    var url: URL?
}

class PLConfiguration: NSObject {
    var itemsInRow: Int = 4
    var mediaItems: [PLMediaItem] = []
    
    var currentIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    
    init(itemsInRow: Int = 4, mediaItems: [PLMediaItem] = []) {
        self.itemsInRow = itemsInRow
        self.mediaItems = mediaItems
    }
}

class PLCollectionController: UIViewController {

    // MARK: - UI Elements
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(PLCollectionCell.self, forCellWithReuseIdentifier: PLCollectionCell.reuseIdentifier)
        collectionView.backgroundColor = .clear
        return collectionView
    }()
    
    // MARK: - Variables
    var configuration: PLConfiguration
    
    // MARK: - Lifecycle
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
    
    // MARK: - Handlers
    private func showPreview(indexPath: IndexPath) {
        print("showPreview")
        let previewController = PLPreviewController(with: configuration)
        previewController.delegate = self
        previewController.modalPresentationStyle = .fullScreen
        present(previewController, animated: true, completion: nil)
    }
    
    // MARK: - Setup views
    private func setupViews(){
        collectionView.frame = view.bounds
        collectionView.dataSource = self
        collectionView.delegate = self
        view.addSubview(collectionView)
    }
}

extension PLCollectionController: PLPreviewControllerDelegate {
    func scrollToCurrentItem(indexPath: IndexPath) {
        collectionView.scrollToItem(at: indexPath, at: .centeredVertically, animated: false)
    }
}

extension PLCollectionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemWidth: CGFloat = UIScreen.main.bounds.width / CGFloat(configuration.itemsInRow) - 1
        return CGSize(width: itemWidth, height: itemWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}

extension PLCollectionController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        configuration.currentIndexPath = indexPath
        showPreview(indexPath: indexPath)
    }
}

extension PLCollectionController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return configuration.mediaItems.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PLCollectionCell.reuseIdentifier, for: indexPath) as? PLCollectionCell {
            cell.setCell(item: configuration.mediaItems[indexPath.item])
            return cell
        }
        return UICollectionViewCell()
    }
}
