//
//  Results.swift
//  iOS Test Hero
//
//  Created by Addin Satria on 09/03/22.
//

import Foundation
import RealmSwift

extension Results {
  
  func toArray<T>(ofType: T.Type) -> [T] {
    var array = [T]()
    for index in 0 ..< count {
      if let result = self[index] as? T {
        array.append(result)
      }
    }
    return array
  }
  
}
