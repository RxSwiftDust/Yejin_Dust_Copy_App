//
//  TopViewController.swift
//  Dusts
//
//  Created by 조예진 on 2019/12/07.
//  Copyright © 2019 조예진. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class TopViewController: UIViewController {
  
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var pm25Label: UILabel!
  @IBOutlet weak var gradeLabel: UILabel!
  @IBOutlet weak var bottomCollectionView: UICollectionView!
  
  private let disposeBag = DisposeBag()
  var stationName = BehaviorRelay<String>(value: "관악구")
  
  override func viewDidLoad() {
    super.viewDidLoad()
    bottomCollectionView.delegate = self
    bottomCollectionView.dataSource = self
  }
  
  private func setupRx() {
    // station name label 채우기
    stationName
      .asDriver(onErrorJustReturn: "관악구")
      .drive(nameLabel.rx.text)
      .disposed(by: disposeBag)
    
    // station data 받아오기
    let stationData = stationName
      .flatMapLatest { (stationName) ->  Observable<[StationData]>  in
        return ApiHelper.getStationList(stationName: "관악구")
    }
    .filter { !$0.isEmpty }
    .asDriver(onErrorJustReturn: [])
    
    // 시간정보
    stationData.map { (datas) -> String in
      guard let data = datas.first else { return "정보없음" }
      let formatter = DateFormatter()
      formatter.dateFormat = "yyyy-MM-dd HH:mm"
      guard let date = formatter.date(from: data.dataTime) else { return "정보없음" }
      formatter.amSymbol = "오전"
      formatter.pmSymbol = "오후"
      formatter.dateFormat = "a hh:mm"
      return formatter.string(from: date)
    }.drive(timeLabel.rx.text)
     .disposed(by: disposeBag)
    
  }
  
}

extension TopViewController: UICollectionViewDelegate, UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 1
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    var cell: BottomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath) as! BottomCell
    // cell.configure()
    return cell
  }
}
