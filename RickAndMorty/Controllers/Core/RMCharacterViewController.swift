//
//  RMCharacterViewController.swift
//  RickAndMorty
//
//  Created by Méryl VALIER on 27/08/2023.
//

import UIKit

/// Controller to show and search for character
final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        title = "Characters"
        
        RMService.shared.execute(.listCharactersRequests, expecting: RMGetAllCharactersResponse.self) { result in
            switch result {
            case .success(let character):
                print("Total: \(character.info.count)")
                print("Page result count : \(character.results.count)")
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    

}
