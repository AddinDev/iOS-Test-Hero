//
//  HeroModel.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 08/03/22.
//

import Foundation

struct HeroModel: Identifiable, Equatable {
  let id: String
  let name: String
  let primary: String
  let attackType: String
  let roles: [String]
  let image: String
  let icon: String
  
  let health: String
  let mana: String
  let armor: String
  let attackMin: String
  let attackMax: String
  let speed: String
}

typealias HeroModels = [HeroModel]
