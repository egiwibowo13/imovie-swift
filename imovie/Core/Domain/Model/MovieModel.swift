//
//  MovieModel.swift
//  imovie
//
//  Created by Egi Wibowo on 09/11/20.
//

import Foundation

struct MovieModel: Equatable, Identifiable {

  let id: Int
  let title: String
  let poster: String
  let backdrop: String
  let overview: String
  let popularity: String
  let vote: String
  let rating: String
  var isFavorite: Bool
  
  static var example: MovieModel {
    MovieModel(
      id: 1,
      title: "Revenge",
      poster: "https://image.tmdb.org/t/p/w500/8b22sVNbNruOcF6gv0PuhxcLFf3.jpg",
      backdrop: "https://image.tmdb.org/t/p/w500/8b22sVNbNruOcF6gv0PuhxcLFf3.jpg",
      overview: "Ex-cop, ex-convict, now unlicensed private detective Frank Beriat",
      popularity: "10",
      vote: "100",
      rating: "8",
      isFavorite: false
    )
  }
  
}
