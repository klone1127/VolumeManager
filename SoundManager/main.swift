//
//  main.swift
//  SoundManager
//
//  Created by CF on 2017/6/14.
//  Copyright © 2017年 klone. All rights reserved.
//

import Cocoa

let delegate = AppDelegate() //alloc main app's delegate class
NSApplication.shared.delegate = delegate //set as app's delegate

let ret = NSApplicationMain(CommandLine.argc, CommandLine.unsafeArgv)
