//
//  HomePresenter.swift
//  imovie
//
//  Created by Egi Wibowo on 09/11/20.
//

import Foundation
import SwiftUI
import Combine
import Alamofire

class HomePresenter: ObservableObject {

  private let router = HomeRouter()
  private let homeUseCase: HomeUseCase
  
  @Published var movies: [MovieModel] = []
  @Published var errorMessage: String = ""
  @Published var loadingState: Bool = false
  
  private var cancellables: Set<AnyCancellable> = []
  
  init(homeUseCase: HomeUseCase) {
    self.homeUseCase = homeUseCase
  }
  
  func getPopularMovies() {
    loadingState = true
    homeUseCase.getPopularMovies()
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
  
  func linkBuilderFavorite<Content: View>(
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
      destination: router.makeFavoriteView()) { content() }
  }
  
  func linkBuilderAbout<Content: View>(
    @ViewBuilder content: () -> Content
  ) -> some View {
    NavigationLink(
    destination: router.makeAboutView()) { content() }
  }

}
