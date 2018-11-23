//
//  GFBrainManager.swift
//  GFCard
//
//  Created by gaof on 2018/11/14.
//  Copyright © 2018 gaof. All rights reserved.
//

import UIKit
import SwiftyJSON
import SQLite

struct Word {
    let id:Int
    let word:String
    let phonetic_uk:String?
    let phonetic_us:String?
    let translation:String
    let note:String?
}
enum BrainCardInfoType:Int {
    case text = 1
    case voice
    case url
    case title
}
enum BrainEasinessRange:Double {
    case max = 2.5
    case min = 1.3
}

struct BrainCardInfo {

    var content:String!
    var type:BrainCardInfoType!
    
    init(content:String,type:BrainCardInfoType) {
        self.init(fromJson: nil)
        self.content = content
        self.type = type
    }
    init(fromJson json: JSON!){
        if json == nil {
            return
        }
        if json.isEmpty{
            return
        }
        content = json["content"].stringValue
        type = BrainCardInfoType(rawValue: json["type"].intValue)
    }
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if content != nil{
            dictionary["content"] = content
        }
        if type != nil{
            dictionary["type"] = type.rawValue
        }
        return dictionary
    }
    

}
struct BrainCard {
    var id:String?
    var library_name:String
    var library_id:String? {
        get {
            return "test_card"
        }
    }
    var front:[BrainCardInfo]
    var back:[BrainCardInfo]
    var alert:[BrainCardInfo]?
    var fronts:String? {
        get {
            let paramsArray = front.map({$0.toDictionary()})
            let jsonData = try! JSONSerialization.data(withJSONObject: paramsArray, options: [])
            let decoded = String(data: jsonData, encoding: .utf8)
            return decoded
        }
        set {
            let json = JSON(parseJSON: fronts!).arrayValue
            front = json.map({BrainCardInfo(fromJson: $0)})
        }
    }
    var backs:String? {
        get {
            let paramsArray = back.map({$0.toDictionary()})
            
            let jsonData = try! JSONSerialization.data(withJSONObject: paramsArray, options: [])
            let decoded = String(data: jsonData, encoding: .utf8)
            return decoded
        }
        set {
            let json = JSON(parseJSON: backs!).arrayValue
            back = json.map({BrainCardInfo(fromJson: $0)})
        }
    }
    var alerts:String? {
        get {
            guard let alert = alert else {
                return nil
            }
            let paramsArray = alert.map({$0.toDictionary()})
            let paramsJSON = JSON(paramsArray)
            let paramsString = paramsJSON.rawString(.utf8)
            return paramsString
        }
        set {
            let json = JSON(parseJSON: alerts!).arrayValue
            back = json.map({BrainCardInfo(fromJson: $0)})
        }
    }
    init(libraryName:String,back:[BrainCardInfo],fronts:[BrainCardInfo]) {

        self.library_name = libraryName
        self.back = back
        self.front = fronts
    }
}
struct BrainInfo {
    let id:String
    let library_id:String
    let user_id:String
    let easiness:Double
    let interval:Int
    let repetitions:Int
}

//class GFBrainManager: NSObject {
//    
//    func calculateSM(card:BrainCard,quality:Double) -> Int{
//        if quality < 0 || quality > 5 {
//            return 0
//        }
////        guard let brainInfo = GFDataManager.shared.getBrainInfo(library: card.library_id!, id: card.id!) else { return 0 }
//        
//        var easiness = brainInfo.easiness
//        var interval = brainInfo.interval
//        var repetitions = brainInfo.repetitions
//        
//        easiness = max(BrainEasinessRange.min.rawValue, easiness + 0.1 - (5.0 - quality) * (0.08 + (5.0 - quality) * 0.02 ))
//        if quality < 3 {
//            repetitions = 0
//        }else{
//            repetitions += 1
//        }
//        if repetitions <= 1 {
//            interval = 1
//        }else if repetitions == 2 {
//            interval = 6
//        }else{
//            interval = lroundf(Float(interval) * Float(easiness))
//        }
//        return interval
//    }
//}
