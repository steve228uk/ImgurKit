//
//  API.swift
//  Peach
//
//  Created by Stephen Radford on 24/01/2016.
//  Copyright © 2016 Cocoon Development Ltd. All rights reserved.
//

import Alamofire

enum API: URLRequestConvertible {
    
    case Upload(NSData)
    
    // MARK: - URLRequestConveritble
    
    static let base = "https://api.imgur.com/3"
    
    var method: Alamofire.Method {
        switch self {
        case .Upload:
            return .POST
        default:
            return .GET
        }
    }
    
    var path: String {
        switch self {
        case .Upload:
            return "/image"
        }
    }
    
    var URLRequest: NSMutableURLRequest {
        
        let URL = NSURL(string: API.base)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        if let token = Imgur.clientID {
            mutableURLRequest.setValue("Client-ID \(token)", forHTTPHeaderField: "Authorization")
        }
        
        switch self {
        case .Upload(let data):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: ["image": data.base64EncodedStringWithOptions([])]).0
        default:
            return mutableURLRequest
        }
        
    }
    
    
}