//
//  LanguagesTableViewController.swift
//  timerTwo
//
//  Created by Saq on 1/14/21.
//

import UIKit
enum Lezu:String {
    case angleren = "English"
    case ruseren = "Русский"
    case hayeren = "Հայերեն"
}
class LanguagesTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if let colors = UserDefaults.standard.colorForKey(key: "colorsKey") {
            view.backgroundColor = colors
        }
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
//    let language = ["Հայերեն","English","Русский"]
    let languageArray:[(String,UIImage)] = [("Հայերեն",#imageLiteral(resourceName: "Eraguyn-drosh")),("English",#imageLiteral(resourceName: "unnamed-1")),("Русский",#imageLiteral(resourceName: "russia-flag-icon-free-download")),("France",#imageLiteral(resourceName: "Флаг-Франции"))]
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return languageArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "languaegeCellIdent", for: indexPath)
        cell.textLabel?.textAlignment = .center
        cell.layer.cornerRadius = 20
        let imageView = UIImageView(image: languageArray[indexPath.row].1)
        imageView.frame = CGRect(x: 0, y: 0, width: 100, height: cell.frame.height)
        cell.addSubview(imageView)
        cell.textLabel?.textAlignment = .center
        cell.textLabel?.font = .boldSystemFont(ofSize: 20)
        cell.textLabel?.text = languageArray[indexPath.row].0
        cell.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        return cell
        
    }
    var lezu:Lezu?
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserDefaults.standard.set(tableView.cellForRow(at: indexPath)?.textLabel?.text,forKey: "languageKey")
    }
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
