//
//  DetailPresenter.swift
//  imovie
//
//  Created by Egi Wibowo on 13/11/20.
//

import Foundation
import SwiftUI
import Combine
import Alamofire

class DetailPresenter: ObservableObject {

  private let router = DetailRouter()
  private let detailUseCase: DetailUseCase
  
  @Published var movie: MovieModel
  @Published var recommendMovies: [MovieModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  private var cancellables: Set<AnyCancellable> = []
  
  init(detailUseCase: DetailUseCase) {
    self.detailUseCase = detailUseCase
    self.movie = detailUseCase.getMovie()
  }
  
  func getRecommendMovies() {
    loadingState = true
    print(movie)
    detailUseCase.getRecommendMovies(from: movie.id)
          .receive(on: RunLoop.main)
          .sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
              self.errorMessage = String(describing: completion)
            case .finished:
              self.loadingState = false
            }
          }, receiveValue: { movies in
            self.recommendMovies = movies
          })
          .store(in: &cancellables)
  }
  
  func updateMovie() {
    loadingState = true
    var newMovie = movie
    newMovie.isFavorite = !movie.isFavorite
    detailUseCase.updateMovie(from: newMovie)
          .receive(on: RunLoop.main)
          .sink(receiveCompletion: { completion in
            switch completion {
            case .failure:
              self.errorMessage = String(describing: completion)
            case .finished:
              self.loadingState = false
            }
          }, receiveValue: { _movie in
            self.movie.isFavorite = _movie.isFavorite
          })
          .store(in: &cancellables)
  }

  func linkBuilderDetail<Content: View>(
    for movie: MovieModel,
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
    destination: router.makeDetailView(for: movie)) { content() }
  }
}
