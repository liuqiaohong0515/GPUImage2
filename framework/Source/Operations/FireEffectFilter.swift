//
//  FireEffectFilter.swift
//  GPUImage_macOS
//
//  Created by 刘乔泓 on 2022/1/9.
//  Copyright © 2022 HDLX Software LLC. All rights reserved.
//
/// Fire effect, only useful for video
public class FireEffectFilter: BasicOperation {
    var frameBuffers: [Framebuffer] = []
    
    public var intensity:Float = 1.0 { didSet { uniformSettings["intensity"] = intensity } }
    
    public init() {
        super.init(fragmentShader:FireEffectShader, numberOfInputs:1)
        
        ({intensity = 1.0})()
    }
    
    public override func renderFrame() {
        let input = inputFramebuffers[0]!
        input.lock()
        super.renderFrame()
        self.backupFrameBuffer(frameBuffer: input)
    }
    
    private func backupFrameBuffer(frameBuffer: Framebuffer) {
        //备份大于5个，则删除一个
        if self.frameBuffers.count >= 5 {
            let temp = self.frameBuffers.first
            self.frameBuffers.removeFirst()
            temp?.unlock()
        }
        self.frameBuffers.append(frameBuffer)
    }
    
    public override func initialTextureProperties() -> [InputTextureProperties] {
        var inputTextureProperties = [InputTextureProperties]()
        
        if let outputRotation = overriddenOutputRotation {
            for framebufferIndex in 0..<inputFramebuffers.count {
                inputTextureProperties.append(inputFramebuffers[UInt(framebufferIndex)]!.texturePropertiesForOutputRotation(outputRotation))
            }
            for framebufferIndex in 0..<frameBuffers.count {
                inputTextureProperties.append(frameBuffers[framebufferIndex].texturePropertiesForOutputRotation(outputRotation))
            }
        } else {
            for framebufferIndex in 0..<inputFramebuffers.count {
                inputTextureProperties.append(inputFramebuffers[UInt(framebufferIndex)]!.texturePropertiesForTargetOrientation(.portrait))
            }
            for framebufferIndex in 0..<frameBuffers.count {
                inputTextureProperties.append(frameBuffers[framebufferIndex].texturePropertiesForTargetOrientation(.portrait))
            }
        }
        
        return inputTextureProperties
    }
}
