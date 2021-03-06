//
//  HttpUtils.swift
//  sampleapp
//
//  Created by Eduardo Raffi on 18/06/20.
//  Copyright © 2020 Eduardo Raffi. All rights reserved.
//

import Foundation
import UIKit

class HttpUtils {
    static let BASE_URL = "https://api.themoviedb.org/3/"
    static let FILTER_URL = "genre/movie/list?"
    static let GENRE_URL = "discover/movie?with_genres="
    static let SEARCH_URL = "search/movie?query="
    static let SIMILAR_URL1 = "movie/"
    static let SIMILAR_URL2 = "/similar?"
    static let API_KEY = "api_key=6e0acb8d22811c52cb7556da8d6aefdf"
    
    public static func requestTask<T: Decodable>(_ urlParams: String, completion: @escaping (_ json: T) -> Void){
        let session = URLSession.shared
        let url = URL(string: "\(BASE_URL)\(urlParams)\(API_KEY)")!
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            if error != nil {
                print(error)
                return
            }
            do {
                let json = try JSONDecoder().decode(T.self, from: data!)
                completion(json)
            } catch {
                print("Error during JSON serialization: \(error.localizedDescription)")
            }
        })
        task.resume()
    }
    
    public static func getUrlImage( _ path: inout String) -> UIImage{
        if !path.contains("/"){
            path = "/"+path
        }
        do{
            let imageUrl = URL(string: "http://image.tmdb.org/t/p/w780/\(path)")
            let data = try Data(contentsOf: imageUrl!)
            return UIImage(data: data)!
        } catch{
            return UIImage(named: "lionking")!
        }
    }
}
