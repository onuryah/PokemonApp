//
//  DataClass.swift
//  PokemonApp
//
//  Created by Ceren Çapar on 28.01.2022.


import Foundation


struct Characters: Codable {
    let results: [Result]
}

struct Result: Codable {
    let name: String
    let url: String
}


