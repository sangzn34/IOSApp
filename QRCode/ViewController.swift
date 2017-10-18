//
//  ViewController.swift
//  QRCode
//
//  Created by Chutintron Suwannaklom on 15/10/60.
//  Copyright © พ.ศ. 2560 Chutintron Suwannaklom. All rights reserved.
//

import UIKit
import AVFoundation

struct ItemTraning {
    let cell:Int!
    let TRNo:String!
    let Topic:String!
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ContainerToTableTraining {
    var ListItemTraining = [ItemTraning]()
    @IBOutlet weak var square: UIImageView!
    @IBOutlet weak var btnOpenCamera: UIButton!
    @IBOutlet weak var tbTraining: UITableView!
    var video = AVCaptureVideoPreviewLayer()
    var session = AVCaptureSession()
    var cameraViewController: ViewCameraController?
    private var toggleCamera:Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbTraining.delegate = self
        tbTraining.dataSource = self
        ListItemTraining.append(ItemTraning(cell:1, TRNo: "1", Topic: "No.1"))
    }
    
    @IBAction func OpenCamera(_ sender: Any) {
        for item in ListItemTraining {
            print(item.Topic)
        }
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewCamera") as! ViewCameraController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        for item in ListItemTraining {
            print(item.Topic)
        }
        /*cameraViewController = segue.destination as? ViewCameraController
        cameraViewController!.containerToMaster = (self as! ContainerToTableTraining)*/
        //self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func getListTrainingCount() -> Int{
        return ListItemTraining.count
    }
    
    func addListTraining(Item:ItemTraning){
        ListItemTraining.append(Item)
        print("yes")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListItemTraining.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCellTraining", owner: self, options: nil)?.first as! TableViewCellTraining
        cell.LblTRNo.text = ListItemTraining[indexPath.row].TRNo
        cell.LblTopic.text = ListItemTraining[indexPath.row].Topic
        return cell
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

