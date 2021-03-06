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
            self.leaderBoardTableView.delegate = self
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

extension LeaderBoardViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
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
        
        cell.score.text = "Score: "
        cell.trueCount.text = String(record.trueAnswers )
        cell.slash.text = " / "
        cell.falseCount.text = String(record.falseAnswers )
        cell.dateLabel.text = dateFormatter.string(from: record.date )
        cell.difficulty.text = "  difficulty - \(record.difficulty)"
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let identifier = segue.identifier, identifier == "array of results" {
            if let destinationVC = segue.destination as? ResultsArrayViewController {
                
                let recordsInRow : GameResultModel = self.records[leaderBoardTableView.indexPathForSelectedRow!.row]
                destinationVC.resultArray = recordsInRow.mathSolutions
            }
        }
    }
}
