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
    
    var countryCode = [
        "Belgium","Bulgaria","Czechia","Denmark","Germany","Estonia","Ireland","Greece", "Spain","France","Croatia","Italy","Cyprus","Latvia","Lithuania","Luxembourg","Hungary","Malta",   "Netherlands","Austria","Poland","Portugal","Romania","Slovenia","Slovakia","Finland","Sweden","Iceland","Liechtenstein","Norway","Switzerland","United Kingdom","Bosnia and Herzegovina","Montenegro","Moldova","North Macedonia ","Albania","Serbia","Türkiye","Ukraine","Kosovo","Georgia","Armenia","Belarus","Jordan","Russia"]
    
    var arr = ["BE","BG","CZ","DK","DE","EE","IE","EL", "ES","FR","HR","IT","CY","LV","LT","LU","HU","MT",   "NL","AT","PL","PT","RO","SI","SK","FI","SE","IS","LI","NO","CH","UK","BA","ME","MD","MK","AL","RS","TR","UA","XK","GE","AM","BY","JO","RU"]
    

    
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
