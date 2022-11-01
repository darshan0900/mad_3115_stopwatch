//
//  StopwatchFlagCell.swift
//  stopwatch
//
//  Created by Darshan Jain on 2022-11-01.
//

import UIKit

class StopwatchFlagCell: UITableViewCell {

	@IBOutlet weak var index: UILabel!
	@IBOutlet weak var timeDifference: UILabel!
	@IBOutlet weak var flagTime: UILabel!
	
	override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
