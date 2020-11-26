//
//  AboutView.swift
//  imovie
//
//  Created by Egi Wibowo on 12/11/20.
//

import SwiftUI

struct AboutView: View {
  
  var body: some View {
          VStack {
            imageCircle("photo-egi")
              .frame(width: 100, height: 100, alignment: .top)
            headerTitle(MString.author)
              .padding(.bottom, 30)
            
              HStack {
                iconDefault("ic-github")
                description(MString.githubAccount)
                  .foregroundColor(.secondary)
                spacer
              }.padding(.horizontal, 25)
            
            description(MString.messageApp)
              .foregroundColor(.secondary)
              .padding(.top, 30)
               spacer
          }
          .navigationBarTitle(MString.titleProfile, displayMode: .automatic)
  }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
