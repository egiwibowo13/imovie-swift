//
//  HomeRouter.swift
//  imovie
//
//  Created by Egi Wibowo on 12/11/20.
//

import SwiftUI

class HomeRouter {

  func makeDetailView(for movie: MovieModel) -> some View {
    let detailUseCase = Injection.init().provideDetail(movie: movie)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    return DetailView(presenter: presenter)
  }
  
  func makeFavoriteView() -> some View {
    return FavoriteView()
  }
  
  func makeAboutView() -> some View {
    return AboutView()
  }
}
