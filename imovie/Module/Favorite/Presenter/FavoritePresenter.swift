//
//  FavoritePresenter.swift
//  imovie
//
//  Created by Egi Wibowo on 12/11/20.
//

import SwiftUI
import Combine
import Alamofire

class FavoritePresenter: ObservableObject {

  private let router = FavoriteRouter()
  private let favoriteUseCase: FavoriteUseCase
  
  @Published var movies: [MovieModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  private var cancellables: Set<AnyCancellable> = []
  
  init(favoriteUseCase: FavoriteUseCase) {
    self.favoriteUseCase = favoriteUseCase
  }
  
  func getFavorites() {
    loadingState = true
    favoriteUseCase.getFavoriteMovies()
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.errorMessage = String(describing: completion)
        case .finished:
          self.loadingState = false
        }
      }, receiveValue: { movies in
        self.movies = movies
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
