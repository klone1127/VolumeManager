//
//  KPopoverViewController.swift
//  SoundManager
//
//  Created by CF on 2017/6/14.
//  Copyright © 2017年 klone. All rights reserved.
//

import Cocoa

let border: CGFloat = 2.0
let denominator: CGFloat = 100.0

class KPopoverViewController: NSViewController {
    
    var progrssView: NSView!
    var container: NSView!
    var defaultVolume: CGFloat = CGFloat(NSSound.systemVolume()) * denominator
    var timer: Timer!
    var volumeText: NSTextField!
    
    @IBOutlet weak var touchButton: NSButton!
    var volumeValue: CGFloat!       // 默认值为当前音量
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.volumeValue = self.defaultVolume
        
        self.containerView()
        self.timer = Timer(timeInterval: 0.5,
                           target: self,
                           selector: #selector(progressViewChanges),
                           userInfo: nil,
                           repeats: true)
        RunLoop.current.add(self.timer, forMode: RunLoop.Mode.common)
        
    }
    
    @IBAction func volumeChangedHandle(_ sender: NSButton) {
        
        self.volumeValue = self.volumeValue + 1
        self.progressHeight(height: self.volumeValue)
        VolumeManager().changeVolume(self.volumeValue / denominator)
        
    }
    
    @IBAction func checkClicked(_ sender: Any) {
        let btn = sender as! NSButton
        if btn.state == .on {
            print("开始")
            self.timerStart()
        } else {
            print("暂停")
            self.timerPause()
        }
    }
    
    func containerView() {
        self.container = NSView()
        container.wantsLayer = true
        container.layer?.borderWidth = border // 添加 borderColor
        self.view.addSubview(container)
        
        let w: CGFloat = 40.0
        let h: CGFloat = 100
        container.frame = NSRect(x: self.view.bounds.width / 2 - w / 2.0, y: self.view.bounds.size.height / 2.0 - h / 2.0, width: w, height: h)
        
        self.loadProgressView(superView: container)
        self.showVolumeValue(constraints: self.container)
    }
    
    func showVolumeValue(constraints: NSView) {
        self.volumeText = NSTextField(labelWithString: "\(self.defaultVolume)")
        self.view.addSubview(self.volumeText)
        self.volumeText.isEditable = false
        self.volumeText.frame = CGRect(x: constraints.frame.origin.x, y: constraints.frame.origin.y - 10, width: constraints.frame.size.width, height: 10)
        self.volumeText.font = NSFont.systemFont(ofSize: 10.0)
        self.volumeText.textColor = .white
        self.volumeText.backgroundColor = .black
    }
    
    func loadProgressView(_ superViewBorder: CGFloat = 2.0, superView: NSView) {
        // MARK: height 应该为当前的音量, 最大为 100
        let h: CGFloat = self.defaultVolume
        self.progrssView = NSView()
        self.progressHeight(height: h)
        self.progrssView.wantsLayer = true
        self.progrssView.layer?.backgroundColor = NSColor.red.cgColor
        superView.addSubview(self.progrssView)
    }
    
    @objc func progressViewChanges() {
        if self.volumeValue > 1 {
            self.volumeValue = self.volumeValue - 1
            self.progressHeight(height: self.volumeValue)
        }
        self.volumeText.placeholderString = "\(self.volumeValue ?? 0.0)"
    }
    
    func progressHeight(height: CGFloat) {
        self.progrssView.frame = CGRect(x: border, y: border, width: self.container.bounds.size.width - 2 * border, height: height)
        VolumeManager().changeVolume(self.volumeValue / denominator)
    }
    
    func timerStart() {
        self.timer.fireDate = Date.distantFuture
    }
    
    func timerPause() {
        self.timer.fireDate = Date.distantPast
    }
    
}

