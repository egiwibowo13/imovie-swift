//
//  FavoriteView.swift
//  imovie
//
//  Created by Egi Wibowo on 12/11/20.
//

import SwiftUI

struct FavoriteView: View {
  
  @ObservedObject var presenter = FavoritePresenter(favoriteUseCase: Injection.init().provideFavorite())
  
    var body: some View {
      ZStack {
        if presenter.loadingState {
          loadingIndicator
        } else if presenter.movies.isEmpty {
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
        self.presenter.getFavorites()
      }.navigationBarTitle(
        Text("Favorite"),
        displayMode: .automatic
      )
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
