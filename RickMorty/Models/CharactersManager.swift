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
        public let name: String
        public let status: String
        public let location: Location
        let episode: [String]
        public let image: String
        enum CodingKeys: String, CodingKey {
            case name, status, location, image, episode
            
        }
    }
    
    public struct Location: Decodable {
        public let name: String
        public let url: String
    }
}

public struct EpisodesResponse: Decodable {
    public let info: Info
    public let results: [Episode]
    
    public struct Info: Decodable {
        public var count: Int
        public var pages: Int
    }
    
    public struct Episode: Decodable {
        public let id: Int
        public let name: String
        public let airDate: String
        public let episode: String
        public let characters: [String]
        enum CodingKeys: String, CodingKey {
            case id, name, airDate = "air_date", episode, characters
        }
    }
}

