//
//  HeroModel.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 08/03/22.
//

import Foundation

struct HeroModel: Identifiable {
  let id: Int
  let name: String
  let primary: PrimaryAttr
  let attackType: AttackType
  let roles: [Role]
  let image: String
  let icon: String
  
  let baseHealth: Int
  let baseHealthRegen: Double
  let baseMana: Int
  let baseManaRegen: Double
  let baseArmor: Double
  let baseMr: Int
  let baseAttackMin: Int
  let baseAttackMax: Int
  
  let baseStr: Int
  let baseAgi: Int
  let baseInt: Int
  
  let strGain: Double
  let agiGain: Double
  let intGain: Double

  let attackRange: Int
  let attackRate: Double
  let projectileSpeed: Int
  let moveSpeed: Int
}
