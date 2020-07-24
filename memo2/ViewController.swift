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
    var memoList: [String] = []
    var editRow: Int = unselectedRow
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        memoListView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
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
           editMemoField.text = ""
           editRow = unselectedRow
           memoListView.reloadData()
       }
}

