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

        // Do any additional setup after loading the view.
        tagName.delegate = self
        tagName.becomeFirstResponder()
    }
    


    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print("return key")
        let preNC = self.navigationController
        let preVC = preNC!.viewControllers[preNC!.viewControllers.count - 2] as! TagTableViewController
        preVC.addTag = self.tagName.text ?? ""

        self.navigationController?.popViewController(animated: true)
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
