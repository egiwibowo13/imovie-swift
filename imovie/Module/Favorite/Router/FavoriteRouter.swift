//
//  FavoriteRouter.swift
//  imovie
//
//  Created by Egi Wibowo on 12/11/20.
//

import SwiftUI

class FavoriteRouter {
  func makeDetailView(for movie: MovieModel) -> some View {
    let detailUseCase = Injection.init().provideDetail(movie: movie)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    return DetailView(presenter: presenter)
  }
}
