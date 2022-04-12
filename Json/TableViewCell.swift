//
//  TableViewCell.swift
//  Json
//
//  Created by lakshmi Raghavendra on 02/03/21.
//

import UIKit

//protocol NewTableCell {
//    func onClickCell(tag:Int)
//}
class TableViewCell: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var clickBtn: UIButton!
    
   // var cellDelegate:NewTableCell?
    var index:IndexPath?
    //var tapBlock: (() -> Void)? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func clickBtn(_ sender: UIButton) {
        //cellDelegate?.onClickCell(tag: sender.tag)
       // tapBlock?()
//        if clickBtn.isSelected {
//            clickBtn.isSelected = false
//        }
//        else {
//            clickBtn.isSelected = true
//        }
        clickBtn.isSelected = !clickBtn.isSelected
    }
    
}
