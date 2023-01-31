//
//  ViewController.swift


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableview : UITableView!
    @IBOutlet weak var txtFieldSearchValue : UITextField!
    @IBOutlet weak var lblAlert : UILabel!
    let acronymViewModel = AcronymViewModel()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ACRONYM"
        self.tableview.rowHeight = 50.0
        txtFieldSearchValue.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        acronymViewModel.client = HttpUtility()
        acronymViewModel.acronyms.bind { [weak self]_ in
            if ((self?.acronymViewModel.acronyms.value?.isEmpty) != nil){
                DispatchQueue.main.async {
                    self?.tableview.isHidden = false
                    self?.tableview.reloadData()
                    self?.lblAlert.isHidden = true
                }
            }else{
                DispatchQueue.main.async {
                    self?.tableview.isHidden = true
                    self?.tableview.reloadData()
                    self?.lblAlert.isHidden = false
                    if self?.txtFieldSearchValue.text == "" {
                        self?.lblAlert.text = "Type to Search Acronym"
                    }
                    else
                    {
                        self?.lblAlert.text = "No Acronym found"
                    }
                    
                }
            }
        }
    }
    
    @objc func textFieldDidChange(){
        
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
            if self.txtFieldSearchValue.text == ""{
                self.acronymViewModel.acronyms.value = nil
                
            }else{
                self.acronymViewModel.getAcronymRecords(searchValue: self.txtFieldSearchValue.text ?? "")
            }
        })
        
    }
}


extension ViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return acronymViewModel.acronyms.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableview.dequeueReusableCell(withIdentifier: "Cell") as! AcronymTableViewCell
        cell.textLabel?.text = self.acronymViewModel.acronyms.value?[indexPath.row].lf
        return cell
    }
}




