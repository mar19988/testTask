//
//  ViewController.swift
//  TestTask
//
//  Created by Mariam on 28.08.23.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - @IBOutlets
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - Properties
    let homeVM = HomeViewModel()
        
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        updateCollection()
        setupUI()
        homeVM.getImages()
    }
    
    // MARK: - Functions
    private func setupUI() {
        collectionView.register(UINib(nibName: HomeItemsCollectionViewCell.id, bundle: nil), forCellWithReuseIdentifier: HomeItemsCollectionViewCell.id)
        title = "Home"
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
extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeVM.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeItemsCollectionViewCell.id, for: indexPath) as? HomeItemsCollectionViewCell else {return UICollectionViewCell()}
        cell.setup(model: homeVM.items[indexPath.item], fromFavorites: false, isFavorite: (homeVM.favoriteItems.first(where: {$0.id == homeVM.items[indexPath.item].id}) != nil))
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width / 2) - 10, height: 120)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "ImageDetailViewController") as! ImageDetailViewController
        homeVM.url = homeVM.items[indexPath.item].url
        vc.homeVM = homeVM
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastItem = homeVM.items.count - 1
            if indexPath.item == lastItem {
                homeVM.currentPage += 1
                homeVM.getImages()
            }
        }
}

extension HomeViewController: AddToFavorites {
    func addToFavs(id: Int) {
        homeVM.addToFavs(id: id)
    }
    
    func removeFromFavs(id: Int) {
        homeVM.removeFromFavs(id: id)
    }
}
