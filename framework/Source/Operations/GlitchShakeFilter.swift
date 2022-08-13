//
//  GlitchShakeFilter.swift
//  GPUImage
//
//  Created by 刘乔泓 on 2022/8/13.
//  Copyright © 2022 HDLX Software LLC. All rights reserved.
//

import Foundation
public class GlitchShakeFilter: BasicOperation {
    public var scale: Float = 0.0 { didSet { uniformSettings["scale"] = scale } }
    
    public init() {
        super.init(fragmentShader:GlitchShakeFilterShader, numberOfInputs:1)
        
        ({scale = 0.0})()
    }
    
    public override func renderFrame() {
        if let timeMS = inputFramebuffers[0]?.timingStyle.timestamp?.millisecond() {
            var value: Double = Double(timeMS) / 600
            var intValue = Int(value)
            value = value - Double(intValue)
            value = value * 0.25
            self.scale = Float(max(1.0, pow(2.0,value)))
        }
        super.renderFrame()
    }
    
}
