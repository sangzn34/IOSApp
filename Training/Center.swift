//
//  Center.swift
//  QRCode
//
//  Created by Chutintron Suwannaklom on 21/10/60.
//  Copyright © พ.ศ. 2560 Chutintron Suwannaklom. All rights reserved.
//

import Foundation

struct ItemTraning {
    let cell:Int!
    let TRNo:String!
    let Topic:String!
}

struct ItemTR:Decodable {
    var TRNo:String
    var TRTopic:String
    var Approve_T:Int?
    var Approve_M:Int?
    var SS:Int
}

struct ItemTRDate:Decodable {
    var TRDateID:Int
    var DateNo:String
    var DateForm:String
    var DateTo:String
    var TimeForm:String
    var TimeTo:String
}

struct ItemEmpList:Decodable {
    var TREmpList_id:Int
    var TRDateID:Int
    var ID_EMP:String
    var USER_NAME:String
    var Morning_Come:Int
    var Afternoon_Come:Int
    var OT_Come:Int
}

class Center {
    
    static func GetApiData<T>(url:String, type:T.Type, completion: @escaping ((_ List:[T]) -> Void)){
        var request = URLRequest(url: URL(string: url)!)
        request.addValue("dXNlcm5hbWU6cGFzc3dvcmQ=", forHTTPHeaderField: "API_KEY")
        var List = [T]()
        URLSession.shared.dataTask(with: request){ (data, response, error) in
            do{
                List = try JSONDecoder().decode([T].self, from: data!)
                completion(List)
            }
            catch{
                print(error)
                completion(List)
            }
        }.resume()
    }
    
    static func convertDateFormater(_ date: String, formFormat: String, toFormat: String) -> String
    {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formFormat
        let date = dateFormatter.date(from: date)
        dateFormatter.dateFormat = toFormat
        return  dateFormatter.string(from: date!)
    }
}

