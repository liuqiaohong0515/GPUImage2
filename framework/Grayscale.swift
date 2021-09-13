//
//  Grayscale.swift
//  GPUImage
//
//  Created by 刘乔泓 on 2021/9/13.
//
public class Grayscale: BasicOperation {
    public enum GrayscaleType {
        case average //均值灰度 Gray = (R+G+B)/3
        case classic //经典灰度 Gray = 0.299R+0.587G+0.114B
        case desaturate //Photoshop Desaturate（去色）指令 Gary = (max(R,G,B)+min(R,G,B))/2
    }
    
    public var intensity:Float = 1.0 { didSet { uniformSettings["intensity"] = intensity } }
    
    private var type: Int = 0 { didSet { uniformSettings["type"] = type } }

    public convenience init(type: GrayscaleType) {
        self.init()
        
        switch type {
        case .average:
            self.type = 0
        case .classic:
            self.type = 1
        case .desaturate:
            self.type = 2
        }
    }
    
    public init() {
        super.init(fragmentShader:GrayscaleShader, numberOfInputs:1)
    }
    
}
