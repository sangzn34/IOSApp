//
//  ViewCameraController.swift
//  QRCode
//
//  Created by Chutintron Suwannaklom on 18/10/60.
//  Copyright © พ.ศ. 2560 Chutintron Suwannaklom. All rights reserved.
//

import UIKit
import AVFoundation

protocol ContainerToTableTraining{
    func addListTraining(Item:ItemTraning)
    func getListTrainingCount()->Int
}
class ViewCameraController: UIViewController, AVCaptureMetadataOutputObjectsDelegate  {
    var video = AVCaptureVideoPreviewLayer()
    let session = AVCaptureSession()
    var containerToMaster:ContainerToTableTraining?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
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
        
        
        session.startRunning()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        if let inputs = session.inputs as? [AVCaptureDeviceInput] {
            for input in inputs {
                session.removeInput(input)
            }
        }
    }
    
    
    func metadataOutput(_ output: AVCaptureMetadataOutput, didOutput metadataObjects: [AVMetadataObject], from connection: AVCaptureConnection) {
        if metadataObjects.count != 0{
            if let object = metadataObjects[0] as? AVMetadataMachineReadableCodeObject{
                if object.type == AVMetadataObject.ObjectType.qr{
                    let alert = UIAlertController(title:"QR Code", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"Retake", style: .default, handler: (nil)))
                    alert.addAction(UIAlertAction(title:"Copy", style: .default, handler: { (nil) in
                        UIPasteboard.general.string = object.stringValue
                        self.containerToMaster?.addListTraining(Item: ItemTraning(cell: 1, TRNo: "", Topic: object.stringValue))
                    }))
                    present(alert, animated: true, completion: nil)
                }else{
                    let alert = UIAlertController(title:"Other", message: object.stringValue, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"Retake", style: .default, handler: (nil)))
                    alert.addAction(UIAlertAction(title:"Copy", style: .default, handler: { (nil) in
                        UIPasteboard.general.string = object.stringValue
                        self.containerToMaster?.addListTraining(Item: ItemTraning(cell: 1, TRNo: "", Topic: object.stringValue))
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
