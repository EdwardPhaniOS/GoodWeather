//
//  Webservice.swift
//  GoodWeather
//
//  Created by Tan Vinh Phan on 5/1/20.
//  Copyright © 2020 PTV. All rights reserved.
//

import Foundation

enum NetworkErrors: Error {
    case decodingError
    case urlError
    case domainError
}

struct Resource<T> {
    let url: URL
    let parse: (Data) -> T?
}

class Webservice {
    
//    func load<T>(resource: Resource<T>, completion: @escaping (Result<T, NetworkErrors>) -> Void) {
//
//        //dataTask perform on back ground thread
//        URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
//
//            guard let safeData = data, error == nil else {
//                completion(Result.failure(.domainError))
//                return
//            }
//
//            let results = try? JSONDecoder().decode(T.self, from: safeData)
//
//            if let safeResults = results {
//                //Send the final result to main thread
//                completion(Result.success(safeResults))
//            } else {
//                completion(Result.failure(.decodingError))
//            }
//
//        }.resume()
//    }
    
    func load<T>(resource: Resource<T>, completion: @escaping (T?) -> Void) {
        
        //dataTask perform on back ground thread
        URLSession.shared.dataTask(with: resource.url) { (data, response, error) in
            
            guard let safeData = data, error == nil else {
                completion(nil)
                return
            }
            
            //send result to main thread
            DispatchQueue.main.async {
                completion(resource.parse(safeData))
            }
            
        }.resume()
    }
    
}




