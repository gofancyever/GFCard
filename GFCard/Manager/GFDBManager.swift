//
//  GFDBManager.swift
//  GFCard
//
//  Created by gaof on 2018/11/23.
//  Copyright © 2018 gaof. All rights reserved.
//

import UIKit
import SQLite
class GFDBManager: NSObject {
    
    private let id = Expression<Int>("id")
    
    /// library
    private let word = Expression<String>("word")
    private let phonetic_uk = Expression<String?>("phonetic_uk")
    private let phonetic_us = Expression<String?>("phonetic_us")
    private let translation = Expression<String>("translation")
    private let note = Expression<String?>("note")
    
    
//    private let library_name = Expression<String?>("library_name")
//    private let user_brain = Table("user_brain")

//    private let user_id = Expression<String?>("user_id")
//    private let library_id = Expression<String?>("library_id")
//
//    private let card_id = Expression<String?>("card_id")
//    private let easiness = Expression<Double?>("easiness")
//    private let interval = Expression<Int?>("interval")
//    private let repetitions = Expression<String?>("repetitions")
//    private let note = Expression<String?>("note")
//
//
//    private let fronts = Expression<String?>("fronts")
//    private let backs = Expression<String?>("backs")
//    private let alerts = Expression<String?>("alerts")
//
//    private let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
    
    var path:String!
    private lazy var db:Connection? = {
        if let db = try? Connection("\(path!)/library.sqlite3") {
            return db
        }else{
            return nil
        }
    }()
    
    /// 删除指定表
    ///
    /// - Parameter name: 表名
    public func delTable(name:String) {
        let table = Table(name)
        if let db = self.db {
            _  = try? db.run(table.delete())
        }
    }
    public func getWordData() -> [Word] {
        var words:[Word] = [Word]()
        let table = Table("word")
        guard let db = self.db else { return words }
        for word in try! db.prepare(table) {
            let id = word[self.id]
            let word_str = word[self.word]
            let phonetic_uk = word[self.phonetic_uk]
            let phonetic_us = word[self.phonetic_us]
            let translation = word[self.translation]
            let note = word[self.translation]
            let word_model = Word.init(id:id,word: word_str, phonetic_uk: phonetic_uk, phonetic_us: phonetic_us, translation: translation, note: note)
            words.append(word_model)
        }
        return words
    }
//    public func getBrainCards(libraryName:String) -> [BrainCard] {
//        var cards:[BrainCard] = [BrainCard]()
//        let table = Table(libraryName)
//        guard let db = self.db else { return cards }
//        for card in try! db.prepare(table) {
//            print(card)
//            let id = card[self.id]
//            let libraryName = card[library_name]
//
//            let backs = card[self.backs]
//            let bronts = card[fronts]
//            let alerts = card[self.alerts]
//
//            let back_models = JSON(parseJSON: backs!).arrayValue.map({BrainCardInfo(fromJson: $0)})
//            let front_models = JSON(parseJSON: bronts!).arrayValue.map({BrainCardInfo(fromJson: $0)})
//
//            var card = BrainCard(libraryName: libraryName!, back: back_models, fronts: front_models)
//            card.id = "\(id)"
//            cards.append(card)
//
//        }
//        return cards
//    }
//    public func getBrainInfo(library:String,id:String) -> BrainInfo? {
//        let table = Table(library)
//        let filter_table = table.filter(card_id == id)
//        guard let db = self.db else { return nil }
//        for brain in try! db.prepare(filter_table) {
//            print(brain)
//        }
//
//        /// 如果无此记录信息创建保存
//        let brainInfo = BrainInfo(id: id, library_id:library, user_id:"test", easiness: 2.5, interval: 0, repetitions: 0)
//        saveBrainInfo(brainInfo: brainInfo)
//        return brainInfo
//    }
//    public func saveBrainInfo(brainInfo:BrainInfo) {
//        let table = Table(brainInfo.library_id)
//        guard let db = self.db else { return }
//        let insert = table.insert(
//            card_id <- brainInfo.id,
//            library_id <- brainInfo.library_id,
//            easiness <- brainInfo.easiness,
//            interval <- brainInfo.interval,
//            repetitions <- brainInfo.repetitions
//        )
//        try? db.run(insert)
//    }
//
//    public func saveCard(card:BrainCard) {
//        let table = Table("test_card")
//        print(card.fronts)
//        print(card.backs)
//        if let db = self.db {
//            //建表
//            createCardTable(db: db, name: card.library_id!)
//            let insert = table.insert(
//                user_id <- "test",
//                library_id <- card.library_id,
//                library_name <- card.library_name,
//                fronts <- card.fronts,
//                backs <- card.backs,
//                alerts <- card.alerts
//            )
//            let rowid = try? db.run(insert)
//            print(rowid)
//        }
//    }
    
//    private func createCardTable(db:Connection,name:String) {
//        let table = Table(name)
//        do {
//            _ = try? db.run(table.create(ifNotExists:true, block: { (t) in
//                t.column(id, primaryKey: true)
//                t.column(user_id)
//                t.column(library_id)
//                t.column(library_name)
//                t.column(fronts)
//                t.column(backs)
//                t.column(alerts)
//                print("创建表 \(name) 成功")
//            }))
//        } catch let error  {
//            print(error)
//            print("创建表 \(name) 失败")
//        }
//    }
//    private func createBrainTable(db:Connection) {
//        let user_brain = Table("user_brain")
//        do {
//            _ = try? db.run(user_brain.create(ifNotExists:true, block: { (t) in
//                t.column(id, primaryKey: true)
//                t.column(user_id)
//                t.column(library_id)
//                t.column(library_name)
//                t.column(card_id)
//                t.column(easiness)
//                t.column(interval)
//                t.column(repetitions)
//                print("创建表 user_brain 成功")
//            }))
//        } catch let error  {
//            print(error)
//            print("创建表 user_brain 失败")
//        }
//
//    }
}
