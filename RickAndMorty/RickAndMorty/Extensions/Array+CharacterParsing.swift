//
//  Array+CharacterParsing.swift
//  RickAndMorty
//
//  Created by atakan yetkin on 11.04.2023.
//

extension Array {
    public func characterParsing( _ stringArr: [String]) -> String {
        let parsedCharacters = stringArr.map { arrEelement in
            return arrEelement.replacingOccurrences(of: API.API_KEY.rawValue + NetworkEndPoint.EPISODE.rawValue, with: "")
        }
        let characters = parsedCharacters.joined(separator: ",".trimmingCharacters(in: []))
        return characters
    }
}
