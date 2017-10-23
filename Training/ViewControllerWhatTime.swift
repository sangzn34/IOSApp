//
//  ViewControllerWhatTime.swift
//  QRCode
//
//  Created by Chutintron Suwannaklom on 22/10/60.
//  Copyright © พ.ศ. 2560 Chutintron Suwannaklom. All rights reserved.
//

import UIKit

class ViewControllerWhatTime: UIViewController {

    @IBOutlet weak var btnMorning: UIButton!
    @IBOutlet weak var btnAfternoon: UIButton!
    @IBOutlet weak var btnOT: UIButton!
    var ItemDate:ItemTRDate = ItemTRDate.init(TRDateID: 0, DateNo: "", DateForm: "", DateTo: "", TimeForm: "", TimeTo: "")
    var action = 0
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func touchMorning(_ sender: Any) {
        SetAction(action: 0)
    }
    @IBAction func touchAfternoon(_ sender: Any) {
        SetAction(action: 1)
    }
    @IBAction func touchOT(_ sender: Any) {
        SetAction(action: 2)
    }
    
    func SetAction(action:Int){
        self.action = action
        performSegue(withIdentifier: "WTtoTEmp", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "WTtoTEmp"{
            let vc = segue.destination as! ViewControllerEmpList
            vc.ItemDate.TRDateID = ItemDate.TRDateID
            vc.ItemDate.DateNo = ItemDate.DateNo
            vc.ItemDate.DateForm = ItemDate.DateForm
            vc.ItemDate.DateTo = ItemDate.DateTo
            vc.ItemDate.TimeForm = ItemDate.TimeForm
            vc.ItemDate.TimeTo = ItemDate.TimeTo
            vc.action = self.action
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
