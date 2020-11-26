//
//  FavoriteInteractor.swift
//  imovie
//
//  Created by Egi Wibowo on 12/11/20.
//

import Foundation
import Combine

protocol FavoriteUseCase {

  func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error>

}

class FavoriteInteractor: FavoriteUseCase {
  
  private let repository: MovieRepositoryProtocol
  
  required init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }
  
  func getFavoriteMovies() -> AnyPublisher<[MovieModel], Error> {
    return repository.getFavoritMovies()
  }

}
