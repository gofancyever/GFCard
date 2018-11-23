//
//  ViewController.swift
//  GFCard
//
//  Created by gaof on 2018/10/24.
//  Copyright © 2018 gaof. All rights reserved.
//

import UIKit
import CollectionKit
import UserNotifications

class ViewController: UIViewController {
    var collectionView:CollectionView = CollectionView()
    let notiHandle =  NotificationHandler()
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.view.addSubview(self.collectionView)
        self.collectionView.frame = self.view.bounds
        let dataSource = ArrayDataSource(data: [1, 2, 3, 4])
        let viewSource = ClosureViewSource(viewUpdater: { (view: UILabel, data: Int, index: Int) in
            view.backgroundColor = .red
            view.text = "\(data)"
        })
        let sizeSource = { (index: Int, data: Int, collectionSize: CGSize) -> CGSize in
            return CGSize(width: 50, height: 50)
        }
        let provider = BasicProvider(
            dataSource: dataSource,
            viewSource: viewSource,
            sizeSource: sizeSource
        )
        
        //lastly assign this provider to the collectionView to display the content
        collectionView.provider = provider
    }

    @IBAction func getLibFromService(_ sender: UIButton) {
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        notiHandle.sendCardNoti(title: "测试", body: nil)
    }
}

