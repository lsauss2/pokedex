//
//  PokemonDetailVC.swift
//  Pokedex
//
//  Created by Ludo on 16/01/2017.
//  Copyright © 2017 Ludo. All rights reserved.
//

import UIKit

class PokemonDetailVC: UIViewController {
    
    
    @IBOutlet var pokemonName: UILabel!
    @IBOutlet var segment: UISegmentedControl!
    
    @IBOutlet var mainImage: UIImageView!
    @IBOutlet var manDescription: UILabel!
    @IBOutlet var typeLbl: UILabel!
    @IBOutlet var defenseLbl: UILabel!
    @IBOutlet var heightLbl: UILabel!
    @IBOutlet var weightLbl: UILabel!
    @IBOutlet var pokedexLbl: UILabel!
    @IBOutlet var attackLbl: UILabel!
    @IBOutlet var currentEvoImg: UIImageView!
    @IBOutlet var nextEvoImg: UIImageView!
    @IBOutlet var evoLbl: UILabel!
    
    var pokemon: Pokemon!

    override func viewDidLoad() {
        super.viewDidLoad()

        pokemonName.text = pokemon.name.capitalized
        let image = UIImage(named: "\(pokemon.pokedexid)")
        mainImage.image = image
        currentEvoImg.image = image
        pokedexLbl.text = "\(pokemon.pokedexid)"
        
        
        pokemon.downloadPokemonDetails {
            
            self.updateUI()
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
        
    }
    
    func updateUI() {
        
        attackLbl.text = pokemon.attack
        defenseLbl.text = pokemon.defense
        heightLbl.text = pokemon.height
        weightLbl.text = pokemon.weight
        typeLbl.text = pokemon.type
        manDescription.text = pokemon.description
        
        if pokemon.nextEvoId == "" {
            
            evoLbl.text = "No evolutions"
            nextEvoImg.isHidden = true
            
        } else {
            
            nextEvoImg.isHidden = false
            nextEvoImg.image = UIImage(named: "\(pokemon.nextEvoId)")
            evoLbl.text = "Next Level: \(pokemon.nextEvoName) LVL \(pokemon.nextEvoLever)"
            
        }
        
        
        
        
    }

    

}
