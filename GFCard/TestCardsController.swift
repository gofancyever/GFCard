//
//  TestCardsController.swift
//  GFCard
//
//  Created by gaof on 2018/11/15.
//  Copyright © 2018 gaof. All rights reserved.
//

import UIKit

class TestCardsController: UITableViewController {
//    var dataSource:[BrainCard] = [BrainCard]()
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.tableView.tableFooterView = UIView()
////        self.dataSource = GFDataManager.shared.getBrainCards(libraryName: "test_card")
//        self.tableView.reloadData()
//    }
//
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.dataSource.count
//    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let info = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TestBrainInfoController") as! TestBrainInfoController
//        let model = self.dataSource[indexPath.row]
//        info.id = model.id
//        self.navigationController?.pushViewController(info, animated: true)
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        var cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier")
//        if cell == nil {
//            cell = UITableViewCell(style: .default, reuseIdentifier: "reuseIdentifier")
//        }
//        let model = self.dataSource[indexPath.row]
//        cell!.textLabel?.text = model.front.first?.content
//        return cell!
//    }
//    
//
//    /*
//    // Override to support conditional editing of the table view.
//    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
//    */
//
//    /*
//    // Override to support editing the table view.
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }    
//    }
//    */
//
//    /*
//    // Override to support rearranging the table view.
//    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
//
//    }
//    */
//
//    /*
//    // Override to support conditional rearranging of the table view.
//    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
//        // Return false if you do not want the item to be re-orderable.
//        return true
//    }
//    */
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destination.
//        // Pass the selected object to the new view controller.
//    }
//    */

}
