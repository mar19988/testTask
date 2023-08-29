//
//  HomeItemsCollectionViewCell.swift
//  TestTask
//
//  Created by Mariam on 28.08.23.
//

import UIKit
import Kingfisher

protocol AddToFavorites: AnyObject {
    func addToFavs(id: Int)
    func removeFromFavs(id: Int)
}

class HomeItemsCollectionViewCell: UICollectionViewCell {

    // MARK: - @IBOutlets
    @IBOutlet weak var favoriteButton: UIButton!
    @IBOutlet weak var itemImage: UIImageView!
    
    // MARK: - Properties
    var isFavorite: Bool = false
    var productId: Int = 0
    weak var delegate: AddToFavorites?
    static let id = "HomeItemsCollectionViewCell"
    
    // MARK: - Functions
    func setup(model: HomeModel, fromFavorites: Bool, isFavorite: Bool = false) {
        favoriteButton.isHidden = fromFavorites
        favoriteButton.setImage(isFavorite ? UIImage(named: "heart_filled") : UIImage(named: "heart_unfill"), for: .normal)
        let url = URL(string: model.url)
        itemImage.kf.setImage(with: url)
        self.productId = model.id
    }
    
    // MARK: - @IBActions
    @IBAction func tapOnFavoriteButton(_ sender: Any) {
        if !isFavorite {
            isFavorite = true
            favoriteButton.setImage(UIImage(named: "heart_filled"), for: .normal)
            delegate?.addToFavs(id: productId)
        } else {
            isFavorite = false
            favoriteButton.setImage(UIImage(named: "heart_unfill"), for: .normal)
            delegate?.removeFromFavs(id: productId)
        }
    }
}
