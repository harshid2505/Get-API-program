//
//  ViewController.swift
//  Get API program
//
//  Created by HARSHID PATEL on 17/03/23.
//

import UIKit

struct GetApi: Codable{
    var postId: Int
    var id: Int
    var name: String
    var email: String
    var body: String
}

class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    
    var arr : [GetApi] = []

    @IBOutlet weak var tableData: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getData()
    }
    
    func getData(){
        let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1/comments")
        var ur = URLRequest(url: url!)
        ur.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: ur) { data, response, error in
            do{
                if error == nil{
                    self.arr = try JSONDecoder().decode([GetApi].self, from: data!)
                    //print(self.arr)
                    DispatchQueue.main.async {
                        self.tableData.reloadData()
                    }
                }
            }
            catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableViewCell
        cell.lb1.text = "\(arr[indexPath.row].id)"
        cell.lb2.text = arr[indexPath.row].email
        
        return cell
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }

}

