//
//  LeaderBoardViewController.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 08.08.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class LeaderBoardViewController: UIViewController {

    @IBOutlet weak var leaderBoardTableView: UITableView! {
        didSet {
            self.leaderBoardTableView.dataSource = self
        }
    }
    
    private var records: [GameResultModel]  = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let results = try? GameRecordsCaretaker.shared.loadResult()  else {return}
        self.records = results
        records.reverse()
        
        self.leaderBoardTableView.reloadData()
    }
}

extension LeaderBoardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        records.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = leaderBoardTableView.dequeueReusableCell(withIdentifier: "leaderboardCell", for: indexPath) as! LeaderBoardTableViewCell
        
        let record = records[indexPath.row]
        
        let dateFormatter = DateFormatter()
        dateFormatter.timeStyle = DateFormatter.Style.medium
        dateFormatter.dateStyle = DateFormatter.Style.medium
        /// for russian language
        /// dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "HH:mm  EEE, d MMMM"
        
        cell.Score.text = "Score: "
        cell.trueCount.text = String(record.trueAnswers ?? 0)
        cell.slash.text = " / "
        cell.falseCount.text = String(record.falseAnswers ?? 0)
        cell.dateLabel.text = dateFormatter.string(from: record.date ?? Date())
        
        return cell
    }
}
