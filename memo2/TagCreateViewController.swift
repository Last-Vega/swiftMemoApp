//
//  TagCreateViewController.swift
//  memo2
//
//  Created by Ryota Sato on 2020/07/26.
//  Copyright © 2020 佐藤祐吾. All rights reserved.
//

import UIKit

class TagCreateViewController: UIViewController {

    @IBOutlet weak var tagName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func tagCreateButton(segue: UIStoryboardSegue) {
        
    }
    
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        return true
//    }
//
//    func applyMemo() {
//           if tagName.text == nil {
//               return
//           }
           
//           if editRow == unselectedRow {
//               memoList.append(editMemoField.text!)
//           } else {
//               memoList[editRow] = editMemoField.text!
//           }
           
//           let defaults = UserDefaults.standard
//           defaults.set(memoList, forKey: "MEMO_LIST")
//           
//           editMemoField.text = ""
//           editRow = unselectedRow
//           memoListView.reloadData()
//       }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
