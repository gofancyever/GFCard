//
//  CardNet.swift
//  GFCard
//
//  Created by gaof on 2018/11/23.
//  Copyright © 2018 gaof. All rights reserved.
//

import UIKit
import Moya
import Alamofire
let cardApi = MoyaProvider<CardService>()

enum CardService {
    case post(suffixUrl:String, params:[String:Any])
    case download(suffixUrl:String, params:[String:Any],toPath:String)
}
extension CardService:TargetType {
    var baseURL: URL {
        return URL(string:"http://127.0.0.1:5000/")!
    }
    
    var path: String {
        switch self {
        case .post(suffixUrl: let suffixUrl, params: _):
            return suffixUrl
        case .download(suffixUrl: let suffixUrl, params: _,toPath:_):
            return suffixUrl
        default:
            return ""
        }
    }
    
    var method: Alamofire.HTTPMethod {
        return .post
    }
    
    var sampleData: Data {
        return "".data(using: .utf8)!
    }
    
    var task: Task {
        var params:[String:Any] = [String:Any]()
        switch self {
        case let .post(_,paramsData):
            for e in paramsData {
                params[e.key] = e.value
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case let .download(_,paramsData,path):
            let defaultDownloadDestination: DownloadDestination = { temporaryURL, response in
                return (URL(fileURLWithPath: path),[])
            }
            return .downloadParameters(parameters: paramsData, encoding: URLEncoding.default, destination: defaultDownloadDestination)
        default:
            return .requestPlain
        }
        
    }
    
    var headers: [String : String]? {
        return ["Content-type": "application/json"]
    }
    
    
}
class CardNet: NSObject {

}
