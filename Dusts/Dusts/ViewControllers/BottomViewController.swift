//
//  BottomViewController.swift
//  Dusts
//
//  Created by 조예진 on 2019/12/07.
//  Copyright © 2019 조예진. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class BottomViewController: UIViewController {
  @IBOutlet weak var SeoulLabel: UILabel!
  @IBOutlet weak var KangwonLabel: UILabel!
  @IBOutlet weak var IncheonLabel: UILabel!
  @IBOutlet weak var KyungkiLabel: UILabel!
  @IBOutlet weak var ChungbukLabel: UILabel!
  @IBOutlet weak var SejongLabel: UILabel!
  @IBOutlet weak var ChungnamLabel: UILabel!
  @IBOutlet weak var KyungbukLabel: UILabel!
  @IBOutlet weak var DaejeonLabel: UILabel!
  @IBOutlet weak var DaeguLabel: UILabel!
  @IBOutlet weak var JunbukLabel: UILabel!
  @IBOutlet weak var UlsanLabel: UILabel!
  @IBOutlet weak var KyungnamLabel: UILabel!
  @IBOutlet weak var KyangjuLabel: UILabel!
  @IBOutlet weak var JeonnamLabel: UILabel!
  @IBOutlet weak var BusanLabel: UILabel!
  @IBOutlet weak var JejuLabel: UILabel!

  @IBOutlet weak var dataStackView: UIStackView!
  @IBOutlet weak var segmentControl: UISegmentedControl!
  
  var wholeDataList = BehaviorRelay<[(String, String)]>(value: [])
  private let disposeBag = DisposeBag()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    segmentControl.rx.selectedSegmentIndex
        .asDriver()
        .drive(onNext: { [weak self] (index) in
            guard let self = self else { return }
            guard let title = self.segmentControl.titleForSegment(at: index) else { return }
            let itemCode: String
            if title == "PM2.5" {
                itemCode = "PM25"
            } else {
                itemCode = title
            }
            
          let result = ApiHelper.getWholeDataList(itemCode: itemCode)
              .filter {!$0.isEmpty}
            
            let temp = Observable<WholeData>.create { (observer) in
                result.bind { (list) in
                    print(list)
                    observer.onNext(list.first!)
                }.disposed(by: self.disposeBag)
                return Disposables.create()
            }
            .asDriver(onErrorJustReturn: WholeData.Empty())
            .map { (data) -> Observable<[(String, String)]> in
                    Observable.create { (observer) in
                        var array: [(String, String)] = []
                        for value in
                          WholeData.cities.allCases {
                            array.append((value.rawValue, data[value]))
                        }
                        observer.onNext(array)
                        return Disposables.create()
                    }
            }
          
            temp.drive(onNext: { (list) in
                list.asDriver(onErrorJustReturn: [])
                  .drive(self.wholeDataList)
                    .disposed(by: self.disposeBag)
            }).disposed(by: self.disposeBag)
        }).disposed(by: disposeBag)
    
//    wholeDataList.bind(to: self.dataStackView.rx.items(cellIdentifier: "cell")) { (index: Int, element: (String, String), cell: UITableViewCell) in
//        cell.textLabel?.text = element.0
//        cell.detailTextLabel?.text = element.1
//    }.disposed(by: disposeBag)

  }
}
