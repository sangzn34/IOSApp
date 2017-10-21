//
//  Center.swift
//  QRCode
//
//  Created by Chutintron Suwannaklom on 21/10/60.
//  Copyright © พ.ศ. 2560 Chutintron Suwannaklom. All rights reserved.
//

import Foundation


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

