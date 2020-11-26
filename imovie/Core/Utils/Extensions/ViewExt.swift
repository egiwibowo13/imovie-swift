//
//  ViewExt.swift
//  imovie
//
//  Created by Egi Wibowo on 14/11/20.
//

import Foundation
import SwiftUI
import SDWebImageSwiftUI

extension View {
  
  var spacer: some View {
    Spacer()
  }
  
  var loadingIndicator: some View {
    VStack {
      Text("Loading...")
      ActivityIndicator()
    }
  }
  
  var emptyState: some View {
    VStack {
      Image("ic-empty-movie")
        .resizable()
        .frame(width: 150, height: 180, alignment: .leading)
      Text("Movie Empty").padding(.top, 20)
    }
  }
    
  func headerTitle(_ title: String) -> some View {
    return Text(title)
      .font(.headline)
  }
  
  func title2(_ txt: String) -> some View {
    return Text(txt).font(.title2).foregroundColor(Color(hex: "#30475e"))
  }
  
  func description(_ txt: String) -> some View {
    Text(txt)
      .font(.system(size: 15))
  }
  
  func caption(_ txt: String) -> some View {
    return Text(txt)
      .font(.caption)
  }
  
  func iconDefault(_ iconName: String, renderingMode: Image.TemplateRenderingMode? = .original) -> some View {
    return Image(iconName)
      .renderingMode(renderingMode)
      .resizable()
      .frame(width: 20, height: 20, alignment: .leading)
  }
 
  func image(_ path: String) -> some View {
    return WebImage(url: URL(string: API.baseUrlImage + path))
      .resizable()
      .indicator(.activity)
      .transition(.fade(duration: 0.5))
  }
  
  func imageCircle(_ imageName: String) -> some View {
    return Image(imageName)
      .resizable()
      .clipShape(Circle())
      .shadow(radius: 2)
      .overlay(Circle().stroke(Color.gray, lineWidth: 0.2))
  }
}
