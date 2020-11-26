//
//  MovieRow.swift
//  imovie
//
//  Created by Egi Wibowo on 11/11/20.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieRow: View {

  var movie: MovieModel
  var body: some View {
    VStack(alignment: .leading) {
      imageMovie
      content
    }
    .frame(width: UIScreen.main.bounds.width - 32, height: 250)
    .background(ColorManager.primaryColor)
    .cornerRadius(30)
  }

}

extension MovieRow {

  var imageMovie: some View {
    WebImage(url: URL(string: API.baseUrlImage + movie.backdrop))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
      .cornerRadius(30, corners: [.topLeft, .topRight])
  }
  
  var content: some View {
    VStack(alignment: .leading, spacing: 10) {
      title2(movie.title)
        .lineLimit(1)
        .padding(.leading)
        .foregroundColor(ColorManager.tertiaryColor)
    }.padding(
      EdgeInsets(
        top: 0,
        leading: 0,
        bottom: 16,
        trailing: 0
      )
    )
  }

}

struct MovieRow_Previews: PreviewProvider {

  static var previews: some View {
    return MovieRow(movie: MovieModel.example)
  }

}
