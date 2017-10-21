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
struct ItemTR:Decodable {
    var TRNo:String
    var TRTopic:String
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
    var trainingList = [ItemTR]()
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var refreshControl = UIRefreshControl()
    var selectRow:ItemTR = ItemTR(TRNo: "", TRTopic: "")
    let UrlApi:String = "http://it.ttfts.co.th/webapi/api/training/list"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbTraining.delegate = self
        tbTraining.dataSource = self
        tbTraining.refreshControl = self.refreshControl
        self.refreshControl.addTarget(self, action: #selector(didRefreshList), for: .valueChanged)
        ListItemTraining.append(ItemTraning(cell:1, TRNo: "1", Topic: "No.1"))
        Center.GetApiData(url: UrlApi, type: ItemTR.self, completion: apiCompletion)
    }
    
    @objc func didRefreshList(){
        Center.GetApiData(url: UrlApi, type: ItemTR.self, completion: apiCompletion)
        self.tbTraining.reloadData()
        refreshControl.endRefreshing()
    }
    
    func apiCompletion(_ List:[ItemTR]){
        trainingList = List
        DispatchQueue.main.async {
            self.tbTraining.reloadData()
        }
    }
    
    /*func StartLoading(){
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .gray
        view.addSubview(activityIndicator)
        
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    
    func StopLoading(){
        activityIndicator.stopAnimating()
        activityIndicator.removeFromSuperview()
        UIApplication.shared.endIgnoringInteractionEvents()
    }*/
    
    
    @IBAction func OpenCamera(_ sender: Any) {
        for item in ListItemTraining {
            print(item.Topic)
        }
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "ViewCamera") as! ViewCameraController
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row \(indexPath.row)selected")
        selectRow.TRNo = trainingList[indexPath.row].TRNo
        selectRow.TRTopic = trainingList[indexPath.row].TRTopic
        tbTraining.deselectRow(at: indexPath, animated: .init())
        performSegue(withIdentifier: "TLtoTD", sender: nil)
        //performSegue(withIdentifier: "TrainingDate", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "TLtoCamera"){
            for item in ListItemTraining {
                print(item.Topic)
            }
        }
        else if(segue.identifier == "TLtoTD"){
            let vc = segue.destination as! ViewControllerTrainingDate
            vc.TRNo = selectRow.TRNo
            vc.TRTopic = selectRow.TRTopic
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
        return trainingList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCellTraining", owner: self, options: nil)?.first as! TableViewCellTraining
        cell.LblTRNo.text = trainingList[indexPath.row].TRNo
        cell.LblTopic.text = trainingList[indexPath.row].TRTopic
        return cell
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

