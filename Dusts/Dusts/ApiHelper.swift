//
//  ApiHelper.swift
//  Dusts
//
//  Created by 조예진 on 2019/12/07.
//  Copyright © 2019 조예진. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class ApiHelper {
  static func getStationList(stationName: String) -> Observable<[StationData]> {
    return apiRequest(pathComponent: "getMsrstnAcctoRltmMesureDnsty",
                      params: [("numOfRows", "1"), ("pageNo", "1"), ("stationName", stationName), ("dataTerm", "DAILY"), ("ver", "1.3"), ("_returnType", "json")])
      .map { data in
        return (try JSONDecoder().decode(StationDataList.self, from: data)).list
    }
  }
  
  static func getWholeDataList(itemCode: String = "PM25") -> Observable<[WholeData]> {
    return apiRequest(pathComponent: "getCtprvnMesureLIst",
                      params: [("numOfRows", "1"), ("pageNo", "1"), ("itemCode", itemCode), ("dataGubun", "HOUR"), ("searchCondition", "MONTH"), ("ver", "1.3"), ("_returnType", "json")])
      .map { data in
        return try JSONDecoder().decode(WholeDataList.self, from: data).list
    }
  }
  
  static private func apiRequest(method: String = "GET",
                                 pathComponent: String,
                                 params: [(String, String)]) -> Observable<Data> {
    let url = DustService.baseURL.appendingPathComponent(pathComponent)
    var request = URLRequest(url: url)
    let keyQueryItem = URLQueryItem(name: "ServiceKey", value: DustService.apiKey)
    let urlComponents = NSURLComponents(url: url, resolvingAgainstBaseURL: true)!
    
    if method == "GET" {
      var queryItems = params.map { URLQueryItem(name: $0.0, value: $0.1) }
      queryItems.append(keyQueryItem)
      urlComponents.queryItems = queryItems
    } else {
      urlComponents.queryItems = [keyQueryItem]
      let jsonData = try! JSONSerialization.data(withJSONObject: params, options: .prettyPrinted)
      request.httpBody = jsonData
    }
    
    request.url = urlComponents.url!
    request.httpMethod = method
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    let session = URLSession.shared
    return session.rx.data(request: request)
  }
}
