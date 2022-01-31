//
//  WebService.swift
//  PokemonApp
//
//  Created by Ceren Çapar on 28.01.2022.
//

import Foundation
import UIKit


class Webservice{
    static func fetchData<T : Decodable>(urlString : String, model: T.Type ,compilation: @escaping(T) -> ()){
        guard let url = URL(string: urlString) else {return}
        var request = URLRequest(url: url)
        request.timeoutInterval = 200
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { data, response, error in
                if error != nil{
                    return
                }else if data != nil {
                    guard let data = data else {return}
                    do{
                            let data = try JSONDecoder().decode(model, from: data)
                        compilation(data)
                    }catch{
                    }
            }
            
        }
        .resume()
    }
}
