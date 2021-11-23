//
//  TagsViewController.swift
//  Catty App
//
//  Created by Katerina Ulasik on 11.11.2021.
//

import UIKit

class TagsViewController: UIViewController {

    
    private var tags: [String] = []

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        load()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let nib = UINib(nibName: "TagsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "TagsTableViewCellIdentifier")
        
        self.navigationItem.title = "Catty tags"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
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
                        self.tableView.reloadData()
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

extension TagsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tags.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tag = tags[indexPath.row]
       let cell = tableView.dequeueReusableCell(withIdentifier: "TagsTableViewCellIdentifier", for: indexPath) as! TagsTableViewCell
        
        cell.configure(tag: tag)
        color(cell: cell, for: tag)
                
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let tag = tags[indexPath.row]
        
        loadCatBy(tag: tag)
        save(tag: tag)
        
//        let cell = tableView.dequeueReusableCell(withIdentifier: "TagsTableViewCellIdentifier", for: indexPath)
//        let cell = self.tableView(tableView, cellForRowAt: indexPath)
//        color(cell: cell, for: tag)
        
    }
    
    private func color(cell: UITableViewCell, for tag: String) {
    if let value = get(), value == tag {
        cell.layer.borderColor = UIColor.blue.cgColor
        cell.layer.borderWidth = 3
    } else {
        cell.layer.borderColor = nil
        cell.layer.borderWidth = 0
    }
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

