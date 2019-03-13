//
//  AppDelegate.swift
//  SoundManager
//
//  Created by CF on 2017/6/14.
//  Copyright © 2017年 klone. All rights reserved.
//

import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    
    var statusItem: NSStatusItem!
    var popover: NSPopover!
    
    
    func loadPopover() {
        self.popover = NSPopover()
        self.popover.behavior = .transient
        self.popover.appearance = NSAppearance.init(named: .vibrantLight)
        self.popover.contentViewController = KPopoverViewController(nibName: "KPopoverViewController", bundle: nil)
    }
    
    @objc func showPopover(_ sender: NSButton) {
        self.popover.show(relativeTo: sender.bounds, of: sender, preferredEdge: .maxY)
    }

    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        
        
        self.statusItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        self.statusItem.title = "音量"
        // Do any additional setup after loading the view.
        self.loadPopover()
        
        self.statusItem.target = self;
        self.statusItem.button?.action = #selector(showPopover(_:))
        // Insert code here to initialize your application
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }


}

