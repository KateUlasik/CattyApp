//
//  TagsCollectionViewController.swift
//  Catty App
//
//  Created by Siarhei Siliukou on 6.12.21.
//

import UIKit

class TagsCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var tags: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionViewFlowLayout.minimumLineSpacing = 50
        collectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 10, height: 50)
        
        collectionView.collectionViewLayout = collectionViewFlowLayout
        
        collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCollectionViewCell")
        
        load()
        
    }
    
    private func load() {
        guard let url = URL(string: "https://cataas.com/api/tags") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let object = try decoder.decode([String].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.tags = object.filter({ (tag) -> Bool in
                            return tag.isEmpty == false
                        })
                        self.collectionView.reloadData()
                    }
                } catch {
                    DispatchQueue.main.async {
                        //                        self.tableView.text = "Can't decode data"
                    }
                }
            } else {
                
                DispatchQueue.main.async {
                    //                    self.tableView.text = "Something went wrong"
                }
            }
        }.resume()
        
        
    }
}


extension TagsCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! CustomCollectionViewCell
        
        let tag = tags[indexPath.row]
        cell.configure(tag: tag)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tag = tags[indexPath.row]
        
        loadCatBy(tag: tag)
        save(tag: tag)
        
    }

    private func save(tag: String?) {
        UserDefaults.standard.set(tag, forKey: "user_default_favorite_key")
    }
    
    private func get() -> String? {
        return UserDefaults.standard.value(forKey: "user_default_favorite_key") as? String
    }
    
    private func loadCatBy(tag: String) {
        guard let url = URL(string: "https://cataas.com/cat/\(tag)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    let image = UIImage(data: data)
                    let vc = CattyDetailsViewController(nibName: nil, bundle: nil)
                    
                    vc.configure(image: image)
                    
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                }
            } else {
                print("Plese reload data")
            }
        }.resume()
    }
}
