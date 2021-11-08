//
//  ViewController.swift
//  injecttest
//
//  Created by Berkin Tatlısu on 30.10.2021.
//

import UIKit

class DummyViewController: UIViewController, Base {
    static var storyboardName: String = "Main"
    
    var viewmodel: DummyViewModel?
    
    var dummyCache: CacheProtocol?
    
    @IBOutlet var collection: UICollectionView!
    
    @IBOutlet weak var roonnumber: UITextField!
    @IBAction func nexttochat(_ sender: Any) {
        ChatViewController.roomNo = roonnumber.text!
    }
    var data: [Tag] = [
        Tag(name: "#NFT"),
        Tag(name: "#meta"),
        Tag(name: "#doge"),
        Tag(name: "#shib"),
        Tag(name: "#ibm"),
        Tag(name: "#nvidia"),
        Tag(name: "#creative"),
        Tag(name: "#kernel"),
        Tag(name: "#android"),
        Tag(name: "#ios"),
        Tag(name: "#bitcoin"),
        Tag(name: "#ether"),
    ]
    @IBOutlet var selectRoom: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //collection = UICollectionView()
        collection.dataSource = self
        collection.delegate = self
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        dummyCache?.pull(msg:"call from ViewController")
    }
    
}

extension DummyViewController :UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectRoom.text = data[indexPath.row].toString()
        
    }
}

extension DummyViewController :UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collection.dequeueReusableCell(withReuseIdentifier: "cviewcell", for: indexPath) as! CVCell
        cell.tage.setTitle(data[indexPath.row].toString(), for: .normal)
        
        return cell
    }
}

extension DummyViewController:UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        return CGSize(width:95, height: 45)
        
    }
}

