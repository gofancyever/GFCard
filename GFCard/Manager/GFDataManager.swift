//
//  GFDataManager.swift
//  GFCard
//
//  Created by gaof on 2018/11/14.
//  Copyright © 2018 gaof. All rights reserved.
//

import UIKit
import SwiftyJSON
import Result
import Moya
enum FilePathError: Error {
    case noSearchFile
}

class GFDataManager: NSObject {
    
    static let shared = GFDataManager()
    private override init() {}
    
    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    
    private func pathWithLibrary(fileName:String) -> Result<String,FilePathError> {
        let path = "\(self.path!)/\(fileName).db"
        if FileManager.default.fileExists(atPath: path) {
            return .success(path)
        }
        return .failure(.noSearchFile)
    }
    
    /// 请求词库
    ///
    /// - Parameter libraryID: 词库ID
    func downloadLibrary(id:String,downloadResult:@escaping (Result<String,MoyaError>) -> ()) {
        let path = "\(self.path!)/\(id).db"
        cardApi.request(.download(suffixUrl: "library", params: ["user_id":"test","library_id":id], toPath: path)) { (result) in
            switch result {
            case .success(_):
                downloadResult(.success(path))
            case let .failure(error):
                downloadResult(.failure(error))
            }
        }
    }
    
    /// 获取词库下单词
    ///
    /// - Parameters:
    ///   - page: 页面 1 为起始页
    ///   - limit: 每页数据长度
    /// - Returns: 单词 无为空数组
    func getWord(libraryID:String,page:Int,limit:Int){
        let pathStatus = pathWithLibrary(fileName: libraryID)
        switch pathStatus {
        case let .success(pathStatus):
            print(pathStatus)
        case let .failure(error):
            if error == .noSearchFile {//本地无文件 从服务器上获取
                downloadLibrary(id: libraryID) { (result) in
                    switch result {
                    case let .success(path):
                        break
                    case let .failure(error):
                        print(error)
                    }
                }
            }
        default: break
            
        }
    }
    
    
    /// 创建新词库
    ///
    /// - Parameter name: 词库名称
    func createNewLibrary(name:String) {
//        请求添加词库接口 返回词典信息
//          请求 requestDB 接口 缓存
    }
}

