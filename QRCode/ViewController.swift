//
//  ViewController.swift
//  QRCode
//
//  Created by Chutintron Suwannaklom on 15/10/60.
//  Copyright © พ.ศ. 2560 Chutintron Suwannaklom. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    
    @IBOutlet weak var square: UIImageView!
    @IBOutlet weak var btnOpenCamera: UIButton!
    var video = AVCaptureVideoPreviewLayer()
    var session = AVCaptureSession()
    private var toggleCamera:Bool = true
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        self.view.bringSubview(toFront: square)
        
        
    }
    
    @IBAction func OpenCamera(_ sender: Any) {
        toggleCamera = !toggleCamera;
        if(toggleCamera){
            if let inputs = session.inputs as? [AVCaptureDeviceInput] {
                for input in inputs {
                    session.removeInput(input)
                }
            }
            return
        }
        session = AVCaptureSession()
        let captureDevice = AVCaptureDevice.default(for: AVMediaType.video)
        do{
            let input = try AVCaptureDeviceInput(device: captureDevice!)
            session.addInput(input)
            
        }
        catch{
            print("ERROR")
        }
        
        let output = AVCaptureMetadataOutput()
        session.addOutput(output)
        output.setMetadataObjectsDelegate(self, queue: DispatchQueue.main)
        output.metadataObjectTypes = [.qr,.ean8, .ean13, .pdf417]
        
        video = AVCaptureVideoPreviewLayer(session: session)
        video.frame = view.layer.bounds
        view.layer.addSublayer(video)
        
        
        self.view.bringSubview(toFront: btnOpenCamera)
        session.startRunning()
    }
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects != nil && metadataObjects.count != 0{
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject{
                if object.type == AVMetadataObject.ObjectType.qr{
                    let alert = UIAlertController(title:"QR Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"Retake", style: .default, handler: (nil)))
                    alert.addAction(UIAlertAction(title:"Copy", style: .default, handler: { (nil) in
                        UIPasteboard.general.string = object.stringValue
                    }))
                    present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title:"Other", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"Retake", style: .default, handler: (nil)))
                    alert.addAction(UIAlertAction(title:"Copy", style: .default, handler: { (nil) in
                        UIPasteboard.general.string = object.stringValue
                    }))
                    present(alert, animated: true, completion: nil)
                }
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

