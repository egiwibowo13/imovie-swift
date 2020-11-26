//
//  DetailInteractor.swift
//  imovie
//
//  Created by Egi Wibowo on 13/11/20.
//

import Foundation
import Combine

protocol DetailUseCase {

  func getMovie() -> MovieModel
  func updateMovie(from movie: MovieModel) -> AnyPublisher<MovieModel, Error>
  func getRecommendMovies(from movieId: Int) -> AnyPublisher<[MovieModel], Error>

}

class DetailInteractor: DetailUseCase {
  private let repository: MovieRepositoryProtocol
  private let movie: MovieModel
  
  required init(repository: MovieRepositoryProtocol, movie: MovieModel) {
    self.repository = repository
    self.movie = movie
  }
  
  func getRecommendMovies(from movieId: Int) -> AnyPublisher<[MovieModel], Error> {
    return repository.getRecommendMovies(movieId: movieId)
  }
  
  func updateMovie(from movie: MovieModel) -> AnyPublisher<MovieModel, Error> {
    return repository.updateMovie(from: movie)
  }
  
  func getMovie() -> MovieModel {
    return movie
  }

}
