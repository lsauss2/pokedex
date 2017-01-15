//
//  pokeCell.swift
//  Pokedex
//
//  Created by Ludo on 15/01/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import UIKit

class pokeCell: UICollectionViewCell {
    
    @IBOutlet weak var pokeImage:UIImageView!
    @IBOutlet weak var pokeName:UILabel!
    
    var pokemon: Pokemon!
    
    required init?(coder aDecoder: NSCoder){
        
        super.init(coder: aDecoder)
        
        layer.cornerRadius = 5.0
        
    }
    
    func configureCell(_ pokemon: Pokemon){
        
        self.pokemon = pokemon
        
        pokeName.text = self.pokemon.name.capitalized
        pokeImage.image = UIImage(named: "\(self.pokemon.pokedexid)")
        
    }
    
}
