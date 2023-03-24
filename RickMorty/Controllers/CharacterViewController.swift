//
//  ViewController.swift
//  RickMorty
//
//  Created by Sorin Gore on 21.03.2023.
//

import UIKit
import Foundation
import Apollo
import ApolloAPI
import RickMortySwiftApi

class CharacterViewController: UIViewController, UITableViewDataSource{
    
    

//    private let tableView: UITableView = {
//        let table = UITableView()
//        table.register(UITableViewCell.self,
//                       forCellReuseIdentifier: "cell")
//        return table
//    }()
//
//    let profileImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.backgroundColor = .red
//        return imageView
//    }()
    
    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var nameCharacter: UILabel!
    
    @IBOutlet weak var lastKnownLocation: UILabel!
    @IBOutlet weak var firstSeenIn: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //view.addSubview(tableView)
       // tableView.dataSource = self
        parseJSON()
        
        
    }
    let rmClient = RMClient()

    func parseJSON(){
        let urlString = "https://rickandmortyapi.com/api/character/2"
        
        let url = URL(string: urlString)
        
        guard url != nil else {
            print("error")
            return
        }
        let session = URLSession.shared
        let dataTask = session.dataTask(with: url!) { data, response, error in
            if error == nil, data != nil{
                let decoder = JSONDecoder()
                
                do {
                    let parsingData = try decoder.decode(CharactersResponse.Character.self, from: data!)
                    print(parsingData)
                } catch {
                    print("Parsing error")
                }
            }
                
        }
        dataTask.resume()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       // tableView.frame = view.bounds
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Noroc: sectiune: \(indexPath.section) | row: \(indexPath.row)"
       // cell.imageView?.image = UIImage(named: objectArray[indexPath.section].sectionImages[indexPath.row])

        
        return cell
    }
    
}



