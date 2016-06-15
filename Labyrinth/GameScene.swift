import SpriteKit
import CoreMotion

class GameScene: SKScene {
    let motionManager = CMMotionManager()
    override func didMoveToView(view: SKView) {
        // load the texture atlas
        let atlas = SKTextureAtlas(named: "assets")
        
        // create blob sprite
        let blob = SKSpriteNode(texture: atlas.textureNamed("blob"))
        
        // center the blob on the screen
        blob.position = CGPointMake(self.size.width * 0.5, self.size.width * 0.5)
        
        // add it to the scene!
        self.addChild(blob)
        
        // set up blob physics
        blob.physicsBody = SKPhysicsBody(circleOfRadius: blob.size.width * 0.5)
        blob.physicsBody!.mass = 1
        
        // initialize accelerometer
        if motionManager.accelerometerAvailable {
            motionManager.startAccelerometerUpdates()
        }
        
        // no gravity by default
        self.physicsWorld.gravity = CGVectorMake(0, 0)
        
        // add physics blocks
        for x in 0..<10 {
            for y in 0..<10 {
                if arc4random() % 2 == 0 { // random chance of spawning a block
                    let block = SKSpriteNode(texture: atlas.textureNamed("block"))
                    self.addChild(block)
                    block.physicsBody = SKPhysicsBody(rectangleOfSize: block.size)
                    block.physicsBody!.dynamic = false
                    block.physicsBody!.affectedByGravity = false
                    block.position = CGPointMake(CGFloat(x) * 150, CGFloat(y) * 150)
                }
            }
        }
        
        // make the camera follow the blob
        self.anchorPoint = CGPointMake(0.5, 0.5) // center the camera view
        let cameraNode = SKCameraNode()
        blob.addChild(cameraNode) // camera position is now determined relative to the blob
        self.camera = cameraNode
    }
    
    override func update(currentTime: CFTimeInterval) {
        // update gravity based on accelerometer
        if let data = motionManager.accelerometerData {
            self.physicsWorld.gravity = CGVectorMake(CGFloat(data.acceleration.x), CGFloat(data.acceleration.y))
        }
    }
}
