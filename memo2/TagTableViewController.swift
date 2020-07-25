//
//  TagTableViewController.swift
//  memo2
//
//  Created by Ryota Sato on 2020/07/25.
//  Copyright © 2020 佐藤祐吾. All rights reserved.
//

import UIKit

class TagTableViewController: UITableViewController {
    
    var tags = ["課題","買い物"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tags.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tagTableViewCell", for: indexPath)
        
        // Configure the cell...
        cell.textLabel?.text = self.tags[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let tagVC =  ViewController()
        //tagVC.selectTag = self.tags[(self.tableView.indexPathForSelectedRow?.row)!] as! String
        //tagVC.selectTag = self.tags[(self.tableView.indexPathForSelectedRow?.row)!]
        tagVC.selectTag = self.tags[indexPath.row]
        print(tagVC.selectTag)
        // セルの選択を解除
        tableView.deselectRow(at: indexPath, animated: true)
        
        // 別の画面に遷移
        guard let parent = storyboard?.instantiateViewController(withIdentifier: "parentViewController") as? ViewController else {
            fatalError()
        }
        parent.refresh(self.tags[indexPath.row])
        self.dismiss(animated: true, completion: nil)
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.tags.remove(at: indexPath.row)    //ここに記述
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        print("きちゃった")
    //        // Get the new view controller using segue.destination.
    //        // Pass the selected object to the new view controller.
    //        guard let identifier = segue.identifier else {
    //            return
    //        }
    //        if identifier == "setTag" {
    //            print("きたよ")
    //            let tagVC = segue.destination as! ViewController
    //            tagVC.selectTag = self.tags[(self.tableView.indexPathForSelectedRow?.row)!]
    //        }
    //    }
    //
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
