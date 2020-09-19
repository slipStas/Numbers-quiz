//
//  ResultsArrayViewController.swift
//  Numbers quiz
//
//  Created by Stanislav Slipchenko on 19.09.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class ResultsArrayViewController: UIViewController {

    @IBOutlet weak var resultsArrayTableView: UITableView!
    
    var resultArray : [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.resultsArrayTableView.dataSource = self
        self.resultsArrayTableView.delegate = self
    }
}

extension ResultsArrayViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension ResultsArrayViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        resultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "resultArrayCell", for: indexPath) as! ResultsArrayTableViewCell
        
        cell.resultTextLabel.text = resultArray[indexPath.row]
        
        return cell
    }
    
    
}
