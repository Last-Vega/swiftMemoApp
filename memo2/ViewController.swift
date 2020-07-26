
//
//  ViewController.swift
//  memo2
//
//  Created by 佐藤祐吾 on 2020/07/24.
//  Copyright © 2020 佐藤祐吾. All rights reserved.
//

import UIKit
private let unselectedRow = -1

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    @IBOutlet weak var editMemoField: UITextField!
    @IBOutlet weak var memoListView: UITableView!
    @IBOutlet weak var tagText: UITextField!
    @IBOutlet weak var reminderText: UITextField!
    @IBOutlet weak var label: UILabel!
    
    let gloVar = GlobalVar.shared
    var memoList: [String] = []
    var editRow: Int = unselectedRow
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        memoListView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        editMemoField.becomeFirstResponder()
        
        let defaults = UserDefaults.standard
        let loadedMemoList = defaults.object(forKey: "MEMO_LIST")
        if (loadedMemoList as? [String] != nil) {
            memoList = loadedMemoList as! [String]
        }
        self.tagText.text = gloVar.selectTag
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("did appear")
        self.tagText.text = gloVar.selectTag
        presentingViewController?.endAppearanceTransition()
    }
    
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            // Delete the row from the data source
            self.memoList.remove(at: indexPath.row)
            let defaults = UserDefaults.standard
            defaults.set(memoList, forKey: "MEMO_LIST")
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tapSubmitButton(_ sender: Any) {
        applyMemo()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memoList.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath as IndexPath)
        if indexPath.row >= memoList.count {
            return cell
        }
        cell.textLabel?.text = memoList[indexPath.row]
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row >= memoList.count {
            return
        }
        editRow = indexPath.row
        editMemoField.text = memoList[editRow]
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        applyMemo()
        return true
    }
    
    
    func applyMemo() {
        if editMemoField.text == nil {
            return
        }
        
        if editRow == unselectedRow {
            memoList.append(editMemoField.text!)
        } else {
            memoList[editRow] = editMemoField.text!
        }
        
        let defaults = UserDefaults.standard
        defaults.set(memoList, forKey: "MEMO_LIST")
        
        editMemoField.text = ""
        editRow = unselectedRow
        memoListView.reloadData()
    }
    
}
