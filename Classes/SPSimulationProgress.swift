//
//  SPSimulationProgress.swift
//  SPSimulationProgress
//
//  Created by 高文立 on 2020/7/27.
//  Copyright © 2020 mouos. All rights reserved.
//

import UIKit

public protocol SPSimulationProgressDelegate: NSObjectProtocol {
    
    func didChangeValue(_ objc: AnyObject, _ value: Int)
    func didFinish(_ objc: AnyObject)
}

public extension SPSimulationProgressDelegate {
    func didChangeValue(_ objc: AnyObject, _ value: Int) {}
    func didFinish(_ objc: AnyObject) {}
}

public class SPSimulationProgress: NSObject, SPSimulationProgressDelegate, UITableViewDelegate {
    
    weak open var delegate: SPSimulationProgressDelegate?
    
    private var maxValue = 90
    private var limitValue = (min: 1, max: 5)
    private var isAuto = false
    private var progressDuration: CGFloat = 1
    
    private var progressTimer: Timer?
    private var finishLink: CADisplayLink?
    private var percent = 0
    private var isFinish = true
    
    public init(maxValue: Int = 90, limitValue: (Int, Int) = (1, 5), isAuto: Bool = false, progressDuration: CGFloat = 1) {
        super.init()
        
        self.maxValue = maxValue
        self.limitValue = limitValue
        self.isAuto = isAuto
        self.progressDuration = progressDuration
    }
    
    public func start() {
        guard isFinish else {
            return
        }
        isFinish = false
        progressTimer = Timer.scheduledTimer(timeInterval: TimeInterval(progressDuration), target: self, selector: #selector(progressTimerAction), userInfo: nil, repeats: true)
        RunLoop.current.add(progressTimer!, forMode: .common)
    }
    
    public func stop() {
        guard !isFinish else {
            return
        }
        finishLink?.invalidate()
        finishLink = CADisplayLink(target: self, selector: #selector(finishLinkAction))
        finishLink?.add(to: RunLoop.current, forMode: .default)
    }
}

extension SPSimulationProgress {
    
    @objc func progressTimerAction() {
        percent = currentPercent()
        delegate?.didChangeValue(self, percent)
        
        if isAuto {
            if percent >= 100 {
                progressTimer?.invalidate()
                finishLink?.invalidate()
                percent = 0
                delegate?.didFinish(self)
                isFinish = true
            }
        } else {
            if percent >= maxValue {
                progressTimer?.invalidate()
            }
        }
    }
    
    @objc func finishLinkAction() {
        
        if percent >= 100 {
            progressTimer?.invalidate()
            finishLink?.invalidate()
            percent = 0
            delegate?.didFinish(self)
            isFinish = true
        } else {
            percent = currentPercent()
            delegate?.didChangeValue(self, percent)
        }
    }
    
    private func currentPercent() -> Int {
        let value = arc4random_uniform(UInt32(limitValue.max - limitValue.min + 1)) + UInt32(limitValue.min)
        print("++ \(value)")
        percent += Int(value)
        return min(percent, 100)
    }
}
