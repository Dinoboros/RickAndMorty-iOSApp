//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMorty
//
//  Created by Méryl VALIER on 28/08/2023.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    private let character: RMCharacter
    
    init(character: RMCharacter) {
        self.character = character
    }
    
    public var title: String {
        character.name.uppercased()
    }
}
