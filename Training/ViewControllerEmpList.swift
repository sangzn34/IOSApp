//
//  ViewControllerEmpList.swift
//  QRCode
//
//  Created by Chutintron Suwannaklom on 21/10/60.
//  Copyright © พ.ศ. 2560 Chutintron Suwannaklom. All rights reserved.
//

import UIKit

class ViewControllerEmpList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tbEmpList: UITableView!
    var ItemDate:ItemTRDate = ItemTRDate.init(TRDateID: 0, DateNo: "", DateForm: "", DateTo: "", TimeForm: "", TimeTo: "")
    var ListEmp = [ItemEmpList]()
    var UrlApi = "http://it.ttfts.co.th/webapi/api/training/emp/TRDateID/"
    let serialQueue = DispatchQueue(label: "queuename")
    let statusCome = [0: "ยังไม่ได้เช็คชื่อ", 1: "เช็คชื่อแล้ว"]
    let statucComeColor = [0: UIColor.init(red: 1, green: 72/255, blue: 72/255, alpha: 1), 1: UIColor.init(red: 51/255, green: 229/255, blue: 99/255, alpha: 1)]
    var action = 0
    let lbAction = [0: "เช้า", 1: "บ่าย", 2: "OT"]
    @IBOutlet weak var navItem: UINavigationItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbEmpList.dataSource = self
        tbEmpList.delegate = self
        tbEmpList.refreshControl = UIRefreshControl()
        tbEmpList.refreshControl?.addTarget(self, action: #selector(didRefreshList), for: .valueChanged)
        navItem.title = "Emp List (\(lbAction[action] ?? ""))"
        Center.GetApiData(url: UrlApi+"\(ItemDate.TRDateID)", type: ItemEmpList.self, completion: ApiCompletion)
        // Do any additional setup after loading the view.
    }
    
    @objc func didRefreshList(){
        Center.GetApiData(url: UrlApi+"\(ItemDate.TRDateID)", type: ItemEmpList.self, completion: ApiCompletion)
    }
    
    func ApiCompletion(_ List:[ItemEmpList]){
        ListEmp = List
        DispatchQueue.main.async {
            self.tbEmpList.reloadData()
            self.tbEmpList.refreshControl?.endRefreshing()
        }
    }
    
    @IBAction func touchScan(_ sender: Any) {
        performSegue(withIdentifier: "TEmptoScan", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TEmptoScan"{
            let vc = segue.destination as! ViewCameraController
            vc.ItemDate.TRDateID = ItemDate.TRDateID
            vc.ItemDate.DateNo = ItemDate.DateNo
            vc.ItemDate.DateForm = ItemDate.DateForm
            vc.ItemDate.DateTo = ItemDate.DateTo
            vc.ItemDate.TimeForm = ItemDate.TimeForm
            vc.ItemDate.TimeTo = ItemDate.TimeTo
            vc.action = self.action
            
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tbEmpList.deselectRow(at: indexPath, animated: .init())
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListEmp.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCellEmpList", owner: self, options: nil)?.first as! TableViewCellEmpList
        cell.ldID_EMP.text = ListEmp[indexPath.row].ID_EMP
        cell.lbUSER_NAME.text = ListEmp[indexPath.row].USER_NAME
        cell.lbMorning.text = statusCome[ListEmp[indexPath.row].Morning_Come]
        cell.lbMorning.textColor = statucComeColor[ListEmp[indexPath.row].Morning_Come]
        cell.lbAfternoon.text = statusCome[ListEmp[indexPath.row].Afternoon_Come]
        cell.lbAfternoon.textColor = statucComeColor[ListEmp[indexPath.row].Afternoon_Come]
        cell.lbOT.text = statusCome[ListEmp[indexPath.row].OT_Come]
        cell.lbOT.textColor = statucComeColor[ListEmp[indexPath.row].OT_Come]
        return cell
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
