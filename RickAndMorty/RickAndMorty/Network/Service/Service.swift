//
//  Service.swift
//  RickAndMorty
//
//  Created by atakan yetkin on 11.04.2023.
//

import Alamofire
import RxSwift

protocol ServiceProtocol {
   
    func getLocations(_ nextPage: Int) -> Observable<LocationModel?>
    func getCharacters() -> Observable<CharacterModel?>
    func getSingleLocation(_ id: Int) -> Observable<LocationResult?>
    func getMultipleCharacters(_ IDs: String) -> Observable<[CharacterResult]?>
    func getSingleCharacter(_ id: Int) -> Observable<SingleCharacter?>
    func getNextLocations(_ url: String) -> Observable<LocationModel?>
    
}


final class Service: ServiceProtocol {
 static let shared = Service()
    
    func getLocations(_ nextPage: Int) -> Observable<LocationModel?> {
        return NetworkManager.shared.request(path: NetworkHelper.shared.locationRequestUrl(nextPage)).asObservable()
     }
     
     func getNextLocations(_ url: String) -> RxSwift.Observable<LocationModel?> {
         return NetworkManager.shared.request(path: url)
     }
     
     func getMultipleCharacters(_ IDs: String) -> RxSwift.Observable<[CharacterResult]?> {
         return NetworkManager.shared.request(path: NetworkHelper.shared.multipleCharactersRequestUrl(IDs)).asObservable()
     }
     
     
     func getSingleLocation(_ id: Int) -> RxSwift.Observable<LocationResult?> {
         return NetworkManager.shared.request(path: NetworkHelper.shared.singleLocationRequestUrl(id)).asObservable()
     }
     
     func getCharacters() -> Observable<CharacterModel?> {
         return NetworkManager.shared.request(path: NetworkHelper.shared.characterRequestUrl()).asObservable()
     }
  
    func getSingleCharacter(_ id: Int) -> RxSwift.Observable<SingleCharacter?> {
        return NetworkManager.shared.request(path: NetworkHelper.shared.singleCharacterRequestUrl(id)).asObservable()
    }
}
