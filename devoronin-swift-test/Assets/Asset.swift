//
//  Asset.swift
//  devoronin-swift-test
//
//  Created by Dmitrii Voronin on 26.02.2023.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let asset = try? JSONDecoder().decode(Asset.self, from: jsonData)

//
// Hashable or Equatable:
// The compiler will not be able to synthesize the implementation of Hashable or Equatable
// for types that require the use of JSONAny, nor will the implementation of Hashable be
// synthesized for types that have collections (such as arrays or dictionaries).

import Foundation

// MARK: - Asset
struct Asset: Codable, Hashable {
    let id: String
    let rank: String
    let symbol: String
    let name: String
    let supply: String
    let maxSupply: String
    let marketCapUsd: String
    let volumeUsd24Hr: String
    let priceUsd: String
    let changePercent24Hr: String
    let vwap24Hr: String
    let explorer: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case rank = "rank"
        case symbol = "symbol"
        case name = "name"
        case supply = "supply"
        case maxSupply = "maxSupply"
        case marketCapUsd = "marketCapUsd"
        case volumeUsd24Hr = "volumeUsd24Hr"
        case priceUsd = "priceUsd"
        case changePercent24Hr = "changePercent24Hr"
        case vwap24Hr = "vwap24Hr"
        case explorer = "explorer"
    }
}

struct AssetListResponse: Decodable {
    enum CodingKeys: String, CodingKey {
        case items
    }
    
    let items: [Asset]
}
