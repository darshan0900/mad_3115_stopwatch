//
//  ViewController.swift
//  stopwatch
//
//  Created by Darshan Jain on 2022-11-01.
//

import UIKit

struct Flag {
	let index: Int
	let timeDifference: Int
	let flagTime: Int
}

enum State {
	case Play
	case Pause
	case Stop
}

class ViewController: UIViewController {
	
	@IBOutlet weak var stopwatchLabel: UILabel!
	@IBOutlet weak var startButton: UIButton!

	@IBOutlet weak var actionButtonStack: UIStackView!
	@IBOutlet weak var leftActionButton: UIButton!
	@IBOutlet weak var rightActionButton: UIButton!
	
	@IBOutlet weak var flagsTable: UITableView!
	
	private var flags: [Flag] = []
	private var timer: Timer?
	private var timeEllapsed: Int = 0
	private var currentState = State.Stop
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view.
	}

	
	@IBAction func onStartPress(_ sender: UIButton) {
		startTimer()
		startButton.isHidden = true
		actionButtonStack.isHidden = false
		currentState = .Play
	}
	
	@IBAction func onLeftActionButtonPress(_ sender: UIButton) {
		if currentState == .Play{
			// Click on Flag button
			
			var timeDifference = 0
			
			if let firstRow = flags.first{
				timeDifference = timeEllapsed - firstRow.timeDifference
			}
			
			flags.insert(Flag(index: flags.count, timeDifference: timeDifference, flagTime: timeEllapsed), at: 0)
			
		} else {
			// Click on Stop button
			endTimer()
			timeEllapsed = 0
			startButton.isHidden = false
			actionButtonStack.isHidden = true
			currentState = .Stop
			stopwatchLabel.text = "00:00:00"
			flags.removeAll()
		}
		
		flagsTable.reloadData()
	}
	
	@IBAction func onRightActionButtonPress(_ sender: UIButton) {
		if currentState == .Play{
			// Click on Pause button
			onPause()
		} else {
			// Click on Play button
			onPlay()
		}
	}
	
	func onPlay() {
		startTimer()
		
		leftActionButton.setTitle("Flag", for: .normal)
		leftActionButton.setTitleColor(UIColor(named: "linkColor"), for: .normal)
		
		rightActionButton.setTitle("Pause", for: .normal)
		rightActionButton.setTitleColor(UIColor(named: "halloweenColor"), for: .normal)
		
		currentState = .Play
	}
	
	func onPause() {
		endTimer()
		
		leftActionButton.setTitle("Stop", for: .normal)
		leftActionButton.setTitleColor(UIColor(named: "systemRedColor"), for: .normal)
		
		rightActionButton.setTitle("Play", for: .normal)
		rightActionButton.setTitleColor(UIColor(named: "linkColor"), for: .normal)
		
		currentState = .Pause
	}
	
	private func startTimer( ){
		endTimer()
		timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true){_ in
			self.timeEllapsed+=1
			self.stopwatchLabel.text = self.formatTimeLabel(timeEllapsed: self.timeEllapsed)
		}
	}
	
	func endTimer()  {
		timer?.invalidate()
	}
	
	private func formatTimeLabel (timeEllapsed: Int) ->String{
		let minutes = timeEllapsed / 100 / 60
		let seconds = timeEllapsed / 100
		let milliseconds = timeEllapsed % 100
		
		return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
	}
	
}

extension ViewController: UITableViewDataSource{
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return flags.count
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: "stopwatchFlag") as! StopwatchFlagCell
		let data = flags[indexPath.row]
		cell.index.text = "\(data.index)"
		cell.timeDifference.text = "+\(formatTimeLabel(timeEllapsed: data.timeDifference))"
		cell.flagTime.text = "\(formatTimeLabel(timeEllapsed: data.flagTime))"
		return cell
	}
}
