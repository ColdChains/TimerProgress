//
//  ViewController.swift
//  Test
//
//  Created by lax on 2018/12/29.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var progressView: UIView!
    
    @IBOutlet weak var progressViewWidth: NSLayoutConstraint!
    
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var progressLabel: UILabel!
    
    
    var timer: Timer!
    let width = UIScreen.main.bounds.size.width - 32
    
    var arrayTimer: Timer!
    var array: Array<Int> = [5, 3, 5]
//    var array: Array<Int> = [3, 5, 2, 3, 5]
    var flag = 0
    var index = 0
    var step: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(width)
        var count = 0
        for i in 0..<array.count {
            if i % 2 == 0 {
                count += array[i]
            }
        }
        step = width / CGFloat(count * 100)
        print(count, step)
        createArrayTimer()
    }
    
    func createArrayTimer() {
        flag = array[index]
        timeLabel.text = "\(flag)"
        arrayTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.arrTimerAction), userInfo: nil, repeats: true)
        if index % 2 == 0 && timer == nil {
            createTimer()
        }
        if index % 2 == 1 {
            stopTimer()
        }
    }
    
    func stopArrayTimer() {
        if arrayTimer != nil {
            arrayTimer.invalidate()
            arrayTimer = nil
        }
    }
    
    @objc func arrTimerAction() {
        if flag > 1 {
            flag -= 1
            timeLabel.text = "\(flag)"
        } else {
            stopArrayTimer()
            if index < array.count - 1 {
                index += 1
                createArrayTimer()
            } else {
                stopTimer()
                timeLabel.text = "0"                
                progressLabel.text = "100%"
                startButton.setTitle("开始", for: .normal)
                startButton.isSelected = false
            }
        }
        print(flag)
    }
    
    func createTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.timerAction), userInfo: nil, repeats: true)
    }
    
    func stopTimer() {
        if timer != nil {
            timer.invalidate()
            timer = nil
        }
    }
    
    @objc func timerAction() {
        progressViewWidth.constant += step
        progressLabel.text = "\(Int(progressViewWidth.constant * 100 / width))%"
        print(progressViewWidth.constant)
        if progressViewWidth.constant >= width {
            stopTimer()
        }
    }

    @IBAction func stopButtonAction(_ sender: UIButton) {
        if sender.isSelected {
            stopTimer()
            sender.setTitle("开始", for: .normal)
        } else {
            sender.setTitle("暂停", for: .normal)
//            createTimer()
            createArrayTimer()
        }
        sender.isSelected = !sender.isSelected
    }
    
    @IBAction func resetButtonAction(_ sender: UIButton) {
        stopTimer()
        progressViewWidth.constant = 0
        progressLabel.text = "0%"
        timeLabel.text = "0"
        startButton.setTitle("开始", for: .normal)
        startButton.isSelected = false
        index = 0
        flag = 0
    }
    
}

