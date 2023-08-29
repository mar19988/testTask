//
//  FavoritesViewController.swift
//  TestTask
//
//  Created by Mariam on 28.08.23.
//

import UIKit

class FavoritesViewController: UIViewController {

    // MARK: - @IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
     let homeVM = HomeViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCollection()
        homeVM.getImages()
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
    
    // MARK: - Functions
    
    private func setup() {
        collectionView.register(UINib(nibName: HomeItemsCollectionViewCell.id, bundle: nil), forCellWithReuseIdentifier: HomeItemsCollectionViewCell.id)
        NotificationCenter.default.addObserver(self, selector: #selector(self.methodOfReceivedNotification(notification:)), name: Notification.Name("itemData"), object: nil)
    }
    
    @objc func methodOfReceivedNotification(notification: Notification) {
        if let item = notification.userInfo?["items"] as? [HomeModel] {
            homeVM.favoriteItems = item
        }
    }
    
    private func updateCollection() {
        homeVM.updateCollection = {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}

// MARK: - Extensions
extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeVM.favoriteItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeItemsCollectionViewCell.id, for: indexPath) as? HomeItemsCollectionViewCell else {return UICollectionViewCell()}
        cell.setup(model: homeVM.favoriteItems[indexPath.item], fromFavorites: true)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width / 2) - 10, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ImageDetailViewController") as! ImageDetailViewController
        homeVM.url = homeVM.favoriteItems[indexPath.item].url
        vc.homeVM = homeVM
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
