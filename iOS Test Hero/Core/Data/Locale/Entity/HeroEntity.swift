//
//  HeroEntity.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 08/03/22.
//

import Foundation
import RealmSwift

class HeroEntity: Object {
  
  @objc dynamic var id: String = ""
  @objc dynamic var name: String = ""
  @objc dynamic var primaryAttr: String = ""
  @objc dynamic var attackType: String = ""
  @objc dynamic var image: String = ""
  @objc dynamic var icon: String = ""
  
  @objc dynamic var baseHealth: String = ""
  @objc dynamic var baseMana: String = ""
  @objc dynamic var baseArmor: String = ""
  @objc dynamic var baseAttackMin: String = ""
  @objc dynamic var baseAttackMax: String = ""
  @objc dynamic var moveSpeed: String = ""
  
  let roles = List<String>()

  override class func primaryKey() -> String? {
    return "id"
  }
  
}

typealias HeroEntities = [HeroEntity]
