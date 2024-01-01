//
//  OAuth2Service.swift
//  ImageFeed
//
//  Created by Дмитрий Калько on 19.12.2023.
//

import Foundation

final class OAuth2Service {
    func fetchOAuthToken(_ code: String, completion: @escaping (Result<String, Error>) -> Void) {
        
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
            })
            task.resume()
            
        }
    }
}

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
}

struct OAuthTokenResponseBody: Codable {
    let accessToken: String
    let tokenType: String
    let scope: String
    let createdAt: Int
    
    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
        case scope
        case createdAt = "created_at"
    }
}
