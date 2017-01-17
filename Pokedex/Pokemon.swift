//
//  Pokemon.swift
//  Pokedex
//
//  Created by Ludo on 15/01/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name:String!
    private var _pokedexid:Int!
    private var _description:String!
    private var _type:String!
    private var _defense:String!
    private var _height:String!
    private var _weight:String!
    private var _attack:String!
    private var _nextEvoText:String!
    private var _nextEvoName:String!
    private var _nextEvoId:String!
    private var _nextEvoLevel:String!
    private var _pokemonUrl:String!
    
    var nextEvoLever:String {
        if _nextEvoLevel == nil {
            _nextEvoLevel = ""
        }
        return _nextEvoLevel
    }
    
    var nextEvoId:String {
        if _nextEvoId == nil {
            _nextEvoId = ""
        }
        return _nextEvoId
    }
    
    var nextEvoName:String {
        if _nextEvoName == nil {
            _nextEvoName = ""
        }
        return _nextEvoName
    }
    
    var nextEvoText: String {
        if _nextEvoText == nil {
            _nextEvoText = ""
        }
        return _nextEvoText
    }
    
    var attack: String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var weight: String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var height: String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    var defense: String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var type: String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var description:String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    
    var name: String {
        return _name
    }

    var pokedexid:Int {
    return _pokedexid
    }

    init(name:String, pokedexid:Int){
    self._name = name
    self._pokedexid = pokedexid
    self._pokemonUrl = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexid!)/"
    }
    
    func downloadPokemonDetails(completed: @escaping DownloadComplete){
        
        Alamofire.request(_pokemonUrl).responseJSON { (response) in
            
            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let typeDict = dict["types"] as? [Dictionary<String, String>] , typeDict.count > 0 {
                    
                    if let name = typeDict[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if typeDict.count > 1 {
                        
                        for x in 1..<typeDict.count {
                            
                            if let name = typeDict[x]["name"] {
                                
                                self._type! += "/\(name.capitalized)"
                                
                            }
                            
                        }
                        
                    }
                    
                } else {
                    self._type = ""
                }
                
                if let descArray = dict["descriptions"] as? [Dictionary<String, String>] , descArray.count > 0 {
                    
                    if let url = descArray[0]["resource_uri"] {
                        
                        let descUrl = "\(URL_BASE)\(url)"
                        
                        Alamofire.request(descUrl).responseJSON(completionHandler: { (response) in
                            
                            if let descriptionDict = response.result.value as? Dictionary<String, AnyObject> {
                                
                                if let description = descriptionDict["description"] as? String {
                                    
                                    let newDescription = description.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    
                                    self._description = newDescription
                                    
                                }
                                
                            }
                            
                            completed()
                           
                            })
                        
                    }
                    
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] , evolutions.count > 0 {
                    
                    if let nextEvolution = evolutions[0]["to"] as? String {
                        
                        if nextEvolution.range(of: "mega") == nil {
                            
                            self._nextEvoName = nextEvolution
                            
                            if let uri = evolutions[0]["resource_uri"] as? String {
                                let newString = uri.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                let nextEvoId = newString.replacingOccurrences(of: "/", with: "")
                                self._nextEvoId = nextEvoId
                                
                                if let levelExist = evolutions[0]["level"] {
                                    
                                    if let level = levelExist as? Int {
                                        
                                        self._nextEvoLevel = "\(level)"
                                        
                                    }
                                    
                                } else {
                                    
                                    self._nextEvoLevel = ""
                                    
                                }
                            }
                            
                        }
                        
                    }
                    
                }
                
                
            }
        
        completed()
        }
        
    }
    
    
    
}
