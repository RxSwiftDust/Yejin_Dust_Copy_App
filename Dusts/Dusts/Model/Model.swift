//
//  Model.swift
//  Dusts
//
//  Created by 조예진 on 2019/12/07.
//  Copyright © 2019 조예진. All rights reserved.
//

import Foundation

struct StationData: Codable {
  let coGrade: String
  let coValue: String
  let dataTime: String
  let khaiGrade: String
  let khaiValue: String
  let mangName: String
  let no2Grade: String
  let no2Value: String
  let numOfRows: String
  let o3Grade: String
  let o3Value: String
  let pageNo: String
  let pm10Grade: String
  let pm10Grade1h: String
  let pm10Value: String
  let pm10Value24: String
  let pm25Grade: String
  let pm25Grade1h: String
  let pm25Value: String
  let pm25Value24: String
  let so2Grade: String
  let so2Value: String
}

struct StationDataList: Codable {
  let list: [StationData]
}

struct WholeData: Codable {
  enum cities: String, CaseIterable {
    case daegu = "대구"
    case daejeon = "대전"
    case gangwon = "강원"
    case gwangju = "광주"
    case gyeongbuk = "경북"
    case gyeonggi = "경기도"
    case gyeongnam = "경남"
    case incheon = "인천"
    case jeju = "제주"
    case jeonbuk = "전북"
    case jeonnam = "전남"
    case sejong = "세종"
    case seoul = "서울"
    case ulsan = "울산"
  }
  
  var dataTime: String?
  var daegu: String?
  var daejeon: String?
  var gangwon: String?
  var gwangju: String?
  var gyeongbuk: String?
  var gyeonggi: String?
  var gyeongnam: String?
  var incheon: String?
  var jeju: String?
  var jeonbuk: String?
  var jeonnam: String?
  var sejong: String?
  var seoul: String?
  var ulsan: String?
  
  static func Empty() -> WholeData {
    return WholeData()
  }
  
  subscript(city: cities) -> String {
    switch city {
    case .daegu:
      return daegu ?? "0"
    case .daejeon:
      return daejeon ?? "0"
    case .gangwon:
      return gangwon ?? "0"
    case .gwangju:
      return gwangju ?? "0"
    case .gyeongbuk:
      return gyeongbuk ?? "0"
    case .gyeonggi:
      return gyeonggi ?? "0"
    case .gyeongnam:
      return gyeongnam ?? "0"
    case .incheon:
      return incheon ?? "0"
    case .jeju:
      return jeju ?? "0"
    case .jeonbuk:
      return jeonbuk ?? "0"
    case .jeonnam:
      return jeonnam ?? "0"
    case .sejong:
      return sejong ?? "0"
    case .seoul:
      return seoul ?? "0"
    case .ulsan:
      return ulsan ?? "0"
    @unknown default:
      return "0"
    }
  }
}

struct WholeDataList: Codable {
  let list: [WholeData]
}
