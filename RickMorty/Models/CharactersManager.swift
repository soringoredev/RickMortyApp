//
//  CharactersManager.swift
//  RickMorty
//
//  Created by Sorin Gore on 22.03.2023.
//

import Foundation
import Apollo

struct CharactersManager {
    let url = "https://rickandmortyapi.com/graphql"
    
    private(set) lazy var apollo = ApolloClient(url: URL(string: url)!)
    
}

public struct CharactersResponse: Decodable {
    public let info: Info
    public let results: [Character]
    
    public struct Info: Decodable {
        public var count: Int
        public var pages: Int
    }
    
    public struct Character: Decodable {
       // public let id: Int
        public let name: String
        public let status: String
//        public let species: String
//        public let type: String
//        public let gender: String
//        public let origin: Location
        public let location: Location
        public let image: String
//        public let episodes: [String]
//        public let url: String
//        public let created: String
        
        enum CodingKeys: String, CodingKey {
            case name, status, location, image
            
        }
    }
    
    public struct Location: Decodable {
        public let name: String
        public let url: String
    }
}
