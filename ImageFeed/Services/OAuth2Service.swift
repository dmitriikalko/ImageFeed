//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Дмитрий Калько on 19.12.2023.
//

import Foundation

final class OAuth2Service {
    func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        //completion(.success("")) //TODO     10S
        
        var urlComponents = URLComponents(string: "https://unsplash.com/oauth/token")
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: AccessKey),  
            URLQueryItem(name: "client_secret", value: SecretKey),
            URLQueryItem(name: "redirect_uri", value: RedirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grand_type", value: "authorization_code")
        ]
        
        if let url = urlComponents?.url{
            var request  = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let task = URLSession.shared.dataTask(with: request,completionHandler: { data, response, error in
                completion(.success(""))
                //completion(.failure(error))
                })
            task.resume()
            
        }
    }
}
