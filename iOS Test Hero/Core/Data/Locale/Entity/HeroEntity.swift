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
  @objc dynamic var image: String = ""
  @objc dynamic var icon: String = ""
  @objc dynamic var baseHealth: String = ""
  @objc dynamic var baseHealthRegen: String = ""
  @objc dynamic var baseMana: String = ""
  @objc dynamic var baseManaRegen: String = ""
  @objc dynamic var baseArmor: String = ""
  @objc dynamic var baseMr: String = ""
  @objc dynamic var baseAttackMin: String = ""
  @objc dynamic var baseAttackMax: String = ""
  
  @objc dynamic var baseStr: String = ""
  @objc dynamic var baseAgi: String = ""
  @objc dynamic var baseInt: String = ""
  
  @objc dynamic var strGain: String = ""
  @objc dynamic var agiGain: String = ""
  @objc dynamic var intGain: String = ""
  
  @objc dynamic var attackRange: String = ""
  @objc dynamic var attackRate: String = ""
  @objc dynamic var projectileSpeed: String = ""
  @objc dynamic var moveSpeed: String = ""

  override class func primaryKey() -> String? {
    return "id"
  }
  
}
