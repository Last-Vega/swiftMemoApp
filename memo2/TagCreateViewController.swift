//
//  TagCreateViewController.swift
//  memo2
//
//  Created by Ryota Sato on 2020/07/26.
//  Copyright © 2020 佐藤祐吾. All rights reserved.
//

import UIKit

import Speech
import AVFoundation


class TagCreateViewController: UIViewController, UITextFieldDelegate {

    let recognizer = SFSpeechRecognizer(locale: Locale.init(identifier: "ja_JP"))!
    var audioEngine: AVAudioEngine!
    var recognitionReq: SFSpeechAudioBufferRecognitionRequest?
    var recognitionTask: SFSpeechRecognitionTask?

    @IBOutlet weak var tagNameField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tagNameField.delegate = self
        tagNameField.becomeFirstResponder()
        
        audioEngine = AVAudioEngine()
    }
  
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //print("did appear")
        tagNameField.becomeFirstResponder()
        
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
        tagNameField.text = ""
        
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
                    self.tagNameField.text = result?.bestTranscription.formattedString
                }
            }
        })
    }
    
    @IBAction func recordButtonTapped(_ sender: Any) {
        //print("stop")
        stopLiveTranscription()
    }
    
    
    @IBAction func recordButtonStart(_ sender: Any) {
        //print("start")
        try! startLiveTranscription()
    }
    
    
    @IBAction func tapCreateButton(_ sender: Any) {
        let _ = textFieldShouldReturn(tagNameField)
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //print("return key")
        let preNC = self.navigationController
        let preVC = preNC!.viewControllers[preNC!.viewControllers.count - 2] as! TagTableViewController
        preVC.addTag = self.tagNameField.text ?? ""

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
