//
//  TagCreateViewController.swift
//  memo2
//
//  Created by Ryota Sato on 2020/07/26.
//  Copyright © 2020 佐藤祐吾. All rights reserved.
//

import UIKit

class TagCreateViewController: UIViewController, UITextFieldDelegate {
    

    @IBOutlet weak var tagName: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("load")

        // Do any additional setup after loading the view.
        tagName.becomeFirstResponder()
    }

    
    @IBAction func tagCreateButton(segue: UIStoryboardSegue) {
        print("push")
        return
    }
    

    @IBAction func exitlove(_ sender: Any) {
        print("exit")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("return key")
        return true
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        print("prepare")
    }
    

}
