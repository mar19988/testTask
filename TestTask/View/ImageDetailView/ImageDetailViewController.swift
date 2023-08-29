//
//  ImageDetailViewController.swift
//  TestTask
//
//  Created by Mariam on 28.08.23.
//

import UIKit
import Kingfisher

class ImageDetailViewController: UIViewController {

    // MARK: - @IBOutlets
    @IBOutlet weak var detailImage: UIImageView!
    
    // MARK: - Properties
    var homeVM = HomeViewModel()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    // MARK: - Functions
    private func setupUI() {
        let url = URL(string: homeVM.url)
        detailImage.kf.setImage(with: url)
    }

    // MARK: - @IBActions
    @IBAction func tapOnCloseButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
