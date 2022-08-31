//
//  ScatterWarp.swift
//  GPUImage_macOS
//
//  Created by 刘乔泓 on 2022/8/31.
//  Copyright © 2022 HDLX LLC. All rights reserved.
//
import Foundation

public class ScatterWarp: BasicOperation {
    public var inputScatterRadius:Float = 0.05 { didSet { uniformSettings["inputScatterRadius"] = inputScatterRadius } }
    
    
    public init() {
        #if canImport(OpenGLES) || canImport(COpenGLES)
        let fshUrl = URL(fileURLWithPath: Bundle(for: type(of: self)).path(forResource: "ScatterWarp_GLES", ofType: "fsh")!)
        #endif
        
        #if canImport(OpenGL) || canImport(COpenGL)
        let fshUrl = URL(fileURLWithPath: Bundle(for: type(of: self)).path(forResource: "ScatterWarp_GL", ofType: "fsh")!)
        #endif
        
        try! super.init(fragmentShaderFile: fshUrl, numberOfInputs: 1)
        
        ({
            inputScatterRadius = 0.05
        })()
    }
    
}
