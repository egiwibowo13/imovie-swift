//
//  LoadingView.swift
//  imovie
//
//  Created by Egi Wibowo on 12/11/20.
//

import SwiftUI

struct LoadingView: View {
    var body: some View {
      VStack {
        Text("Loading...")
        ActivityIndicator()
      }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView()
    }
}
