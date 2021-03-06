//
//  JSONDataModel.swift
//  Reciplease
//
//  Created by jullianm on 15/12/2017.
//  Copyright © 2017 jullianm. All rights reserved.
//

import Foundation

// MARK: Decoding 'Search recipes response'

struct Root: Decodable {
    let matches: [Matches]
}

struct Matches: Decodable {
    let ingredients: [String]
    let rating: Int?
    let recipeName: String
    let id: String
    let totalTimeInSeconds: Int?
}

// MARK: Decoding 'Get recipes response'

struct GetRecipesRoot: Decodable {
    let images: [Images]?
    let ingredientLines: [String]
    let source: Sources
}

struct Images: Decodable {
    let hostedLargeUrl: URL?
    let hostedMediumUrl: URL?
    let hostedSmallUrl: URL?
}

struct Sources: Decodable {
    let sourceRecipeUrl: URL
}
