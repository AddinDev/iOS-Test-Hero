//
//  DetailView.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 08/03/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct DetailView: View {
  @StateObject var presenter: DetailPresenter
  
  private let columns: [GridItem] = [
    .init(.flexible()),
    .init(.flexible()),
    .init(.flexible())
  ]
  
  var body: some View {
    ScrollView {
      content
    }
    .onAppear(perform: {
      presenter.fetchSimilarHeroes()
    })
    .navigationTitle(presenter.hero.name)
  }
}

extension DetailView {
  
  var content: some View {
    VStack(alignment: .leading) {
      WebImage(url: URL(string: "\(Api.baseUrl + presenter.hero.image)"))
        .resizable()
        .scaledToFit()
        .cornerRadius(10)
        .shadow(radius: 2)
        .padding()
      VStack {
        HStack {
          Text("Roles")
            .fontWeight(.semibold)
          Spacer()
        }
        .padding(.horizontal)
        LazyVGrid(columns: columns, alignment: .center) {
          ForEach(presenter.hero.roles, id: \.self) { role in
            HStack {
              Text("✦")
              Text(role)
              Spacer()
            }
          }
        }
        .padding(.horizontal)
      }
      
      VStack(alignment: .leading) {
        HStack(spacing: 0) {
          Text("Primary Attribute: ")
            .fontWeight(.semibold)
          Text(presenter.hero.primary)
            .autocapitalization(.allCharacters)
        }
        HStack(spacing: 0) {
          Text("Attack Type: ")
            .fontWeight(.semibold)
          Text(presenter.hero.attackType)
        }
        HStack(spacing: 0) {
          Text("Attack Damage: ")
            .fontWeight(.semibold)
          Text("\(presenter.hero.attackMin)-\(presenter.hero.attackMax)")
        }
        HStack(spacing: 0) {
          Text("Health: ")
            .fontWeight(.semibold)
          Text(presenter.hero.health)
        }
        
        HStack(spacing: 0) {
          Text("Armor: ")
            .fontWeight(.semibold)
          Text(presenter.hero.armor)
        }
        
        HStack(spacing: 0) {
          Text("Mana: ")
            .fontWeight(.semibold)
          Text(presenter.hero.mana)
        }
        
        HStack(spacing: 0) {
          Text("Speed: ")
            .fontWeight(.semibold)
          Text(presenter.hero.speed)
        }
        
      }
      .padding()
      HStack {
        ForEach(presenter.similarHeroes, id: \.id) { hero in
          presenter.linkBuilder(for: hero) {
            DetailItemView(hero: hero)
          }
        }
      }
      .padding()
    }
  }
  
}

struct DetailItemView: View {
  var hero: HeroModel
  var body: some View {
    VStack {
      WebImage(url: URL(string: "\(Api.baseUrl + hero.image)"))
        .resizable()
        .scaledToFit()
        .cornerRadius(10)
        .shadow(radius: 2)
      Text(hero.name)
        .fontWeight(.semibold)
        .foregroundColor(.black)
        .lineLimit(1)
    }
  }
}

// struct DetailView_Previews: PreviewProvider {
//  static var previews: some View {
//    DetailView()
//  }
// }
