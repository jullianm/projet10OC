//
//  DetailedRecipesViewController.swift
//  Reciplease
//
//  Created by jullianm on 14/12/2017.
//  Copyright © 2017 jullianm. All rights reserved.
//

import UIKit
import SafariServices
import CoreData

class DetailedRecipesViewController: UIViewController {

    @IBOutlet weak var recipeCookingTime: UILabel!
    @IBOutlet weak var recipeRating: UILabel!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var detailedPortions: UITableView!
    @IBOutlet weak var favoritesButton: UIBarButtonItem!
    @IBOutlet weak var recipeImage: UIImageView!
    
    var recipes = [RecipeInformations]()
    var selectedRecipe = Int()
    let gradientLayer: CAGradientLayer = {
        let layer = CAGradientLayer()
        layer.colors = [
            UIColor.clear.cgColor,
            UIColor.black.cgColor
        ]
        layer.locations = [0.7, 1]
        return layer
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.detailedPortions.dataSource = self
        recipeImage.layer.addSublayer(gradientLayer)
        gradientLayer.frame = recipeImage.bounds
        self.title = "Reciplease"
    }
    override func viewDidLayoutSubviews() {
        gradientLayer.frame = recipeImage.bounds
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        let backItem = UIBarButtonItem()
        backItem.title = "Back"
        navigationItem.backBarButtonItem = backItem
    }
    
    @IBAction func didTapFavorites(_ sender: UITapGestureRecognizer) {
        if favoritesButton.tintColor == #colorLiteral(red: 0.2673686743, green: 0.5816780329, blue: 0.3659712374, alpha: 1) {
            return
        } else {
        favoritesButton.tintColor = #colorLiteral(red: 0.2673686743, green: 0.5816780329, blue: 0.3659712374, alpha: 1)
        Save.recipe(from: recipes, at: selectedRecipe)
    }
    }
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    @IBAction func getDirections(_ sender: UIButton) {
        let url = recipes[selectedRecipe].instructions
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
    }
}
extension DetailedRecipesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes[selectedRecipe].portions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailed_portion") as! DetailedPortionCell
        cell.portion.text = "- " + recipes[selectedRecipe].portions[indexPath.item]
        recipeImage.image = UIImage(data:recipes[selectedRecipe].image)
        recipeName.text = recipes[selectedRecipe].name
        recipeRating.text = recipes[selectedRecipe].rating
        recipeCookingTime.text = recipes[selectedRecipe].time
        return cell
    }
}
