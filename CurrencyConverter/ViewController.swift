//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Ferhat Adiyeke on 31.12.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var gbpLbl: UILabel!
    @IBOutlet weak var tryLbl: UILabel!
    @IBOutlet weak var cadLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    @IBAction func btn(_ sender: UIButton) {
        
        
        
        let url = URL(string: "https://api.apilayer.com/fixer/latest?apikey=7THnTpQBl1LvkLdfkRPg6i6LnANPnlCW")
        
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { (data, response, error) in
            if error != nil {
                
                let alert = UIAlertController(title: "Eroor", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okBtn = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okBtn)
                self.present(alert, animated: true, completion: nil)
            } else {
                if data != nil {
                    do {
                   let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String, Any>
                        DispatchQueue.main.async {
                            if let rates = jsonResponse["rates"] as? [String : Any] {
                                
                                if let gbp = rates ["GBP"] as? Double {
                                    self.gbpLbl.text = "GBP: \(gbp)"
                                     }
                                if let TRY = rates ["TRY"] as? Double {
                                    self.tryLbl.text = "TRY: \(TRY)"
                                    
                                }
                                if let CAD = rates ["CAD"] as? Double {
                                    self.cadLbl.text = "CAD: \(CAD)"
                                    
                                }
                            }
                        }
                    } catch {
                        print("error")
                    }
                }
                
            }
        }
        task.resume()
    }
    
}

