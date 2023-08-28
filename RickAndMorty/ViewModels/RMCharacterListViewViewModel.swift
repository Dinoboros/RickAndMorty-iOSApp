//
//  RMCharacterListViewViewModel.swift
//  RickAndMorty
//
//  Created by Méryl VALIER on 28/08/2023.
//

import UIKit

final class CharacterListViewViewModel: NSObject {
    func fetchCharacters() {
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

extension CharacterListViewViewModel: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .brown
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let bounds = UIScreen.main.bounds
        let width = (bounds.width - 30) / 2

        return CGSize(width: width, height: width * 1.5)
    }
}
