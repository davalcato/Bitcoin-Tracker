//
//  APICaller.swift
//  Bitcoin
//
//  Created by Daval Cato on 6/30/21.
//

import Foundation

// Define class
final class APICaller {
    static let shared = APICaller()
    init() {}
        
        // Constants
        struct Constants {
            static let apikey = "8bccdb3f-7970-4cd0-8896-96e7500a02cd"
            static let apikeyHeader = "X-CMC_PRO_API_KEY"
            static let baseUrl = "https://pro-api.coinmarketcap.com/v1/"
            static let doge = "dogecoin"
            static let endpoint = "cryptocurrency/quotes/latest"
    }
    // Failed to URL
    enum APIError: Error {
        // Customer case
        case invalidUrl
        
    }
    
    // Function get dogecoin data
    public func getDogeCoinData(completion: @escaping (Result<DogeCoinData, Error>) -> Void
    
    ) {
        // Perform the APICall here
        guard let url = URL(string: Constants.baseUrl + Constants.endpoint + "?slug=" + Constants.doge) else {
            // show user what went wrong
            completion(.failure(APIError.invalidUrl))
            
            // Not able to create then return
            return
        }
        // Print out URL for dogecoin only
        print("\n\n API URL: \(url.absoluteString) \n\n")
        
        // Create a request
        var request = URLRequest(url: url)
        // Set information here
        request.setValue(Constants.apikey, forHTTPHeaderField: Constants.apikeyHeader)
        // Method
        request.httpMethod = "GET"
        
        // Perform task
        let task = URLSession.shared.dataTask(
            with: request) { data, _, error in
            // if error fail pass error to caller
            if let error = error {
                completion(.failure(error))
                return
            }
            // If that doesn't occur
            guard let data = data else {
                return
            }
            // Convert data to object
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
                print("\n\n \(json)")
                
                let response = try JSONDecoder().decode(APIResponse.self, from: data)
                
                // print response
                print("\n\n API Result: \(response) \n\n")
                
                // Get value out of didctionary
                guard let dogeCoinData = response.data.values.first else {
                    return
                    
                }
                        
                // if able to do this
                completion(.success(dogeCoinData))
            }
            catch {
                // otherwise
                completion(.failure(error))
                
            }
        }
        task.resume()
    }
}
