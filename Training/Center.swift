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
    
    static func GetApiData<T>(url:String, method: String, params: [String: Any], type:T.Type, completion: @escaping ((_ List:[T]) -> Void)){
        if URL(string:url) != nil {
            var request = URLRequest(url: URL(string: url)!)
            request.addValue("dXNlcm5hbWU6cGFzc3dvcmQ=", forHTTPHeaderField: "API_KEY")
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

            if method == "POST" {
                // convert key, value pairs into param string
                let postString = params.map { "\($0.0)=\($0.1)" }.joined(separator: "&")
                print(postString)
                request.httpMethod = "POST"
                request.httpBody = postString.data(using: String.Encoding.utf8)
            }
            else if method == "GET" {
                _ = params.map { "\($0.0)=\($0.1)" }.joined(separator: "&")
                request.httpMethod = "GET"
            }
            else if method == "PUT" {
                let putString = params.map { "\($0.0)=\($0.1)" }.joined(separator: "&")
                print(putString)
                request.httpMethod = "PUT"
                request.httpBody = putString.data(using: String.Encoding.utf8)
            }
            // Add other verbs here
            var List = [T]()
            URLSession.shared.dataTask(with: request){ (data, response, error) in
                do{
                    if let returnData = String(data: data!, encoding: .utf8) {
                        if T.self == String.self{
                            List.append(returnData as! T)
                            completion(List)
                        }
                    }
                    List = try JSONDecoder().decode([T].self, from: data!)
                    completion(List)
                }
                catch{
                    print(error)
                    completion(List)
                }
            }.resume()
        }
        else{
            // Could not make url. Is the url bad?
            // You could call the completion handler (callback) here with some value indicating an error
        }
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

