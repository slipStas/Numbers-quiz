//
//  LeaderBoardViewController.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 08.08.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class LeaderBoardViewController: UIViewController {

    @IBOutlet weak var leaderBoardTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.leaderBoardTableView.dataSource = self
    }
    
}

extension LeaderBoardViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = leaderBoardTableView.dequeueReusableCell(withIdentifier: "leaderboardCell", for: indexPath) as! LeaderBoardTableViewCell
        
        cell.resultLabel.text = "number " + String(indexPath.row)
        cell.dateLabel.text = "date of the game"
        
        return cell
    }
    
    
}
