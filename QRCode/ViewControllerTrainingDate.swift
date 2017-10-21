//
//  ViewControllerTrainingDate.swift
//  QRCode
//
//  Created by Chutintron Suwannaklom on 20/10/60.
//  Copyright © พ.ศ. 2560 Chutintron Suwannaklom. All rights reserved.
//

import UIKit
struct ItemTRDate:Decodable {
    var TRDateID:Int
    var DateNo:String
    var DateForm:String
    var DateTo:String
    var TimeForm:String
    var TimeTo:String
}
class ViewControllerTrainingDate: UITableViewController{

    @IBOutlet weak var lbTRNo: UILabel!
    @IBOutlet weak var lbTRTopic: UILabel!
    var TRNo:String = ""
    var TRTopic:String = ""
    @IBOutlet weak var tbTRDate: UITableView!
    var ListDate = [ItemTRDate]()
    let UrlApi:String = "http://it.ttfts.co.th/webapi/api/training/date/"
    var selectIndex:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tbTRDate.dataSource = self
        tbTRDate.delegate = self
        tbTRDate.refreshControl = UIRefreshControl()
        tbTRDate.refreshControl?.addTarget(self, action: #selector(didRefreshList), for: .valueChanged)
        Center.GetApiData(url: UrlApi+TRNo, type: ItemTRDate.self, completion: apiCompletion)
        // Do any additional setup after loading the view.
    }
    
    @objc func didRefreshList(){
        Center.GetApiData(url: UrlApi+TRNo, type: ItemTRDate.self, completion: apiCompletion)
        self.tbTRDate.reloadData()
        tbTRDate.refreshControl?.endRefreshing()
    }
    
    func apiCompletion(_ List:[ItemTRDate]){
        ListDate.removeAll()
        for r in List{
            var timeForm = r.TimeForm.components(separatedBy: "T")[1]
            timeForm = String(timeForm[..<timeForm.index(timeForm.startIndex, offsetBy: 5)])
            var timeTo = r.TimeTo.components(separatedBy: "T")[1]
            timeTo = String(timeTo[..<timeTo.index(timeTo.startIndex, offsetBy: 5)])
            ListDate.append(ItemTRDate.init(TRDateID: r.TRDateID, DateNo: r.DateNo
                ,DateForm: Center.convertDateFormater(r.DateForm.components(separatedBy: "T")[0], formFormat: "yyyy-MM-dd", toFormat: "dd-MM-yyyy") + " " + timeForm
                ,DateTo: Center.convertDateFormater(r.DateTo.components(separatedBy: "T")[0], formFormat: "yyyy-MM-dd", toFormat: "dd-MM-yyyy") + " " + timeTo
                ,TimeForm: r.TimeForm, TimeTo: r.TimeTo))
        }
        DispatchQueue.main.async {
            self.tbTRDate.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tbTRDate.deselectRow(at: indexPath, animated: .init())
        selectIndex = indexPath.row
        performSegue(withIdentifier: "TDtoTEmp", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "TDtoTEmp"{
            let vc = segue.destination as! ViewControllerEmpList
            vc.ItemDate.TRDateID = ListDate[selectIndex].TRDateID
            vc.ItemDate.DateNo = ListDate[selectIndex].DateNo
            vc.ItemDate.DateForm = ListDate[selectIndex].DateForm
            vc.ItemDate.DateTo = ListDate[selectIndex].DateTo
            vc.ItemDate.TimeForm = ListDate[selectIndex].TimeForm
            vc.ItemDate.TimeTo = ListDate[selectIndex].TimeTo
        }
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ListDate.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("TableViewCellTraining", owner: self, options: nil)?.first as! TableViewCellTraining
        cell.LblTRNo.text = ListDate[indexPath.row].DateForm
        cell.LblTopic.text = ListDate[indexPath.row].DateTo
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
