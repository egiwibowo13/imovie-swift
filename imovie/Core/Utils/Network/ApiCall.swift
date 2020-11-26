//
//  ApiCall.swift
//  imovie
//
//  Created by Egi Wibowo on 09/11/20.
//

import Foundation

struct API {

  static let baseUrl = "https://api.themoviedb.org/3/"
  static let apiKey = "74078d381713cfc6b144cc4fc1e7aaef"
  static let baseUrlImage = "https://image.tmdb.org/t/p/w500"

}

protocol Endpoint {

  var url: String { get }

}

enum Endpoints {
  
  enum Gets: Endpoint {
    case popularMovies
    case recommendMovies(movieId: Int)
    
    public var url: String {
      switch self {
      case .popularMovies: return "\(API.baseUrl)movie/popular?api_key=\(API.apiKey)"
      case .recommendMovies(let movieId): do {
        return "\(API.baseUrl)movie/\(movieId)/recommendations?api_key=\(API.apiKey)"
      }
      }
    }
  }
  
}
