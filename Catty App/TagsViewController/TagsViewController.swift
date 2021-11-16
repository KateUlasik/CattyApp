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
        
//        first method
        
//        let cell = UITableViewCell()
//        let label = UILabel(frame: .zero)
//        let tag = tags[indexPath.row]
        
//        label.text = tag
//        label.translatesAutoresizingMaskIntoConstraints = false
//
//        cell.contentView.addSubview(label)
//        cell.translatesAutoresizingMaskIntoConstraints = false
//
//        cell.contentView.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: -15).isActive = true
//        cell.contentView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 15).isActive = true
//        cell.contentView.topAnchor.constraint(equalTo: label.topAnchor, constant: -15).isActive = true
//        cell.contentView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 15).isActive = true
//
//        label.layer.borderWidth = 3
//        label.layer.borderColor = UIColor.purple.cgColor
        
//        second method
    
        let tag = tags[indexPath.row]
       let cell = tableView.dequeueReusableCell(withIdentifier: "TagsTableViewCellIdentifier", for: indexPath) as! TagsTableViewCell
        
        cell.configure(tag: tag)
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tag = tags[indexPath.row]
        
        guard let url = URL(string: "https://cataas.com/cat\(tag)") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data {
                DispatchQueue.main.async {
                    let vc = CattyDetailsViewController(nibName: nil, bundle: nil)
                    
                    self.present(vc, animated: true, completion: {
                       let image = UIImage(data: data)
                        vc.catsImageView.image = image
                    })
                }
            } else {
                print("Plese reload data")
            }
        }.resume()
        
        
    }
    }

