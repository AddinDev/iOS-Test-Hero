//
//  HomeView.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 08/03/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct HomeView: View {
  @StateObject var presenter: HomePresenter
  
  private let columns: [GridItem] = [
    .init(.flexible()),
    .init(.flexible()),
    .init(.flexible())
  ]
  
  var body: some View {
    Group {
      content
        .onAppear {
          if presenter.heroes.count == 0 {
            presenter.fetchHeroes()
          }
        }
    }
    .navigationTitle("All")
  }
}

extension HomeView {
  
  var content: some View {
    ScrollView {
      LazyVGrid(columns: columns) {
        ForEach(presenter.heroes) { hero in
          presenter.linkBuilder(for: hero) {
            VStack {
              WebImage(url: URL(string: "\(Api.baseUrl + hero.image)"))
                .resizable()
                .scaledToFit()
                .frame(height: 50)
              Text(hero.name)
                .fontWeight(.semibold)
                .foregroundColor(.black)
            }
          }
        }
      }
    }
  }
  
}

// struct HeroItemView: View {
//  var body: some View {
//    ScrollView {
//        LazyVGrid(columns: columns) {
//          ForEach(presenter.heroes) { hero in
//            VStack {
//              WebImage(url: URL(string: "\(Api.baseUrl + hero.image)"))
//                .resizable()
//                .scaledToFit()
//                .frame(width: 50)
//              Text(hero.name)
//            }
//          }
//        }
//    }
//  }
//}

// struct HomeView_Previews: PreviewProvider {
//  static var previews: some View {
//    HomeView()
//  }
// }
