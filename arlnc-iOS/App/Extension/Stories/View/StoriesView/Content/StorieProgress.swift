//
//  StorieProgress.swift
//  arlnc-iOS
//

import UIKit

class StorieProgress: UIProgressView {
    
    private var timer: Timer?
    private var totalTime: TimeInterval = 10
    private var elapsedTime: TimeInterval = 0
    private var isPaused = false
    private var isFinished = false
    
    convenience init(index: Int) {
        self.init()
        self.tag = index
        self.progressTintColor = UIColor.white.withAlphaComponent(0.8)
        self.trackTintColor = UIColor.white.withAlphaComponent(0.2)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 4
        layer.masksToBounds = true
        progressViewStyle = .bar
        progress = 0.00
    }
    
    func startProgress() {
        resetProgress()
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }
    
    func pauseProgress() {
        isPaused = true
        timer?.invalidate()
    }
    
    func resumeProgress() {
        isPaused = false
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateProgress), userInfo: nil, repeats: true)
    }
    
    func finishProgress() {
        timer?.invalidate()
        setProgress(1.0, animated: false)
        isFinished = true
        NotificationCenter.default.post(name: NSNotification.Name("storie.process.finished"), object: nil, userInfo: ["index": tag])
    }
    
    @objc
    private func updateProgress() {
        if !isPaused {
            elapsedTime += 0.1
            let progress = Float(elapsedTime / totalTime)
            setProgress(progress, animated: false)
            if elapsedTime >= totalTime {
                finishProgress()
            }
        }
    }
    
    func resetProgress() {
        timer?.invalidate()
        setProgress(0.0, animated: false)
        elapsedTime = 0
        isPaused = false
        isFinished = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

protocol StorieProgressDelegate: AnyObject {
    func progressWasFinished(story: Int)
}
