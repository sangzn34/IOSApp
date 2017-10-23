//
//  ViewController.swift
//  QRCode
//
//  Created by Chutintron Suwannaklom on 15/10/60.
//  Copyright © พ.ศ. 2560 Chutintron Suwannaklom. All rights reserved.
//

import UIKit

class ViewController: UITableViewController{
    
    @IBOutlet weak var tbTraining: UITableView!
    var cameraViewController: ViewCameraController?
    private var toggleCamera:Bool = true
    var trainingList = [ItemTR]()
    var activityIndicator:UIActivityIndicatorView = UIActivityIndicatorView()
    var selectRow:ItemTR = ItemTR.init(TRNo: "", TRTopic: "", Approve_T: 0, Approve_M: 0, SS: 0)
    let UrlApi:String = "http://it.ttfts.co.th/webapi/api/training/list"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbTraining.delegate = self
        tbTraining.dataSource = self
        tbTraining.refreshControl = UIRefreshControl()
        self.tbTraining.refreshControl?.addTarget(self, action: #selector(didRefreshList), for: .valueChanged)
        Center.GetApiData(url: UrlApi, type: ItemTR.self, completion: apiCompletion)
    }
    
    @objc func didRefreshList(){
        Center.GetApiData(url: UrlApi, type: ItemTR.self, completion: apiCompletion)
        self.tbTraining.reloadData()
    }
    
    func apiCompletion(_ List:[ItemTR]){
        trainingList = List
        DispatchQueue.main.async {
            self.tbTraining.reloadData()
            self.tbTraining.refreshControl?.endRefreshing()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Row \(indexPath.row)selected")
        selectRow.TRNo = trainingList[indexPath.row].TRNo
        selectRow.TRTopic = trainingList[indexPath.row].TRTopic
        tbTraining.deselectRow(at: indexPath, animated: .init())
        performSegue(withIdentifier: "TLtoTD", sender: nil)
        //performSegue(withIdentifier: "TrainingDate", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "TLtoTD"){
            let vc = segue.destination as! ViewControllerTrainingDate
            vc.TRNo = selectRow.TRNo
            vc.TRTopic = selectRow.TRTopic
        }
        /*cameraViewController = segue.destination as? ViewCameraController
        cameraViewController!.containerToMaster = (self as! ContainerToTableTraining)*/
        //self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trainingList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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

