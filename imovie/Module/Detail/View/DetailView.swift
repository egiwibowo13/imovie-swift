//
//  DetailView.swift
//  imovie
//
//  Created by Egi Wibowo on 12/11/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
  @ObservedObject var presenter: DetailPresenter

  var body: some View {
    ZStack {
      if presenter.loadingState {
        loadingIndicator
      } else {
        ScrollView(.vertical) {
          VStack(alignment: .leading) {
            imageMovie
            spacer
            content
            spacer
          }
        }
      }
    }.navigationBarTitle(
      Text(self.presenter.movie.title),
      displayMode: .automatic
    )
    .onAppear {
      self.presenter.getRecommendMovies()
    }
  }
}

extension DetailView {

  var imageMovie: some View {
    image(self.presenter.movie.backdrop)
      .frame(width: UIScreen.main.bounds.width, height: 250.0, alignment: .center)
  }
  
  var favorite: some View {
    
    let colorIcon = self.presenter.movie.isFavorite ? ColorManager.secundaryColor : ColorManager.primaryColor
    return Button {
      self.presenter.updateMovie()
    } label: {
      iconDefault("ic-favorite", renderingMode: .template)
        .foregroundColor(colorIcon)
    }
  }
  
  var rating: some View {
    VStack {
      iconDefault("ic-star")
      caption("\(self.presenter.movie.rating)/10")
    }
  }
  
  var vote: some View {
    VStack {
      title2(self.presenter.movie.vote)
      caption("Vote")
    }
  }
  
  var popularity: some View {
    VStack {
      title2(self.presenter.movie.popularity)
      caption("Popularity")
    }
  }
  
  var recommendMovies: some View {
    VStack(alignment: .leading) {
      headerTitle("Recommendation")
      ScrollView(.horizontal, showsIndicators: false) {
          HStack(alignment: .top) {
            ForEach(self.presenter.recommendMovies) { movie in
                ZStack {
                  self.presenter.linkBuilderDetail(for: movie) {
                    MovieThumbnail(movie: movie)
                  }.buttonStyle(PlainButtonStyle())
                }
              }
          }
      }.frame(alignment: .leading)
    }.padding(.vertical)
  }
  
  var subContent: some View {
    HStack {
      popularity
      spacer
      vote
      spacer
      rating
      spacer
      favorite
    }.padding(.horizontal, 16)
  }

  var content: some View {
    VStack(alignment: .leading, spacing: 0) {
      subContent
      headerTitle("Description")
        .padding([.top, .bottom])
      description(self.presenter.movie.overview)
      recommendMovies
    }.padding(.horizontal, 16)
  }
}

struct DetailView_Previews: PreviewProvider {
  static var previews: some View {
    DetailView(presenter: DetailPresenter(detailUseCase: Injection.init().provideDetail(movie: MovieModel.example)))
  }
}
