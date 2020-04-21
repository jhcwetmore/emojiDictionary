//
//  EmojiTableTableViewController.swift
//  EmojiDictionary
//
//  Created by Jonathan Wetmore on 4/20/20.
//  Copyright © 2020 Jonathan Wetmore. All rights reserved.
//

import UIKit

class EmojiTableTableViewController: UITableViewController {
    var emojisFaces: [Emoji] = [
       Emoji(symbol: "😀", name: "Grinning Face",
       description: "A typical smiley face.", usage: "happiness"),
       Emoji(symbol: "😕", name: "Confused Face", description: "A confused, puzzled face.", usage: "unsure what to think; displeasure"),
       Emoji(symbol: "😍", name: "Heart Eyes", description: "A smiley face with hearts for eyes.", usage: "love of something; attractive")
        ]
     var emojisPeople: [Emoji] = [
       Emoji(symbol: "👮", name: "Police Officer", description: "A police officer wearing a blue cap with a gold badge.", usage: "person of authority"),
        ]
     var emojisAnimals: [Emoji] = [
       Emoji(symbol: "🐢", name: "Turtle", description: "A cute turtle.", usage: "Something slow"),
       Emoji(symbol: "🐘", name: "Elephant", description: "A gray elephant.", usage:"good memory")
        ]
     var emojisFood: [Emoji] = [
       Emoji(symbol: "🍝", name: "Spaghetti", description: "A plate spaghetti.", usage: "spaghetti")
        ]
    
     var emojisSymbol: [Emoji] = [
       Emoji(symbol: "🎲", name: "Die", description: "A single die.", usage: "taking a risk, chance; game"),
       Emoji(symbol: "⛺️", name: "Tent", description: "A small tent.", usage: "camping"),
       Emoji(symbol: "📚", name: "Stack of Books", description: "Three colored books stacked on each other.", usage: "homework, studying"),
       Emoji(symbol: "💔", name: "Broken Heart", description: "A red, broken heart.", usage: "extreme sadness"),
       Emoji(symbol: "💤", name: "Snore", description: "Three blue \'z\'s.", usage: "tired, sleepiness")
        ]
    
     var emojisFlags: [Emoji] = [
       Emoji(symbol: "🏁", name: "Checkered Flag", description: "A black-and-white checkered flag.", usage:"completion")
    ]
    
    var emojisByType = [[Emoji]]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 44.0
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        emojisByType.append(emojisFaces)
        emojisByType.append(emojisFood)
        emojisByType.append(emojisAnimals)
        emojisByType.append(emojisPeople)
        emojisByType.append(emojisSymbol)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return emojisByType.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return emojisByType[section].count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! EmojiTableViewCell
       
        let emoji = emojisByType[indexPath.section][indexPath.row]
        cell.update(with: emoji)
        cell.showsReorderControl = true
        
        //cell.textLabel?.text = "\(emoji.symbol) - \(emoji.name)"
        //cell.detailTextLabel?.text = emoji.description
        cell.showsReorderControl = true
        return cell
    }
    
   /* override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let emoji = emojisByType[indexPath.section][indexPath.row]
        print ("\(emoji.symbol) \(indexPath)")
    }
    */
    @IBAction func editButtonTapped(_ sender: UIBarButtonItem){
        let tableViewEditingMode = tableView.isEditing
        tableView.setEditing(!tableViewEditingMode, animated: true)
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            
            emojisByType[indexPath.section].remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
        //else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
    

    
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        //var emojis = emojisByType[fromIndexPath.section]
        // let movedEmoji = emojis.remove(at: fromIndexPath.row)
        if fromIndexPath.section == to.section {
            let movedEmoji = emojisByType[fromIndexPath.section].remove(at: fromIndexPath.row)
            //emojis.insert(movedEmoji, at: to.row)
            emojisByType[fromIndexPath.section].insert(movedEmoji, at: to.row)
            
        }
        tableView.reloadData()
    }


    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

  
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "EditEmoji" {
            let indexPath = tableView.indexPathForSelectedRow!
            let emoji = emojisByType[indexPath.section][indexPath.row]
            let navController = segue.destination as! UINavigationController
            let addEditEmojiTableViewController =
            navController.topViewController as!
            AddEditEmojiTableViewController
            
            addEditEmojiTableViewController.emoji = emoji
        }
    }
    
    @IBAction func unwindToEmojiTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "saveUnwind" else {return}
        let sourceViewController = segue.source as! AddEditEmojiTableViewController
        
        let emoji = sourceViewController.emoji
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            emojisByType[selectedIndexPath.section][selectedIndexPath.row]  = emoji!
            tableView.reloadRows(at: [selectedIndexPath], with: .none)
        } else {
            let newIndexPath = IndexPath(row: emojisByType[0].count, section: 0)
            emojisByType[0].append(emoji!)
            tableView.insertRows(at: [newIndexPath], with: .automatic)
        }
        
    }


}
