//
//  HomeView.swift
//  imovie
//
//  Created by Egi Wibowo on 06/11/20.
//

import SwiftUI

struct HomeView: View {
  
  @ObservedObject var presenter = HomePresenter(homeUseCase: Injection.init().provideHome())
  
    var body: some View {
      ZStack {
        if presenter.loadingState {
          loadingIndicator
        } else if self.presenter.movies.isEmpty {
          emptyState
        } else {
          ScrollView(.vertical, showsIndicators: false) {
            ForEach(
              self.presenter.movies,
              id: \.id
            ) { movie in
              ZStack {
                self.presenter.linkBuilderDetail(for: movie) {
                  MovieRow(movie: movie)
                }.buttonStyle(PlainButtonStyle())
              }.padding(8)
            }
          }
        }
      }.onAppear {
        self.presenter.getPopularMovies()
      }.navigationBarTitle(
        Text("iMovie"),
        displayMode: .automatic
      )
      .navigationBarItems(trailing: HStack {
        self.presenter.linkBuilderFavorite {
          iconDefault("ic-menu-heart", renderingMode: .template)
            .foregroundColor(ColorManager.secundaryColor)
        }
        self.presenter.linkBuilderAbout {
          iconDefault("ic-user", renderingMode: .template)
            .foregroundColor(ColorManager.secundaryColor)
        }
      })
    }
}
