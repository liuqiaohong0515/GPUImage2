//
//  GlitchSoulOut.swift
//  GPUImage_iOS
//
//  Created by 刘乔泓 on 2022/8/14.
//  Copyright © 2022 HDLX Software LLC. All rights reserved.
//

import Foundation

public class GlitchSoulOutFilter: BasicOperation {
    public var time: Float = 0.0 { didSet { uniformSettings["time"] = time } }
    public var duration: Float = 0.7 { didSet { uniformSettings["duration"] = duration } }
    public var maxAlpha: Float = 0.4 { didSet { uniformSettings["maxAlpha"] = maxAlpha } }
    public var maxScale: Float = 1.8 { didSet { uniformSettings["maxScale"] = time } }
    
    public init() {
        #if canImport(OpenGLES) || canImport(COpenGLES)
        let fshUrl = URL(fileURLWithPath: Bundle(for: type(of: self)).path(forResource: "GlitchSoulOutFilter_GLES", ofType: "fsh")!)
        #endif
        
        #if canImport(OpenGL) || canImport(COpenGL)
        let fshUrl = URL(fileURLWithPath: Bundle(for: type(of: self)).path(forResource: "GlitchSoulOutFilter_GL", ofType: "fsh")!)
        #endif
        
        try! super.init(fragmentShaderFile: fshUrl, numberOfInputs: 1)
        
        ({
            time = 0.0
            duration = 0.7
            maxAlpha = 0.4
            maxScale = 1.8
        })()
    }
    
    public override func renderFrame() {
        if let time = inputFramebuffers[0]?.timingStyle.timestamp?.seconds() {
            self.time = Float(time)
        }
        super.renderFrame()
    }
}
