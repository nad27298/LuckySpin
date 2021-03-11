//
//  RotateListVC.swift
//  RotationLucky
//
//  Created by Macbook on 2/8/21.
//

import UIKit

protocol SmartDelegate: class {
    func updateAnswer(_ answer: Int)
}

class RotateListVC: UIViewController {

    @IBOutlet weak var tvcList: UITableView!
    
    var rotatelistData = [RotateModel]()
    
    weak var delegate: SmartDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvcList.delegate = self
        tvcList.dataSource = self
        tvcList.register(UINib(nibName: RotateListTVC.className, bundle: nil), forCellReuseIdentifier: RotateListTVC.className)
        tvcList.reloadData()
    }
    @IBAction func btn_Back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btn_Add(_ sender: Any) {
        let alert: UIAlertController = UIAlertController(title: "Insert Value List", message: "Add a new value", preferredStyle: .alert)
        alert.addTextField { (txtfldName1) in
            txtfldName1.placeholder = "Insert value 1"
        }
        alert.addTextField { (txtfldName2) in
            txtfldName2.placeholder = "Insert value 2"
        }
        alert.addTextField { (txtfldName3) in
            txtfldName3.placeholder = "Insert value 3"
        }
        alert.addTextField { (txtfldName4) in
            txtfldName4.placeholder = "Insert value 4"
        }
        alert.addTextField { (txtfldName5) in
            txtfldName5.placeholder = "Insert value 5"
        }
        alert.addTextField { (txtfldName6) in
            txtfldName6.placeholder = "Insert value 6"
        }
        alert.addTextField { (txtfldName7) in
            txtfldName7.placeholder = "Insert value 7"
        }
        let btn_Save: UIAlertAction = UIAlertAction(title: "Save", style: .default) { [self] (btnSave) in
            let newname1 = alert.textFields![0].text!
            let newname2 = alert.textFields![1].text!
            let newname3 = alert.textFields![2].text!
            let newname4 = alert.textFields![3].text!
            let newname5 = alert.textFields![4].text!
            let newname6 = alert.textFields![5].text!
            let newname7 = alert.textFields![6].text!
            RotateEntity.shared.insertData(newname1, newname2, newname3, newname4, newname5, newname6, newname7)
            self.rotatelistData = RotateEntity.shared.getData()
            self.tvcList.reloadData()
            self.tvcList.scrollToRow(at: IndexPath(row: rotatelistData.count - 1, section: 0), at: .none, animated: true)
        }
        let btn_Cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(btn_Save)
        alert.addAction(btn_Cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
}

extension RotateListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        rotatelistData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: RotateListTVC.className) as! RotateListTVC
        cell.lblStt.text = String(indexPath.row + 1)
        cell.lblList.text = rotatelistData[indexPath.row].name1 + ", " + rotatelistData[indexPath.row].name2 + ", " + rotatelistData[indexPath.row].name3 + ", " + rotatelistData[indexPath.row].name4 + ", " + rotatelistData[indexPath.row].name5 + ", " + rotatelistData[indexPath.row].name6 + ", " + rotatelistData[indexPath.row].name7
        cell.btnEdit.addTarget(self, action: #selector(btn_Edit), for: .touchUpInside)
        cell.btnEdit.tag = indexPath.row
        cell.btnDelete.addTarget(self, action: #selector(btn_Delete), for: .touchUpInside)
        cell.btnDelete.tag = indexPath.row
        return cell
    }
    
    @objc func btn_Edit(_ sender: UIButton) {
        let i = sender.tag
        let alert: UIAlertController = UIAlertController(title: "Rename List", message: "Add a new value", preferredStyle: .alert)
        alert.addTextField { (txtfldName1) in
            txtfldName1.placeholder = "New value 1 or not"
        }
        alert.addTextField { (txtfldName2) in
            txtfldName2.placeholder = "New value 2 or not"
        }
        alert.addTextField { (txtfldName3) in
            txtfldName3.placeholder = "New value 3 or not"
        }
        alert.addTextField { (txtfldName4) in
            txtfldName4.placeholder = "New value 4 or not"
        }
        alert.addTextField { (txtfldName5) in
            txtfldName5.placeholder = "New value 5 or not"
        }
        alert.addTextField { (txtfldName6) in
            txtfldName6.placeholder = "New value 6 or not"
        }
        alert.addTextField { (txtfldName7) in
            txtfldName7.placeholder = "New value 7 or not"
        }
        let btn_Save: UIAlertAction = UIAlertAction(title: "Save", style: .default) { [self] (btnSave) in
            let newname1 = alert.textFields![0].text!
            let newname2 = alert.textFields![1].text!
            let newname3 = alert.textFields![2].text!
            let newname4 = alert.textFields![3].text!
            let newname5 = alert.textFields![4].text!
            let newname6 = alert.textFields![5].text!
            let newname7 = alert.textFields![6].text!
            _ = RotateEntity.shared.updateData(newname1, newname2, newname3, newname4, newname5, newname6, newname7, rotatelistData[i].id)
            self.rotatelistData = RotateEntity.shared.getData()
            self.tvcList.reloadData()
        }
        let btn_Cancel: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alert.addAction(btn_Save)
        alert.addAction(btn_Cancel)
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func btn_Delete(_ sender: UIButton) {
        let i = sender.tag
        _ = RotateEntity.shared.deleteId(rotatelistData[i].id)
        rotatelistData.remove(at: i)
        tvcList.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.updateAnswer(indexPath.row)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}
