//
//  ViewController.swift
//  PokemonApp
//
//  Created by Ceren Çapar on 28.01.2022.
//

import UIKit
import FirebaseAnalytics

class CharListVC: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var charList = [Result]()
    private var offSetNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        fetchDatas()
    }
}


extension CharListVC: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CharNameCell
        if indexPath.row == self.charList.count-2{
            fetchDatas()
        }
        cell.charNameLabelField.text = charList[indexPath.row].name.capitalizingFirstLetter()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Analytics.logEvent("tapped_index", parameters: ["indexRow" : indexPath.row])
        let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "details") as! CharDetailsVC
        secondViewController.selected = [charList[indexPath.row].name,charList[indexPath.row].url]
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    fileprivate func setDelegates(){
        tableView.delegate = self
        tableView.dataSource = self
    }
    fileprivate func fetchDatas(){
        let url = DataUrl.baseUrl+DataUrl.offSet+"\(offSetNumber)"+DataUrl.limit
        Webservice.fetchData(urlString: url, model: Characters.self) { results in
            DispatchQueue.main.async {
                for data in results.results{
                    self.charList.append(data)
                    self.tableView.reloadData()
                }
            }
        }
        offSetNumber = offSetNumber+20
    }
}
