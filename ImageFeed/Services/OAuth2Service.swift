//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Дмитрий Калько on 19.12.2023.
//

import Foundation

final class OAuth2Service {
    func fetchOAuthToken(code: String, completion: @escaping (Result<String, Error>) -> Void) {
        
        if let url = fetchUrl("https://unsplash.com/oauth/token", code: code) {
            
            var request  = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                
                
                if let error = error {
                    DispatchQueue.main.sync {
                        completion(.failure(error))
                    }
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    DispatchQueue.main.sync {
                        completion(.failure(NetworkError.urlSessionError))
                    }
                    return
                }
                
                if 200..<300 ~= httpResponse.statusCode {
                    if let data = data,
                       let jsonString = String(data: data, encoding: .utf8) {
                        do {
                            let authResponse = try JSONDecoder().decode(OAuthTokenResponseBody.self, from: Data(jsonString.utf8))
                            let accessToken = authResponse.accessToken
                            
                            DispatchQueue.main.sync {
                                completion(.success(accessToken))
                            }
                        } catch {
                            DispatchQueue.main.sync {
                                completion(.failure(error))
                            }
                        }
                    }
                } else {
                    DispatchQueue.main.sync {
                        completion(.failure(NetworkError.httpStatusCode(httpResponse.statusCode)))
                    }
                }
            }
            task.resume()
            
        }
    }
    
    private func fetchUrl(_ url: String, code: String) -> URL? {
        guard var urlComponents = URLComponents(string: url) else { return nil }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: ApiConstants.accessKey),
            URLQueryItem(name: "client_secret", value: ApiConstants.secretKey),
            URLQueryItem(name: "redirect_uri", value: ApiConstants.redirectURI),
            URLQueryItem(name: "code", value: code),
            URLQueryItem(name: "grant_type", value: "authorization_code")
        ]
        
        return urlComponents.url
    }
}
