public class UnsharpMask: OperationGroup {
    public var blurRadiusInPixels: Float { didSet { gaussianBlur.blurRadiusInPixels = blurRadiusInPixels } }
    public var intensity: Float = 1.0 { didSet { unsharpMask.intensity = intensity } }
    
    let gaussianBlur = GaussianBlur()
    let unsharpMask = UnsharpMaskFilter()

    public override init() {
        blurRadiusInPixels = 4.0
        super.init()

        ({intensity = 1.0})()

        self.configureGroup{input, output in
            input --> self.unsharpMask
            input --> self.gaussianBlur --> self.unsharpMask --> output
        }
    }
}

class UnsharpMaskFilter: BasicOperation {
    public var intensity:Float = 1.0 { didSet { uniformSettings["intensity"] = intensity } }
    
    public init() {
        super.init(fragmentShader:UnsharpMaskFragmentShader, numberOfInputs:2)
        
        ({intensity = 1.0})()
    }
    
    //UnsharpMaskFilter does not need to keep the last rendering result
    override func releaseIncomingFramebuffers() {
        // If all inputs are still images, have this output behave as one
        renderFramebuffer.timingStyle = .stillImage
        
        var latestTimestamp:Timestamp?
        for (key, framebuffer) in inputFramebuffers {
            // When there are multiple transient input sources, use the latest timestamp as the value to pass along
            if let timestamp = framebuffer.timingStyle.timestamp {
                if !(timestamp < (latestTimestamp ?? timestamp)) {
                    latestTimestamp = timestamp
                    renderFramebuffer.timingStyle = .videoFrame(timestamp:timestamp)
                }
            }
            framebuffer.unlock()
        }
        inputFramebuffers = [UInt:Framebuffer]() //clear all input
    }
}
