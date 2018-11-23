//
//  CardBuilderView.swift
//  GFCard
//
//  Created by gaof on 2018/10/24.
//  Copyright © 2018 gaof. All rights reserved.
//

import UIKit

let cardImagePath = "card";

class CardBuilderView: UIView {

    var contentLabel: UILabel!
    var content:String?
    var name:String?
    var path:URL? {
        get {
            return self.getImagePath()
        }
    }
    func getImagePath() -> URL? {
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last, let name = self.name else { return nil }
        let imagePath = "\(path)/\(cardImagePath)/\(name).png"
        if FileManager.default.fileExists(atPath: imagePath) {
            let path_url = URL(fileURLWithPath: imagePath)
            return path_url
        }else{
            return saveImage()
        }
    }
    static func loadBuilder() -> CardBuilderView {
        let width = UIApplication.shared.keyWindow?.frame.size.width ?? 320
        return CardBuilderView(frame: CGRect(x: 0, y: 0, width: width, height: width))
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.contentLabel = UILabel(frame: frame)
        self.contentLabel.textAlignment = .center
        self.contentLabel.text = "aaaaaaa"
        self.addSubview(self.contentLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func saveImage() -> URL? {
        UIGraphicsBeginImageContextWithOptions(self.frame.size, false, 0.0)
        
        guard let context = UIGraphicsGetCurrentContext() else {
            return nil
        }
        self.layer.render(in: context)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        
        guard let path = NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).last,let name = self.name else { return nil }
        let imagePath = "\(path)/\(cardImagePath)/\(name).png"
        
        let myDirectory:String = "\(path)/\(cardImagePath)"
        let fileManager = FileManager.default
        //withIntermediateDirectories为ture表示路径中间如果有不存在的文件夹都会创建
        try! fileManager.createDirectory(atPath: myDirectory,
                                         withIntermediateDirectories: true, attributes: nil)
        
        guard let data = image?.pngData() else { return nil }
        do {
            let path_url = URL(fileURLWithPath: imagePath)
            try data.write(to: path_url)
            return path_url
        }catch let error {
            print(error)
            return nil
        }
    }
    
}
