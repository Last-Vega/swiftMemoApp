//
//  TagTableViewController.swift
//  memo2
//
//  Created by Ryota Sato on 2020/07/25.
//  Copyright © 2020 佐藤祐吾. All rights reserved.
//

import UIKit

private let unselectedRow = -1

class TagTableViewController: UITableViewController {
    
    var tagList = ["課題","買い物"]
    var addTag = ""
    var editRow: Int = unselectedRow
    
    @IBOutlet var tagListView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let defaults = UserDefaults.standard
        let loadedMemoList = defaults.object(forKey: "TAG_LIST")
        if (loadedMemoList as? [String] != nil) {
            tagList = loadedMemoList as! [String]
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("did appear")
        applyTag()
        presentingViewController?.endAppearanceTransition()
    }
    
    func applyTag() {
        if addTag == "" {
            return
        }
        
        if editRow == unselectedRow {
            tagList.append(addTag)
        } else {
            tagList[editRow] = addTag
        }
        
        let defaults = UserDefaults.standard
        defaults.set(tagList, forKey: "TAG_LIST")
        
        addTag = ""
        editRow = unselectedRow
        tagListView.reloadData()
    }
    
    @IBAction func tapCancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.tagList.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tagTableViewCell", for: indexPath)
        // Configure the cell...
        cell.textLabel?.text = self.tagList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            self.tagList.remove(at: indexPath.row)
            let defaults = UserDefaults.standard
            defaults.set(tagList, forKey: "TAG_LIST")
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
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
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let preVC = self.presentingViewController as! ViewController
        preVC.selectTag = self.tagList[indexPath.row]  //ここで値渡し
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
