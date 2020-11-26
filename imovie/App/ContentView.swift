//
//  ContentView.swift
//  imovie
//
//  Created by Egi Wibowo on 06/11/20.
//

import SwiftUI

struct ContentView: View {
  
    var body: some View {
      NavigationView {
        HomeView()
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
