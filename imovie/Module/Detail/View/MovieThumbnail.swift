//
//  MovieThumbnail.swift
//  imovie
//
//  Created by Egi Wibowo on 14/11/20.
//

import SwiftUI

struct MovieThumbnail: View {
    var movie: MovieModel
    var body: some View {
      VStack(alignment: .leading) {
        image(movie.poster)
          .frame(width: 100, height: 120)
          .cornerRadius(5)
        caption(movie.title)
          .lineLimit(2)
          .padding(.horizontal, 2)
      }.frame(width: 100, height: 150)
    }
}

struct MovieThumbnail_Previews: PreviewProvider {
    static var previews: some View {
      MovieThumbnail(movie: MovieModel.example)
    }
}
