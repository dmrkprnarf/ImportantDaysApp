//
//  ViewController.swift
//  PortalCodeApp
//
//  Created by Arif Demirkoparan on 26.01.2023.
//

import UIKit



class ViewController: UIViewController, ImportantDaysModelDelegate{

    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var fetchButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    var postalCodeData = [ImportantDaysData]()
    var model = ImportantDaysModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        pickerView.delegate = self
        model.delegate = self
    }
    @IBAction func getButtonPressed(_ sender: UIButton) {
       
        model.performRequest(url: model.getURL()) { result in
            self.postalCodeData = result
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    func failWithError(_ error: Error) {
        DispatchQueue.main.async {
            self.errorLabel.text = error.localizedDescription
        }
    }
}
extension ViewController:UITableViewDelegate {}

extension ViewController:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postalCodeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"cell") as! TableViewCell
        let data = postalCodeData[indexPath.row]
        cell.oneLbl.text = data.date
        cell.twoLbl.text = data.localName
        return cell
    }
}

extension ViewController:UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 50
    }
}

extension ViewController:UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return model.countryCode.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        model.countryName = model.arr[row]
      return  model.countryCode[row]
       
      
    }
}




