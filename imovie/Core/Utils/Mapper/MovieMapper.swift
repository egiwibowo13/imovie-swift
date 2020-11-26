//
//  MovieMapper.swift
//  imovie
//
//  Created by Egi Wibowo on 09/11/20.
//

import Foundation

final class MovieMapper {

  static func mapMovieResponsesToEntities(
    input movieResponses: [MovieResponse]
  ) -> [MovieEntity] {
    return movieResponses.map { result in
      let newMovie = MovieEntity()
      newMovie.id = result.id ?? 0
      newMovie.title = result.title ?? "Unknow"
      newMovie.poster = result.poster ?? "Unknow"
      newMovie.backdrop = result.backdrop ?? "Unknow"
      newMovie.overview = result.overview ?? "Unknow"
      newMovie.popularity = result.popularity ?? 0.0
      newMovie.vote = result.vote ?? 0.0
      newMovie.rating = result.rating ?? 0.0
      newMovie.isFavorite = false
      return newMovie
    }
  }

  static func mapMovieEntitiesToDomains(
    input movieEntities: [MovieEntity]
  ) -> [MovieModel] {
    return movieEntities.map { result in
      return MovieModel(
        id: result.id,
        title: result.title,
        poster: result.poster,
        backdrop: result.backdrop,
        overview: result.overview,
        popularity: String(format: "%.0f", result.popularity),
        vote: String(format: "%.0f", result.vote),
        rating: String(format: "%.1f", result.rating),
        isFavorite: result.isFavorite
      )
    }
  }

  static func mapMovieResponsesToDomains(
    input movieResponses: [MovieResponse]
  ) -> [MovieModel] {

    return movieResponses.map { result in
      return MovieModel(
        id: result.id ?? 0,
        title: result.title ?? "Unknow",
        poster: result.poster ?? "Unknow",
        backdrop: result.backdrop ?? "Unknow",
        overview: result.overview ?? "Unknow",
        popularity: String(format: "%.0f", result.popularity ?? 0.0),
        vote: String(format: "%.0f", result.vote ?? 0.0),
        rating: String(format: "%.1f", result.rating ?? 0.0),
        isFavorite: false
      )
    }
  }
  
  static func mapMovieDomainToEntity(
    input movieDomain: MovieModel
  ) -> MovieEntity {
      let newMovie = MovieEntity()
      newMovie.id = movieDomain.id
      newMovie.title = movieDomain.title
      newMovie.poster = movieDomain.poster
      newMovie.backdrop = movieDomain.backdrop
      newMovie.overview = movieDomain.overview
      newMovie.popularity = Double(movieDomain.popularity) ?? 0.0
      newMovie.vote = Double(movieDomain.vote) ?? 0.0
      newMovie.rating = Double(movieDomain.rating) ?? 0.0
      newMovie.isFavorite = movieDomain.isFavorite
      return newMovie
  }
  
  static func mapMovieEntityToDomain(
    input movieEntity: MovieEntity
  ) -> MovieModel {
      return MovieModel(
        id: movieEntity.id,
        title: movieEntity.title,
        poster: movieEntity.poster,
        backdrop: movieEntity.backdrop,
        overview: movieEntity.overview,
        popularity: String(format: "%.0f", movieEntity.popularity ),
        vote: String(format: "%.0f", movieEntity.vote ),
        rating: String(format: "%.1f", movieEntity.rating ),
        isFavorite: movieEntity.isFavorite)
  }
  
}
