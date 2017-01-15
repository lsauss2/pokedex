//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ludo on 15/01/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name:String!
    fileprivate var _pokedexid:Int!
    
    var name: String {
        return _name
    }

    var pokedexid:Int {
    return _pokedexid
    }

    init(name:String, pokedexid:Int){
    self._name = name
    self._pokedexid = pokedexid
    }
    
}
