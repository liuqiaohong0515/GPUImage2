//
//  GlitchGlitchFilter.swift
//  GPUImage_macOS
//
//  Created by 刘乔泓 on 2022/8/16.
//  Copyright © 2022 HDLX Software LLC. All rights reserved.
//
import Foundation

public class GlitchGlitchFilter: BasicOperation {
    public var time: Float = 0.0 { didSet { uniformSettings["time"] = time } }
    public var maxJitter: Float = 0.06 { didSet { uniformSettings["maxJitter"] = maxJitter } }
    public var duration: Float = 0.3 { didSet { uniformSettings["duration"] = duration } }
    public var colorROffset: Float = 0.01 { didSet { uniformSettings["colorROffset"] = colorROffset } }
    public var colorBOffset: Float = -0.025 { didSet { uniformSettings["colorBOffset"] = time } }
    
    
    public init() {
        #if canImport(OpenGLES) || canImport(COpenGLES)
        let fshUrl = URL(fileURLWithPath: Bundle(for: type(of: self)).path(forResource: "GlitchGlitchFilter_GLES", ofType: "fsh")!)
        #endif
        
        #if canImport(OpenGL) || canImport(COpenGL)
        let fshUrl = URL(fileURLWithPath: Bundle(for: type(of: self)).path(forResource: "GlitchGlitchFilter_GL", ofType: "fsh")!)
        #endif
        
        try! super.init(fragmentShaderFile: fshUrl, numberOfInputs: 1)
        
        ({
            time = 0.0
            maxJitter = 0.06
            duration = 0.3
            colorROffset = 0.01
            colorBOffset = -0.025
        })()
    }
    
    public override func renderFrame() {
        if let time = inputFramebuffers[0]?.timingStyle.timestamp?.seconds() {
            self.time = Float(time)
        }
        super.renderFrame()
    }
    
}
