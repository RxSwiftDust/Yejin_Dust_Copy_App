//
//  BottomCell.swift
//  Dusts
//
//  Created by 조예진 on 2019/12/07.
//  Copyright © 2019 조예진. All rights reserved.
//

import UIKit
class BottomCell: UICollectionViewCell {
  
  @IBOutlet weak var dataLabel: UILabel!
  @IBOutlet weak var dataStatus: UILabel!
  @IBOutlet weak var dataNumber: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
  }
  
  public func configure(with model: CellData) {
    dataLabel.text = model.dataName
    dataStatus.text = model.dataStatus
    dataNumber.text = model.dataNumber
  }
}

struct CellData {
  let dataName: String
  let dataStatus: String
  let dataNumber: String
}
