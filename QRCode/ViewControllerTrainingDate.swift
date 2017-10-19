//
//  ViewControllerTrainingDate.swift
//  QRCode
//
//  Created by Chutintron Suwannaklom on 20/10/60.
//  Copyright © พ.ศ. 2560 Chutintron Suwannaklom. All rights reserved.
//

import UIKit

class ViewControllerTrainingDate: UIViewController {
    @IBOutlet weak var lbTRNo: UILabel!
    @IBOutlet weak var lbTRTopic: UILabel!
    var TRNo:String = ""
    var TRTopic:String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lbTRNo.text = TRNo
        lbTRTopic.text = TRTopic
        // Do any additional setup after loading the view.
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
