//
//  GlitchVertigoFilter.swift
//  GPUImage_macOS
//
//  Created by 刘乔泓 on 2022/8/17.
//  Copyright © 2022 HDLX Software LLC. All rights reserved.
//

import Foundation

public class GlitchVertigoFilter: BasicOperation {
    public var time: Float = 0.0 { didSet { uniformSettings["time"] = time } }
    public var duration: Float = 2.0 { didSet { uniformSettings["duration"] = duration } }
    
    
    public init() {
        #if canImport(OpenGLES) || canImport(COpenGLES)
        let fshUrl = URL(fileURLWithPath: Bundle(for: type(of: self)).path(forResource: "GlitchVertigoFilter_GLES", ofType: "fsh")!)
        #endif
        
        #if canImport(OpenGL) || canImport(COpenGL)
        let fshUrl = URL(fileURLWithPath: Bundle(for: type(of: self)).path(forResource: "GlitchVertigoFilter_GL", ofType: "fsh")!)
        #endif
        
        try! super.init(fragmentShaderFile: fshUrl, numberOfInputs: 1)
        
        ({
            time = 0.0
            duration = 2.0
        })()
    }
    
    public override func renderFrame() {
        if let time = inputFramebuffers[0]?.timingStyle.timestamp?.seconds() {
            self.time = Float(time)
        }
        super.renderFrame()
    }
}
