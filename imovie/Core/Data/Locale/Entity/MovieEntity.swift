//
//  MovieEntity.swift
//  imovie
//
//  Created by Egi Wibowo on 09/11/20.
//

import Foundation
import RealmSwift

class MovieEntity: Object {

  @objc dynamic var id: Int = 0
  @objc dynamic var title: String = ""
  @objc dynamic var poster: String = ""
  @objc dynamic var backdrop: String = ""
  @objc dynamic var overview: String = ""
  @objc dynamic var popularity: Double = 0.0
  @objc dynamic var vote: Double = 0.0
  @objc dynamic var rating: Double = 0.0
  @objc dynamic var isFavorite: Bool = false

  override static func primaryKey() -> String? {
    return "id"
  }
}
