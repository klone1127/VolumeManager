//
//  VolumeManager.swift
//  SoundManager
//
//  Created by jgrm on 2017/6/15.
//  Copyright © 2017年 klone. All rights reserved.
//

import Foundation
import AudioToolbox

class VolumeManager: NSObject {
    
    open func changeVolume(_ volumeValue: CGFloat = 0.5) {
        // 设置音量
        var volume = Float32(volumeValue) // 0.0 ... 1.0
        let volumeSize = UInt32(MemoryLayout.size(ofValue: volume))
        
        var volumePropertyAddress = AudioObjectPropertyAddress(
            mSelector: AudioObjectPropertySelector(kAudioHardwareServiceDeviceProperty_VirtualMasterVolume),
            mScope: AudioObjectPropertyScope(kAudioDevicePropertyScopeOutput),
            mElement: AudioObjectPropertyElement(kAudioObjectPropertyElementMaster))
        
        _ = AudioObjectSetPropertyData(
            self.getDefaultOutputDeviceID(),
            &volumePropertyAddress,
            0,
            nil,
            volumeSize,
            &volume)
    }
    
    open func getDefaultOutputDeviceID() -> AudioDeviceID {
        // 获取输出设备
        var defaultOutputDeviceID = AudioDeviceID(0)
        var defaultOutputDeviceIDSize = UInt32(MemoryLayout.size(ofValue: defaultOutputDeviceID))
        
        var getDefaultOutputDevicePropertyAddress = AudioObjectPropertyAddress(
            mSelector: AudioObjectPropertySelector(kAudioHardwarePropertyDefaultOutputDevice),
            mScope: AudioObjectPropertyScope(kAudioObjectPropertyScopeGlobal),
            mElement: AudioObjectPropertyElement(kAudioObjectPropertyElementMaster))
        
        _ = AudioObjectGetPropertyData(
            AudioObjectID(kAudioObjectSystemObject),
            &getDefaultOutputDevicePropertyAddress,
            0,
            nil,
            &defaultOutputDeviceIDSize,
            &defaultOutputDeviceID)
        
        return defaultOutputDeviceID
    }
    
}
