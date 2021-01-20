//
//  ColorsTableViewController.swift
//  timerTwo
//
//  Created by Saq on 1/14/21.
//

import UIKit

class ColorsTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.layer.cornerRadius = 20
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source
    var settings:Setting!
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        var row = 0
        switch settings! {
        case .color:
            row = colorsArray.count
        case .language:
            row = languageArray.count
        }
        return row
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "colorsCellIdent", for: indexPath)
        cell.layer.cornerRadius = 20
        switch settings! {
        case .color:
            cell.backgroundColor = colorsArray[indexPath.row]
        case .language:
            cell.textLabel?.textAlignment = .center
            cell.layer.cornerRadius = 20
            let imageView = UIImageView(image: languageArray[indexPath.row].1)
            imageView.frame = CGRect(x: 0, y: 0, width: 100, height: cell.frame.height)
            cell.addSubview(imageView)
            cell.textLabel?.textAlignment = .center
            cell.textLabel?.font = .boldSystemFont(ofSize: 20)
            cell.textLabel?.text = languageArray[indexPath.row].0
            cell.backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
        }
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch settings! {
        case .color:
            UserDefaults.standard.setColor(color: colorsArray[indexPath.row], forKey: "colorsKey")
            view.backgroundColor = colorsArray[indexPath.row]
        case .language:
            UserDefaults.standard.set(tableView.cellForRow(at: indexPath)?.textLabel?.text,forKey: "languageKey")
        }
    }
    
    
    let colorsArray:[UIColor] = [#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1),#colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1),#colorLiteral(red: 0.4734648678, green: 0.7123732575, blue: 1, alpha: 1),#colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1),#colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1),#colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),#colorLiteral(red: 1, green: 0.2527923882, blue: 1, alpha: 1),#colorLiteral(red: 1, green: 0.5763723254, blue: 0, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1),#colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1),#colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.4392156899, green: 0.01176470611, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.2745098174, green: 0.4862745106, blue: 0.1411764771, alpha: 1),#colorLiteral(red: 0.956505524, green: 0.6611672378, blue: 1, alpha: 1),#colorLiteral(red: 0, green: 0.9686274529, blue: 0.8782328896, alpha: 1),#colorLiteral(red: 0.06211186607, green: 0.9686274529, blue: 0.009919769445, alpha: 1),#colorLiteral(red: 0.9686274529, green: 0.009068053426, blue: 0, alpha: 1),#colorLiteral(red: 0.945086344, green: 0.9686274529, blue: 0.6886034625, alpha: 1)]
    let languageArray:[(String,UIImage)] = [("Հայերեն",#imageLiteral(resourceName: "Eraguyn-drosh")),("English",#imageLiteral(resourceName: "unnamed-1")),("Русский",#imageLiteral(resourceName: "russia-flag-icon-free-download")),("France",#imageLiteral(resourceName: "Флаг-Франции"))]
    
    
    
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
