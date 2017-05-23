//
//  ViewController.swift
//  music album
//
//  Created by Mahmoud on 5/5/17.
//  Copyright © 2017 Mahmoud. All rights reserved.
//

import UIKit



class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var table: UITableView!
    
    var artistArray = [String]()
    var titleArray = [String]()
    var imageArray = [String]()
    var urlArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJsonWithUrl()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func downloadJsonWithUrl(){
        let url = NSURL(string: "https://rallycoding.herokuapp.com/api/music_albums")
        
        let task = URLSession.shared.dataTask(with: url! as URL) { (data, response, error) in
            
            if error != nil{
                print(error!)
            }else{
                if let urlContent = data{
                do{
                    let jsonResults = try JSONSerialization.jsonObject(with: urlContent, options: .allowFragments) as! NSArray

                    for jsonResult in jsonResults.reversed(){
                        if let jsonDict = jsonResult as? NSDictionary{
                            
                            if let artist = jsonDict.value(forKey: "artist"){
                                self.artistArray.append(artist as! String)
                            }
                            if let title = jsonDict.value(forKey: "title"){
                                self.titleArray.append(title as! String)
                            }
                            if let image = jsonDict.value(forKey: "image"){
                                self.imageArray.append(image as! String)
                            }
                            if let url = jsonDict.value(forKey: "url"){
                                self.urlArray.append(url as! String)
                            }
                            OperationQueue.main.addOperation({ 
                               self.table.reloadData()
                            })
                            
                        }
                    }
                    
                }catch{
                    print("couldn't fetch data")
                }
            }
            
        }
    }
        task.resume()
}
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return artistArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.title.text = String(titleArray[indexPath.row])
        cell.artist.text = artistArray[indexPath.row]
        
        let imageUrl = NSURL(string: imageArray[indexPath.row])
        if imageUrl != nil {
            let data = NSData(contentsOf: imageUrl! as URL)
            cell.albumImage.image = UIImage(data: data! as Data)            
            cell.albumImage.layer.cornerRadius = (cell.albumImage.frame.size.width) / 2
            cell.albumImage.layer.masksToBounds = true
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        performSegue(withIdentifier: "webSegue", sender: table)
   }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            let index = table.indexPathForSelectedRow
            let indexNumber = index?.row
        
            if segue.identifier == "webSegue" {
                let destination = segue.destination as! secondViewController
                
                destination.itemUrl = urlArray[indexNumber!]
                
                
                
            }
        
        
    
    }
    


}
