//
//  MovieRepository.swift
//  imovie
//
//  Created by Egi Wibowo on 09/11/20.
//

import Foundation
import Combine

protocol MovieRepositoryProtocol {

  func getPopularMovies() -> AnyPublisher<[MovieModel], Error>
  func getRecommendMovies(movieId: Int) -> AnyPublisher<[MovieModel], Error>
  func getFavoritMovies() -> AnyPublisher<[MovieModel], Error>
  func updateMovie(from movie: MovieModel) -> AnyPublisher<MovieModel, Error>

}

final class MovieRepository: NSObject {

  typealias MovieInstance = (LocaleDataSource, RemoteDataSource) -> MovieRepository

  fileprivate let remote: RemoteDataSource
  fileprivate let locale: LocaleDataSource

  private init(locale: LocaleDataSource, remote: RemoteDataSource) {
    self.locale = locale
    self.remote = remote
  }

  static let sharedInstance: MovieInstance = { localeRepo, remoteRepo in
    return MovieRepository(locale: localeRepo, remote: remoteRepo)
  }

}

extension MovieRepository: MovieRepositoryProtocol {
  func getRecommendMovies(movieId: Int) -> AnyPublisher<[MovieModel], Error> {
    return self.remote.getRecommendMovies(movieId: movieId).map {
      MovieMapper.mapMovieResponsesToDomains(input: $0)
    }.eraseToAnyPublisher()
  }
  
  func getPopularMovies() -> AnyPublisher<[MovieModel], Error> {
    return self.locale.getPopularMovies()
      .flatMap { result -> AnyPublisher<[MovieModel], Error> in
        if result.isEmpty {
          return self.remote.getPopularMovies()
            .map { MovieMapper.mapMovieResponsesToEntities(input: $0) }
                      .flatMap { self.locale.addMovie(from: $0) }
                      .filter { $0 }
                      .flatMap { _ in self.locale.getPopularMovies()
                        .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
                      }
                      .eraseToAnyPublisher()
        } else {
          return self.locale.getPopularMovies()
                   .map { MovieMapper.mapMovieEntitiesToDomains(input: $0) }
                   .eraseToAnyPublisher()
        }
      }.eraseToAnyPublisher()
  }
  
  func getFavoritMovies() -> AnyPublisher<[MovieModel], Error> {
    return self.locale.getFavoriteMovies()
      .map {
        MovieMapper.mapMovieEntitiesToDomains(input: $0)
    }.eraseToAnyPublisher()
  }
  
  func updateMovie(from movie: MovieModel) -> AnyPublisher<MovieModel, Error> {
    return self.locale.updateMovie(from: MovieMapper.mapMovieDomainToEntity(input: movie)).map {
      MovieMapper.mapMovieEntityToDomain(input: $0)
    }.eraseToAnyPublisher()
  }
}
