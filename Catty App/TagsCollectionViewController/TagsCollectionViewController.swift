//
//  TagsCollectionViewController.swift
//  Catty App
//
//  Created by Katerina Ulasik on 07.12.2021.
//

import UIKit

class TagsCollectionViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    private var tags: [String] = []
    private var selectedTags: [String] = []
    
    func addToFavorites(tag: String) {
        selectedTags.append(tag)
        save()
    }
    
    func removeFromFavorites(tag: String) {
        guard let index = selectedTags.firstIndex(of: tag) else { return }
        
        selectedTags.remove(at: index)
        save()
    }
    
    private func save() {
        UserDefaults.standard.setValue(selectedTags, forKey: "My_Hidden_key")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      collectionView.delegate = self
      collectionView.dataSource = self
        
      let collectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView.collectionViewLayout = collectionViewFlowLayout
        collectionViewFlowLayout.minimumLineSpacing = 50
        
        collectionView.layer.cornerRadius = 0
        collectionView.layer.borderWidth = 1
        
//        UICollectionViewCell.layer.cornerRadius = 10
//        cell.layer.masksToBounds = true
//        self.contentView.layer.borderColor = UIColor.clear.cgColor
//        self.contentView.layer.masksToBounds = true
        
        collectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 50, height: 60)
        
        collectionView.collectionViewLayout = collectionViewFlowLayout
        
      collectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CustomCollectionViewCell")
       
        load()
        
        self.selectedTags = (UserDefaults.standard.value(forKey: "My_Hidden_key") as? [String]) ?? []
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
        let isSelected = selectedTags.contains { someTag in
            return someTag == tag
        }
        cell.configure(tag: tag, isSelected: isSelected, parentViewController: self)
        
        return cell
    }
    
    
//
//    func collectionView(_ collectionView: UICollectionView, cellForRowAt indexPath: IndexPath) -> UICollectionViewCell {
//        let tag = tags[indexPath.section]
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCollectionViewCell", for: indexPath) as! TagsCollectionViewController
//
//             cell.backgroundColor = UIColor.clear
//             cell.layer.borderColor = UIColor.black.cgColor
//             cell.layer.borderWidth = 2
//             cell.layer.cornerRadius = 14
//             cell.clipsToBounds = true
//
//        cell.configure(tag: tag)
////        color(cell: cell, for: tag)
//
//        return cell
//    }
    
    
    
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
