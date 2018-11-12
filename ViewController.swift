//
//  ViewController.swift
//  ARPaint
//
//  Created by Julian Abhari on 8/7/17.
//  Copyright © 2017 Julian Abhari. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ViewController: UIViewController {
    
    @IBOutlet var sceneView: ARSCNView!
    
    struct cameraCoordinates {
        var x = Float();
        var y = Float();
        var z = Float();
    }
    
    func getCameraCoordinates(sceneView: ARSCNView) -> cameraCoordinates {
        let cameraTransform = sceneView.session.currentFrame?.camera.transform
        let cameraCoords = MDLTransform(matrix: cameraTransform!)
        var cc = cameraCoordinates()
        cc.x = cameraCoords.translation.x
        cc.y = cameraCoords.translation.y
        cc.z = cameraCoords.translation.z
        return cc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let configuration = ARWorldTrackingSessionConfiguration()
        configuration.planeDetection = .horizontal
        
        sceneView.session.run(configuration)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let cubeNode = SCNNode(geometry: SCNBox(width: 0.01, height: 0.01, length: 0.01, chamferRadius: 0))
        let cc = getCameraCoordinates(sceneView: sceneView)
        
        // The coordinates are in meters
        cubeNode.position = SCNVector3(cc.x, cc.y, cc.z)
        sceneView.scene.rootNode.addChildNode(cubeNode)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

