//
//  Network Errors.swift
//  ImageFeed
//
//  Created by Дмитрий Калько on 06.01.2024.
//

import Foundation

enum NetworkError: Error {
    case httpStatusCode(Int)
    case urlRequestError(Error)
    case urlSessionError
}
