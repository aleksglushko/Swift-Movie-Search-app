//
//  movieDataProcess.swift
//  Movie Category Search
//
//  Created by Aleksandr Glushko on 08.09.19.
//  Copyright © 2019 tardis. All rights reserved.
//

import Foundation

let apiKey = "d372b5fd608c81066dbd0892b2faeb35"
let url = NSURL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)")

let request = NSURLRequest(
    url: url! as URL,
    cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringLocalCacheData,
    timeoutInterval: 10)

let session = URLSession(
    configuration: URLSessionConfiguration.default,
    delegate: nil,
    delegateQueue: OperationQueue.main
)

let task: URLSessionDataTask = session.dataTask(
    with: request as URLRequest, completionHandler: {
        (dataOrNil, response, error) in
        if let data = dataOrNil {
            if let responseDictionary = try! JSONSerialization.jsonObject(
                with: data, options: []) as? NSDictionary {
                print("response: \(responseDictionary)")
            }
        }
    }
)
task.resume()

