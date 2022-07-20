//
//  ViewController.swift
//  currencyConvert
//
//  Created by Doğukan Doğan on 19.07.2022.
//

import UIKit

class ViewController: UIViewController {
    
    var currencyconverterLabel = UILabel()
    var cadLabel = UILabel()
    var chfLabel = UILabel()
    var gbpLabel = UILabel()
    var jpyLabel = UILabel()
    var usdLabel = UILabel()
    var tryLabel = UILabel()
    var resultButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        currencyconverterLabel.text = "Currency Converter"
        currencyconverterLabel.font = UIFont(name: currencyconverterLabel.font.fontName, size: 30)
        currencyconverterLabel.layer.borderWidth = 1
        currencyconverterLabel.textAlignment = .center
        currencyconverterLabel.frame = CGRect(x: width * 0.5 - width * 0.7 / 2, y: height * 0.15 - height * 0.05 / 2, width: width * 0.7, height: height * 0.05)
        view.addSubview(currencyconverterLabel)
        
        cadLabel.text = "CAD : "
        cadLabel.font = UIFont(name: cadLabel.font.fontName, size: 20)
        cadLabel.layer.borderWidth = 1
        cadLabel.textAlignment = .center
        cadLabel.frame = CGRect(x: width * 0.5 - width * 0.7 / 2, y: height * 0.22 - height * 0.05 / 2, width: width * 0.7, height: height * 0.05)
        view.addSubview(cadLabel)
        
        chfLabel.text = "CHF : "
        chfLabel.font = UIFont(name: chfLabel.font.fontName, size: 20)
        chfLabel.layer.borderWidth = 1
        chfLabel.textAlignment = .center
        chfLabel.frame = CGRect(x: width * 0.5 - width * 0.7 / 2, y: height * 0.28 - height * 0.05 / 2, width: width * 0.7, height: height * 0.05)
        view.addSubview(chfLabel)
        
        gbpLabel.text = "GBP : "
        gbpLabel.font = UIFont(name: chfLabel.font.fontName, size: 20)
        gbpLabel.layer.borderWidth = 1
        gbpLabel.textAlignment = .center
        gbpLabel.frame = CGRect(x: width * 0.5 - width * 0.7 / 2, y: height * 0.34 - height * 0.05 / 2, width: width * 0.7, height: height * 0.05)
        view.addSubview(gbpLabel)
        
        jpyLabel.text = "JPY : "
        jpyLabel.font = UIFont(name: chfLabel.font.fontName, size: 20)
        jpyLabel.layer.borderWidth = 1
        jpyLabel.textAlignment = .center
        jpyLabel.frame = CGRect(x: width * 0.5 - width * 0.7 / 2, y: height * 0.4 - height * 0.05 / 2, width: width * 0.7, height: height * 0.05)
        view.addSubview(jpyLabel)
        
        usdLabel.text = "USD : "
        usdLabel.font = UIFont(name: usdLabel.font.fontName, size: 20)
        usdLabel.layer.borderWidth = 1
        usdLabel.textAlignment = .center
        usdLabel.frame = CGRect(x: width * 0.5 - width * 0.7 / 2, y: height * 0.45 - height * 0.05 / 2, width: width * 0.7, height: height * 0.05)
        view.addSubview(usdLabel)
        
        tryLabel.text = "TRY : "
        tryLabel.textAlignment = .center
        tryLabel.font = UIFont(name: tryLabel.font.fontName, size: 20)
        tryLabel.layer.borderWidth = 1
        tryLabel.frame = CGRect(x: width * 0.5 - width * 0.7 / 2, y: height * 0.5 - height * 0.05 / 2, width: width * 0.7, height: height * 0.05)
        view.addSubview(tryLabel)
        
        resultButton.setTitle("Get Result", for: UIControl.State.normal)
        resultButton.layer.borderWidth = 1
        resultButton.frame = CGRect(x: width * 0.5 - width * 0.4 / 2, y: height * 0.57 - height * 0.05 / 2, width: width * 0.4, height: height * 0.05)
        resultButton.addTarget(self, action: #selector(resultClick), for: UIControl.Event.touchUpInside)
        view.addSubview(resultButton)
    }

    @objc func resultClick(){
        
        let url = URL(string: "https://api.fastforex.io/fetch-all?api_key=0dea723288-34e4db6670-rfbgj1")
        let session = URLSession.shared
        let task = session.dataTask(with: url!) { data, response, error in
            if error != nil {
                
                let alert = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                let okyButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
                alert.addAction(okyButton)
                self.present(alert, animated: true, completion: nil)
                
            }else{
                
                if data != nil {
                    
                    do{
                        
                        let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! Dictionary<String,Any>
                        
                        DispatchQueue.main.async {
                            if let results = jsonResponse["results"] as? [String : Any]{
                                
                                if let cad = results["CAD"] as? Double{
                                    self.cadLabel.text = "CAD : \(cad)"
                                }
                                
                                if let chf = results["CHF"] as? Double{
                                    self.chfLabel.text = "CHF : \(chf)"
                                }
                                
                                if let gbp = results["GBP"] as? Double{
                                    self.gbpLabel.text = "GBP : \(gbp)"
                                }
                                
                                if let jpy = results["JPY"] as? Double{
                                    self.jpyLabel.text = "JPY : \(jpy)"
                                }
                                
                                if let usd = results["USD"] as? Double{
                                    self.usdLabel.text = "USD : \(usd)"
                                }
                                
                                if let turkish = results["TRY"] as? Double{
                                    self.tryLabel.text = "TRY : \(turkish)"
                                }
                                
                            }
                        }
                        
                    }catch{
                        print("error")
                    }
                    
                }
                
            }
        }
        
        task.resume()
        
    }

}

