//
//  HomeModel.swift
//  TestTask
//
//  Created by Mariam on 28.08.23.
//

import Foundation

typealias HomeItemsModel = [HomeModel]

struct HomeModel: Codable {
    let albumID, id: Int
    let title: String
    let url, thumbnailURL: String

    enum CodingKeys: String, CodingKey {
        case albumID = "albumId"
        case id, title, url
        case thumbnailURL = "thumbnailUrl"
    }
}
