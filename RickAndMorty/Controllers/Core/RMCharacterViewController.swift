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
        
        let request = RMRequest(endpoint: .character, path: ["1"], query: [
            URLQueryItem(name: "name", value: "rick"),
            URLQueryItem(name: "status", value: "alive")
        ])
        print(request.url)
    }
    

}
