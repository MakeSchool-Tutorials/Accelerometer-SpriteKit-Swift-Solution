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
        blob.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.5)
        
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
    }
    
    override func update(currentTime: CFTimeInterval) {
        // update gravity based on accelerometer
        if let data = motionManager.accelerometerData {
            self.physicsWorld.gravity = CGVectorMake(CGFloat(data.acceleration.x), CGFloat(data.acceleration.y))
        }
    }
}
