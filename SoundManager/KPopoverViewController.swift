//
//  KPopoverViewController.swift
//  SoundManager
//
//  Created by CF on 2017/6/14.
//  Copyright © 2017年 klone. All rights reserved.
//

import Cocoa

let border: CGFloat = 2.0

class KPopoverViewController: NSViewController {
    
    var progrssView: NSView!
    var container: NSView!
    
    @IBOutlet weak var touchButton: NSButton!
    var volumeValue: CGFloat = 50.0       // 默认值为当前音量
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.containerView()
        Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(progressViewChanges), userInfo: nil, repeats: true)
        
    }
    
    @IBAction func volumeChangedHandle(_ sender: Any) {
        print("volume changed")
        VolumeManager().changeVolume(0.2)
        self.volumeValue = self.volumeValue + 1
        self.progressHeight(height: self.volumeValue)
    }
    
    func containerView() {
        
        self.container = NSView()
        container.wantsLayer = true
        container.layer?.borderWidth = border // 添加 borderColor
        self.view.addSubview(container)
        
        let w: CGFloat = 40.0
        let h: CGFloat = 100.0
        container.frame = NSRect(x: self.view.bounds.width / 2 - w / 2.0, y: self.view.bounds.size.height / 2.0 - h / 2.0, width: w, height: h)
        
        self.loadProgressView(superView: container)
        
    }
    
    func loadProgressView(_ superViewBorder: CGFloat = 2.0, superView: NSView) {
        // MARK: height 应该为当前的音量, 最大为 100
        let h: CGFloat = 20.0
        self.progrssView = NSView()
        self.progressHeight(height: h)
        self.progrssView.wantsLayer = true
        self.progrssView.layer?.backgroundColor = NSColor.red.cgColor
        superView.addSubview(self.progrssView)
        
    }
    
    @objc func progressViewChanges() {
        self.volumeValue = self.volumeValue - 1
        self.progressHeight(height: self.volumeValue)
    }
    
    func progressHeight(height: CGFloat) {
        self.progrssView.frame = CGRect(x: border, y: border, width: self.container.bounds.size.width - 2 * border, height: height)
    }
    
}

