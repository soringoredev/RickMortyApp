//
//  ViewController.swift
//  RickMorty
//
//  Created by Sorin Gore on 21.03.2023.
//


import UIKit
import Foundation
import Apollo
import CLTypingLabel

class CharacterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    var characterView: CharactersTableViewCell?
    var characters = [CharactersResponse.Character]()
    var episodes: [String: EpisodesResponse.Episode] = [:]


    
    @IBOutlet weak var table: UITableView!
    
    var nameCharacter: CLTypingLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Rick and Morty"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        table.register(CharactersTableViewCell.self, forCellReuseIdentifier: "cell")
        table.dataSource = self
        table.delegate = self
        table.register(UINib(nibName: "CharactersTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
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
                 //   self.characters = response.name
                    DispatchQueue.main.async {
                        self.characters = response.results
//                        self.characterView?.firstSeenInLabel.text = response.location.name
//                        self.characterView?.nameLabel.text = response.name
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

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.endIndex
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CharactersTableViewCell else {
            fatalError("Failed to dequeue CharacterTableViewCell")
        }
        cell.backgroundColor = UIColor(red: 235/255, green: 248/255, blue: 184/255, alpha: 1.0)
        let character = characters[indexPath.row]
      
        cell.nameLabel?.text = character.name
        cell.lastKnownLocationLabel?.text = character.location.name
        cell.characterImageView?.image = nil
        cell.statusLabel.text = character.status
        
        if character.status == "Alive" {
                cell.statusLabel.textColor = UIColor(red: 3/255, green: 156/255, blue: 26/255, alpha: 1.0)
            } else if character.status == "Dead" {
                cell.statusLabel.textColor = .red
            } else {
                cell.statusLabel.textColor = .black
            }

        if let url = URL(string: character.image) {
            loadImage(from: url) { image in
                cell.characterImageView?.image = image
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
