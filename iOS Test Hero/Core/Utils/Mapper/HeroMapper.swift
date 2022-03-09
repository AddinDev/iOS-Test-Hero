//
//  HeroMapper.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 08/03/22.
//

import Foundation

struct HeroMapper {
  
  static func responseToEntity(responses: HeroResponses) -> HeroEntities {
    return responses.map { response in
      let entity = HeroEntity()
      entity.id = response.id.toString()
      entity.name = response.localizedName
      entity.primaryAttr = response.primaryAttr.rawValue
      entity.attackType = response.attackType.rawValue
      entity.roles.append(objectsIn: response.roles)
      entity.image = response.img
      entity.icon = response.icon
      entity.baseHealth = response.baseHealth.toString()
      entity.baseMana = response.baseMana.toString()
      entity.baseArmor = response.baseArmor.toString()
      entity.baseAttackMin = response.baseAttackMin.toString()
      entity.baseAttackMax = response.baseAttackMax.toString()
      entity.moveSpeed = response.moveSpeed.toString()
      return entity
    }
  }
  
  static func entityToDomain(entities: HeroEntities) -> HeroModels {
    return entities.map { entity in
      return HeroModel(id: entity.id,
                       name: entity.name,
                       primary: entity.primaryAttr,
                       attackType: entity.attackType,
                       roles: Array(entity.roles),
                       image: entity.image,
                       icon: entity.icon,
                       health: entity.baseHealth,
                       mana: entity.baseMana,
                       armor: entity.baseArmor,
                       attackMin: entity.baseAttackMin,
                       attackMax: entity.baseAttackMax,
                       speed: entity.moveSpeed)
    }
  }
  
  static func domainToEntity(_ model: HeroModel) -> HeroEntity {
    let entity = HeroEntity()
    entity.id = model.id
    entity.name = model.name
    entity.primaryAttr = model.primary
    entity.attackType = model.attackType
    entity.roles.append(objectsIn: model.roles)
    entity.image = model.image
    entity.icon = model.icon
    entity.baseHealth = model.health
    entity.baseMana = model.mana
    entity.baseArmor = model.armor
    entity.baseAttackMin = model.attackMin
    entity.baseAttackMax = model.attackMax
    entity.moveSpeed = model.speed
    return entity
  }
  
}
