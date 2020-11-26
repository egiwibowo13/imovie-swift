//
//  MovieEntity.swift
//  imovie
//
//  Created by Egi Wibowo on 09/11/20.
//

import Foundation

struct MoviesResponse: Decodable {
  private enum CodingKeys: String, CodingKey {
    case movies = "results"
  }

  let movies: [MovieResponse]
  
}

struct MovieResponse: Decodable {

  private enum CodingKeys: String, CodingKey {
    case id = "id"
    case title = "title"
    case poster = "poster_path"
    case backdrop = "backdrop_path"
    case overview = "overview"
    case popularity = "popularity"
    case vote = "vote_count"
    case rating = "vote_average"
  }

  let id: Int?
  let title: String?
  let poster: String?
  let backdrop: String?
  let overview: String?
  let popularity: Double?
  let vote: Double?
  let rating: Double?

}
