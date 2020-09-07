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
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "HH:mm:ss  EEE, d MMM yyyy"
        
        cell.resultLabel.text = String(record.value ?? 0)
        cell.dateLabel.text = dateFormatter.string(from: record.date ?? Date()) 
        
        return cell
    }
    
    
}
