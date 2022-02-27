//
//  FastBlur.swift
//  GPUImage_macOS
//
//  Created by 刘乔泓 on 2022/2/27.
//  Copyright © 2022 Sunset Lake Software LLC. All rights reserved.
//
/// 一个适合移动设备的高性能实时模糊，模糊数大了会断层
public class FastBlur: BasicOperation {
    public var blurRadiusInPixels:Float = 40 { didSet { uniformSettings["progress"] = blurRadiusInPixels } }
    public var uOffset: Size = Size.init(width: 0, height: 0) {
        didSet {
            uniformSettings["uOffset"] = uOffset
        }
    }
    
    
    public init() {
        super.init(fragmentShader:FastBlurShader, numberOfInputs:1)
        
        ({blurRadiusInPixels = 40})()
    }
    
    
    public override func renderFrame() {
        if let size = inputFramebuffers.first?.value.size {
            self.uOffset = Size.init(width: 1 / Float(size.width), height: 1 / Float(size.height))
        }
        super.renderFrame()
    }
}
