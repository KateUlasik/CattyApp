//
//  TagsViewController.swift
//  Catty App
//
//  Created by Siarhei Siliukou on 10.11.21.
//

import UIKit

class TagsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private var tags: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        load()
        
        tableView.delegate = self
        tableView.dataSource = self
    }

    private func load() {
        guard let url = URL(string: "https://cataas.com/api/tags") else { return }
            
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let decoder = JSONDecoder()
                    let object = try decoder.decode([String].self, from: data)
                    
                    DispatchQueue.main.async {
                        self.tags = object
                        self.tableView.reloadData()
                    }
                } catch {
                    DispatchQueue.main.async {
                        //self.textView.text = "Can't decose data..."
                    }
                }
            } else {
                DispatchQueue.main.async {
                    //self.textView.text = "Something went wrong..."
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
        let cell = UITableViewCell()
        let label = UILabel(frame: .zero)
        let tag = tags[indexPath.row]
        
        
        label.text = (tag.isEmpty ? "All cats" : tag )
        label.translatesAutoresizingMaskIntoConstraints = false
        
        cell.contentView.addSubview(label)
        cell.translatesAutoresizingMaskIntoConstraints = false
        
        cell.contentView.leadingAnchor.constraint(equalTo: label.leadingAnchor, constant: -15).isActive = true
        cell.contentView.trailingAnchor.constraint(equalTo: label.trailingAnchor, constant: 15).isActive = true
        cell.contentView.topAnchor.constraint(equalTo: label.topAnchor, constant: -15).isActive = true
        cell.contentView.bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 15).isActive = true
        
        label.layer.borderWidth = 2
        label.layer.borderColor = UIColor.red.cgColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
