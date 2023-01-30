//
//  ViewController.swift


import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableview : UITableView!
    @IBOutlet weak var txtFieldSearchValue : UITextField!
    let acronymViewModel = AcronymViewModel()
   

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "ACRONYM"
        self.tableview.rowHeight = 50.0
        txtFieldSearchValue.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)

        acronymViewModel.client = HttpUtility()
        acronymViewModel.acronyms.bind { [weak self]_ in
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute: {
                self?.tableview.reloadData()
            })
        }
    }
    
    @objc func textFieldDidChange(){
        acronymViewModel.getAcronymRecords(searchValue: self.txtFieldSearchValue.text ?? "") 
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




