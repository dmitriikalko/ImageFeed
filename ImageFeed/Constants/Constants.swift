//
//  Constants.swift
//  ImageFeed
//
//  Created by Дмитрий Калько on 02.12.2023.
//

import Foundation

enum ApiConstants {
    static let accessKey = "rgpPasAneWEWBeLevX42Ud1nSyALb_dQrCLADxO1lzY"
    static let secretKey = "7uUYDEKJPEg0zDD54PQ_jioF3oMumr0QCh8ZLrHaDYY"
    static let redirectURI = "urn:ietf:wg:oauth:2.0:oob"
    static let accessScope = "public+read_user+write_likes"
    static let defaultBaseURL = URL(string: "https://api.unsplash.com/")!
}
