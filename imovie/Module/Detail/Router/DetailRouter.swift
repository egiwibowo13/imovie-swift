//
//  DetailRouter.swift
//  imovie
//
//  Created by Egi Wibowo on 14/11/20.
//

import SwiftUI

class DetailRouter {

  func makeDetailView(for movie: MovieModel) -> some View {
    let detailUseCase = Injection.init().provideDetail(movie: movie)
    let presenter = DetailPresenter(detailUseCase: detailUseCase)
    return DetailView(presenter: presenter)
  }
}
