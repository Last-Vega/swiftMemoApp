
//
//  ViewController.swift
//  memo2
//
//  Created by 佐藤祐吾 on 2020/07/24.
//  Copyright © 2020 佐藤祐吾. All rights reserved.
//

import UIKit
import Speech
import AVFoundation

private let unselectedRow = -1

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    
    @IBOutlet weak var editMemoField: UITextField!
    @IBOutlet weak var memoListView: UITableView!
    @IBOutlet weak var tagText: UITextField!
    @IBOutlet weak var reminderText: UITextField!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    
    var isRecording = false
    let recognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ja_JP"))!
    var audioEngine: AVAudioEngine!
    var recognitionReq: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?
    
    var selectTag = "なし"
    var memoList: [String] = []
    var editRow: Int = unselectedRow
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        audioEngine = AVAudioEngine()
       
        
        memoListView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        editMemoField.becomeFirstResponder()
        
        let defaults = UserDefaults.standard
        let loadedMemoList = defaults.object(forKey: "MEMO_LIST")
        if (loadedMemoList as? [String] != nil) {
            memoList = loadedMemoList as! [String]
        }
        self.tagText.text = self.selectTag
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("did appear")
        self.tagText.text = self.selectTag
        presentingViewController?.endAppearanceTransition()
        
//        initRoundCorners()
//        showStartButton()

        SFSpeechRecognizer.requestAuthorization { (authStatus) in
            DispatchQueue.main.async {
                if authStatus != SFSpeechRecognizerAuthorizationStatus.authorized {
                self.recordButton.isEnabled = false
                self.recordButton.backgroundColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                }
            }
        }
    }
    
    
    
    func stopLiveTranscription() {
       audioEngine.stop()
       audioEngine.inputNode.removeTap(onBus: 0)
       recognitionReq?.endAudio()
     }
    
    func startLiveTranscription() throws {

       // もし前回の音声認識タスクが実行中ならキャンセル
       if let recognitionTask = self.recognitionTask {
         recognitionTask.cancel()
         self.recognitionTask = nil
       }
       editMemoField.text = ""

       // 音声認識リクエストの作成
       recognitionReq = SFSpeechAudioBufferRecognitionRequest()
       guard let recognitionReq = recognitionReq else {
         return
       }
       recognitionReq.shouldReportPartialResults = true

       // オーディオセッションの設定
       let audioSession = AVAudioSession.sharedInstance()
       try audioSession.setCategory(.record, mode: .measurement, options: .duckOthers)
       try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
       let inputNode = audioEngine.inputNode

       // マイク入力の設定
       let recordingFormat = inputNode.outputFormat(forBus: 0)
       inputNode.installTap(onBus: 0, bufferSize: 2048, format: recordingFormat) { (buffer, time) in
         recognitionReq.append(buffer)
       }
       audioEngine.prepare()
       try audioEngine.start()

       recognitionTask = recognizer.recognitionTask(with: recognitionReq, resultHandler: { (result, error) in
         if let error = error {
           print("\(error)")
         } else {
           DispatchQueue.main.async {
             self.editMemoField.text = result?.bestTranscription.formattedString
           }
         }
       })
     }
    
    
    @IBAction func recordButtonTapped(_ sender: Any) {
        print("Tapped")
        if isRecording {
            print("stop")
//          UIView.animate(withDuration: 0.2) {
//            self.showStartButton()
//          }
          stopLiveTranscription()
        } else {
            print("start")
//          UIView.animate(withDuration: 0.2) {
//            self.showStopButton()
//          }
          try! startLiveTranscription()
        }
        isRecording = !isRecording
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
