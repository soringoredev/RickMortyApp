//
//  ViewController.swift
//  RickMorty
//
//  Created by Sorin Gore on 21.03.2023.
//


import UIKit
import Foundation
import Apollo

class CharacterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var characterView: CharacterTableViewCell?
    var characters = [CharactersResponse.Character]()
    
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.register(CharacterTableViewCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        table.delegate = self
        parseJSON()
        
    }
    
    
    
    func parseJSON() {
            let urlString = "https://rickandmortyapi.com/api/character/"
            let url = URL(string: urlString)!
            
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    print("Error fetching character: \(error)")
                    return
                }
                
                guard let data = data else {
                    print("No data received")
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(CharactersResponse.self, from: data)
                    self.characters = response.results
                    DispatchQueue.main.async {
                        //self.characterView?.nameLabel.text = response.results
                      //  self.characterView?.nameLabel.text = response.results
                       // print(character.name)
                    
                  //      self.characterView.lastKnownLocationLabel.text = character.location.name
                    }
                } catch {
                    print("Error decoding character: \(error)")
                }
            }.resume()
        }
        
        func loadImage(from url: URL) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    print("Error fetching image: \(error)")
                    return
                }
                
                guard let data = data else {
                    print("No image data received")
                    return
                }
                
                DispatchQueue.main.async {
                    self.characterView?.characterImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       // tableView.frame = view.bounds
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.endIndex
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CharacterTableViewCell else {
            fatalError("Failed to dequeue CharacterTableViewCell")
        }
        
        let character = characters[indexPath.row]
        cell.textLabel?.text = character.name
        cell.imageView?.image = nil
        
        if let url = URL(string: character.image) {
            loadImage(from: url) { image in
                cell.imageView?.image = image
                cell.setNeedsLayout()
            }
        }
        
        return cell
    }
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error fetching image: \(error)")
                completion(nil)
                return
            }
            guard let data = data else {
                print("No image data received")
                completion(nil)
                return
            }
            DispatchQueue.main.async {
                let image = UIImage(data: data)
                completion(image)
            }
        }.resume()
    }

    
}
