//
//  ViewController.swift
//  WorldTracking
//
//  Created by Sherafgan Kandov on 07/10/2018.
//  Copyright © 2018 Sherafgan Kandov. All rights reserved.
//

import UIKit
import ARKit

class ViewController: UIViewController {
    
    @IBOutlet weak var sceneView: ARSCNView!
    let configuration = ARWorldTrackingConfiguration()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.sceneView.debugOptions = [ARSCNDebugOptions.showFeaturePoints, ARSCNDebugOptions.showWorldOrigin]
        self.sceneView.session.run(configuration)
    }
    
    @IBAction func add(_ sender: Any) {
        let node = SCNNode()
//        node.geometry = SCNBox(width:0.1, height:0.1, length:0.1, chamferRadius:0.03)
//        node.geometry = SCNCapsule(capRadius: 0.1, height: 0.3)
//        node.geometry = SCNCone(topRadius: 0.1, bottomRadius: 0.3, height: 0.3)
//        node.geometry = SCNCylinder(radius: 0.2, height: 0.2)
//        node.geometry = SCNSphere(radius: 0.1)
//        node.geometry = SCNTube(innerRadius: 0.05, outerRadius: 0.08, height: 0.1)
//        node.geometry = SCNPlane(width: 0.2, height: 0.2)
        let path = UIBezierPath()
        path.move(to: CGPoint(x:0, y:0))
        path.addLine(to: CGPoint(x:0, y:0.2))
        path.addLine(to: CGPoint(x:0.2, y:0.3))
        path.addLine(to: CGPoint(x:0.4, y:0.2))
        path.addLine(to: CGPoint(x:0.4, y:0))
        let shape = SCNShape(path: path, extrusionDepth: 0.2)
        node.geometry = shape
        node.geometry?.firstMaterial?.specular.contents = UIColor.yellow
        node.geometry?.firstMaterial?.diffuse.contents = UIColor.blue
//        let x = randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        let y = randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        let z = randomNumbers(firstNum: -0.3, secondNum: 0.3)
//        node.position = SCNVector3(x, y, z)
        node.position = SCNVector3(0, 0, -0.7)
        self.sceneView.scene.rootNode.addChildNode(node)
        self.sceneView.autoenablesDefaultLighting = true
    }
    
    @IBAction func restartSession(_ sender: Any) {
        self.restartSession()
    }
    
    func restartSession(){
        self.sceneView.session.pause()
        self.sceneView.scene.rootNode.enumerateChildNodes { (node, _) in
            node.removeFromParentNode()
        }
        self.sceneView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
    
    func randomNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
}

