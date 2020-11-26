//
//  HomeInteractor.swift
//  imovie
//
//  Created by Egi Wibowo on 09/11/20.
//

import Foundation
import Combine

protocol HomeUseCase {

  func getPopularMovies() -> AnyPublisher<[MovieModel], Error>

}

class HomeInteractor: HomeUseCase {
  
  private let repository: MovieRepositoryProtocol
  
  required init(repository: MovieRepositoryProtocol) {
    self.repository = repository
  }
  
  func getPopularMovies() -> AnyPublisher<[MovieModel], Error> {
    return repository.getPopularMovies()
  }

}
