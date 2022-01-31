//
//  CharDetailsVC.swift
//  PokemonApp
//
//  Created by Ceren Çapar on 28.01.2022.
//

import UIKit
import SDWebImage


class CharDetailsVC: UIViewController {
    var picsArray = [String?]()
    var statArray = [Stat]()
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var statOne: UILabel!
    @IBOutlet weak var statTwo: UILabel!
    @IBOutlet weak var statThree: UILabel!
    @IBOutlet weak var statFour: UILabel!
    @IBOutlet weak var statFive: UILabel!
    @IBOutlet weak var statSix: UILabel!
    var selected = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegates()
        fetchData()
        navigationSettings()
        
    }

}


extension CharDetailsVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.picsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "pics", for: indexPath) as! PicsCell
        if let urlString = self.picsArray[indexPath.row]{
            let url = URL(string: urlString)
            cell.charImage.sd_setImage(with: url)
        }
        return cell
    }
    
    fileprivate func setDelegates(){
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    fileprivate func fetchData(){
        let url = selected[1]
        Webservice.fetchData(urlString: url,model: Welcome.self) { data in
            DispatchQueue.main.async {
                let desired = data.sprites
                let versionOne = desired.versions?.generationI
                let versionTwo = desired.versions?.generationIi
                let versionThree = desired.versions?.generationIii
                let versionFour = desired.versions?.generationIv
                let versionFive = desired.versions?.generationV
                let versionSeven = desired.versions?.generationVii
                let versionEight = desired.versions?.generationViii
                let array = [desired.frontDefault, desired.backShiny, desired.backDefault, desired.frontShiny, versionOne?.redBlue.backDefault, versionOne?.redBlue.frontDefault, versionOne?.redBlue.backGray, versionOne?.redBlue.backTransparent, versionOne?.redBlue.backDefault, versionOne?.redBlue.frontGray, versionOne?.redBlue.frontTransparent, versionOne?.yellow.frontTransparent, versionOne?.yellow.frontGray, versionOne?.yellow.backDefault, versionOne?.yellow.backTransparent, versionOne?.yellow.backGray, versionOne?.yellow.frontDefault, versionTwo?.crystal.frontShinyTransparent, versionTwo?.crystal.backShinyTransparent, versionTwo?.crystal.frontShiny, versionTwo?.crystal.backShiny, versionTwo?.crystal.frontTransparent, versionTwo?.crystal.backDefault, versionTwo?.crystal.backTransparent, versionTwo?.crystal.frontDefault, versionTwo?.gold.frontShiny, versionTwo?.gold.backShiny, versionTwo?.gold.backDefault, versionTwo?.gold.frontDefault, versionTwo?.silver.frontShiny, versionTwo?.silver.backShiny, versionTwo?.silver.backDefault, versionTwo?.silver.frontDefault, versionTwo?.silver.frontTransparent, versionThree?.fireredLeafgreen.frontShiny, versionThree?.fireredLeafgreen.backShiny, versionThree?.fireredLeafgreen.backDefault, versionThree?.fireredLeafgreen.frontDefault, versionThree?.fireredLeafgreen.frontTransparent, versionThree?.emerald.frontDefault, versionThree?.emerald.frontShiny, versionThree?.rubySapphire.backShiny, versionThree?.rubySapphire.frontShiny, versionThree?.rubySapphire.frontDefault, versionThree?.rubySapphire.backDefault, versionThree?.rubySapphire.frontTransparent, versionFour?.diamondPearl.backDefault, versionFour?.diamondPearl.frontDefault, versionFour?.diamondPearl.frontShiny, versionFour?.diamondPearl.backShiny, versionFour?.diamondPearl.animated?.backShiny, versionFour?.diamondPearl.animated?.frontShiny, versionFour?.diamondPearl.animated?.frontDefault, versionFour?.diamondPearl.animated?.backDefault, versionFour?.heartgoldSoulsilver.backDefault, versionFour?.heartgoldSoulsilver.frontDefault, versionFour?.heartgoldSoulsilver.frontShiny, versionFour?.heartgoldSoulsilver.backShiny, versionFour?.heartgoldSoulsilver.animated?.backShiny, versionFour?.heartgoldSoulsilver.animated?.frontShiny, versionFour?.diamondPearl.animated?.frontDefault, versionFour?.diamondPearl.animated?.backDefault, versionFour?.platinum.backDefault, versionFour?.platinum.frontDefault, versionFour?.platinum.frontShiny, versionFour?.platinum.backShiny, versionFive?.blackWhite.backShiny, versionFive?.blackWhite.frontShiny, versionFive?.blackWhite.frontDefault, versionFive?.blackWhite.backDefault, versionSeven?.icons.frontDefault,versionEight?.icons.frontDefault, versionFour?.diamondPearl.backShinyFemale, versionFour?.diamondPearl.backFemale, versionFour?.diamondPearl.frontFemale, versionFour?.platinum.frontFemale, versionFour?.platinum.backFemale, versionFour?.platinum.backShinyFemale, versionFour?.platinum.frontShinyFemale]
                self.picsArray = array
                self.statArray = data.stats
                self.setLabels()
                self.collectionView.reloadData()
            }
        }
    }
    
    fileprivate func setLabels(){
        self.statOne.text = "\(self.statArray[0].stat.name.capitalizingFirstLetter())"+" : "+"\(self.statArray[0].baseStat)"
        self.statTwo.text = "\(self.statArray[1].stat.name.capitalizingFirstLetter())"+" : "+"\(self.statArray[1].baseStat)"
        self.statThree.text = "\(self.statArray[2].stat.name.capitalizingFirstLetter())"+" : "+"\(self.statArray[2].baseStat)"
        self.statFour.text = "\(self.statArray[3].stat.name.capitalizingFirstLetter())"+" : "+"\(self.statArray[3].baseStat)"
        self.statFive.text = "\(self.statArray[4].stat.name.capitalizingFirstLetter())"+" : "+"\(self.statArray[4].baseStat)"
        self.statSix.text = "\(self.statArray[5].stat.name.capitalizingFirstLetter())"+" : "+"\(self.statArray[5].baseStat)"
    }
    
    fileprivate func navigationSettings() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "< Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(goBack))
        navigationItem.title = self.selected[0].capitalizingFirstLetter()
    }
    @objc func goBack(){
        navigationController?.popViewController(animated: true)
    }
}
