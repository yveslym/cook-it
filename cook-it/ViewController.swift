//
//  ViewController.swift
//  cook-it
//
//  Created by Yves Songolo on 4/11/19.
//  Copyright © 2019 Yves Songolo. All rights reserved.
//

import UIKit
import Kingfisher

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var recipeTableView: UITableView!
    
    var recipes = [Recipe](){
        didSet{
            DispatchQueue.main.async {
                self.recipeTableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let recipeCell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TestTableViewCell
        let recipe = recipes[indexPath.row]
        
        recipeCell.foodName.text = recipe.title
        let url = URL.init(string: "https://spoonacular.com/recipeImages/\(recipe.imageUrls?.first ?? "")")
        let imageLink = ImageBaseLink.recipe( .medium, recipe.id)
        let imageURL = URL.init(string: imageLink.imageLink)
        recipeCell.foodImage.kf.indicatorType = .activity
        recipeCell.foodImage.kf.setImage(with: url!)
        
        return recipeCell
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let user = User.current
        login()
        //getData()
        
    }
    
    func login (){
        let user = User.init(firstName: "yves", lastName: "Songolo", username: "yveslym", id: "")
        let service = UserService()
//        service.signIn(user)
    }

    func getData() {
        
        Network.FoodApi(service: .searchRecipe(query: "chicken")) { (result) in
            switch result{
                
            case .success(let food):
                
                print(food)
                self.recipes = food as! [Recipe]
                
            case .failure(let error):
                print(error)
            }
        }
        
        Network.FoodApi(service: .recipeInformation(id: 892046)) { (result) in
            print(result)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

}

