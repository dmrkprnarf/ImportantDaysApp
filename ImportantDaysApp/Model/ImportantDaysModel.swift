//
//  Model.swift
//  PortalCodeApp
//
//  Created by Arif Demirkoparan on 26.01.2023.
//

import Foundation

protocol ImportantDaysModelDelegate {
    func failWithError(_ error:Error)
}

struct ImportantDaysModel {
    
    var delegate:ImportantDaysModelDelegate!
    
    var countryName:String?
    

    var CountryCode = ["BE":"Belgium","BG":"Bulgaria","CZ":"Czechia","DK":"Denmark","DE":"Germany","EE":"Estonia","IE":"Ireland","EL":"Greece","ES":"Spain","TR":"Turkey"]
    

    
    func performRequest(url:String ,completion: @escaping  ([ImportantDaysData])-> Void) {
        if let url = URL(string:url) {
            let session = URLSession.shared
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate.failWithError(error!)
                }
                if let Sdata = data {
                    let decoder = JSONDecoder()
                    do {
                        let decodingData = try decoder.decode([ImportantDaysData].self, from: Sdata)
                        let data = decodingData
                        completion(data)
                    }catch{
                        delegate.failWithError(error)
                    }
                }
            }
            task.resume()
        }
    }
    
    func getURL() -> String {
        var urlString = ""
        if let Scountry = countryName {
            let url = "https://date.nager.at/api/v2/publicholidays/2022/\(Scountry)"
            urlString = url
        }
        return urlString
    }
}
