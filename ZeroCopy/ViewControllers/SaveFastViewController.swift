//
//  SaveFastViewController.swift
//  ZeroCopy
//
//  Created by Mike Gopsill on 01/02/2018.
//  Copyright © 2018 Mike Gopsill. All rights reserved.
//

import UIKit

enum State {
    case create
    case edit
}

class SaveFastViewController: UIViewController, DatePickerProtocol {

    var tableView: UITableView!
    var saveButton: UIButton!
    var fast: Fast?
    var transitionManager: TransitionManager!
    var dateFormatter: DateFormatter!
    var state: State!
    let datePicker = UIDatePicker()
    let backgroundView = UIView()
    let triangleView = TriangleView()
    
    init(with state: State){
        super.init(nibName: nil, bundle: nil)
        self.state = state
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupNavigationController()
        setupConstraints()
    }
    
    private func setup() {
        dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "h:mmpo"
        
        tableView = UITableView()
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(LabelAndTimeCell.self, forCellReuseIdentifier: "LabelAndTimeCell")
        tableView.tableFooterView = UIView()
        saveButton = UIButton()
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        saveButton.backgroundColor = UIColor(red:0.90, green:0.89, blue:0.60, alpha:1.0)
        saveButton.setTitleColor(UIColor(red:0.45, green:0.44, blue:0.31, alpha:1.0), for: .normal)
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(savePressed), for: .touchUpInside)
        transitionManager = TransitionManager()
        view.backgroundColor = .white
        
        view.addSubview(saveButton)
        view.addSubview(tableView)
    }
    
    private func setupNavigationController() {
        guard let navigationController = navigationController else { return }
        navigationController.navigationBar.barTintColor = UIColor(red: (247/255), green: (247/255), blue: (247/255), alpha: 1)
        navigationController.navigationBar.isTranslucent = false
        navigationController.navigationBar.topItem?.title = "Finish Fast"
        navigationController.navigationBar.tintColor = .purple
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor  : UIColor.black]
        let leftButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let rightButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deletePressed))
        rightButton.tintColor = .orange
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
    }
    
    @objc func cancelPressed(){
        if state! == .create {
            CoreDataManager.sharedInstance.deleteFasts(fast: fast!)
        }
        let transition = transitionManager.transitionDown()
        navigationController?.view.layer.add(transition, forKey: nil)
        navigationController?.popViewController(animated: false)
    }
    
    @objc func deletePressed(){
        let deleteAlert = UIAlertController(title: nil, message: "Are you sure you want to delete this fast?", preferredStyle: .actionSheet)
        deleteAlert.addAction(UIAlertAction(title: "Delete Fast", style: .destructive, handler: { (action: UIAlertAction!) in
            CoreDataManager.sharedInstance.deleteFasts(fast: self.fast!)
            let transition = self.transitionManager.transitionDown()
            self.navigationController?.view.layer.add(transition, forKey: nil)
            self.navigationController?.popViewController(animated: false)
        }))
        
        deleteAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
            print("Handle Cancel Logic here")
        }))
        
        present(deleteAlert, animated: true, completion: nil)
    }
    
    @objc func savePressed(){
        guard let fast = fast else { return }
        if fast.startDate! > fast.endDate! {
            let alert = UIAlertController(title: "Cannot Save Fast", message: "Start time must be before end time", preferredStyle: .alert)
            alert.addAction(UIAlertAction.init(title: "OK", style: .cancel, handler: { (action: UIAlertAction!) in
                alert.dismiss(animated: true, completion: nil)}))
            present(alert, animated: true, completion: nil)
        } else {
            let transition = transitionManager.transitionDown()
            navigationController?.view.layer.add(transition, forKey: nil)
            navigationController?.popViewController(animated: false)
        }
    }

    private func setupConstraints() {
        let constraints: [NSLayoutConstraint] = [
            saveButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20.0),
            saveButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0),
            saveButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20.0),
            saveButton.heightAnchor.constraint(equalToConstant: 40.0),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: saveButton.topAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    @objc func datePickerForStartDate() {
        fast?.startDate = datePicker.date
        tableView.reloadData()
    }
    
    @objc func datePickerForEndDate() {
        fast?.endDate = datePicker.date 
        tableView.reloadData()
    }
    
    @objc func endDatePicker() {
        backgroundView.removeFromSuperview()
        datePicker.removeFromSuperview()
        triangleView.removeFromSuperview()
    }
    
    // MARK: DatePicker Delegate Methods
    
    func datePicker(state: LabelTimeCellState){
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(endDatePicker)))
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        datePicker.backgroundColor = .groupTableViewBackground
        datePicker.clipsToBounds = true
        datePicker.layer.cornerRadius = 10
        triangleView.translatesAutoresizingMaskIntoConstraints = false
        triangleView.backgroundColor = .clear

        view.addSubview(backgroundView)
        view.addSubview(datePicker)
        view.addSubview(triangleView)
        
        if state == .start {
            let constraints: [NSLayoutConstraint] = [
                backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
                backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                datePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 140.0),
                triangleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                triangleView.bottomAnchor.constraint(equalTo: datePicker.topAnchor),
                triangleView.heightAnchor.constraint(equalToConstant: 20.0),
                triangleView.widthAnchor.constraint(equalToConstant: 25.0)
            ]
            NSLayoutConstraint.activate(constraints)
            datePicker.setDate(fast!.startDate!, animated: false)
            datePicker.removeTarget(self, action: #selector(datePickerForEndDate), for: .valueChanged)
            datePicker.addTarget(self, action: #selector(datePickerForStartDate), for: .valueChanged)
        } else if state == .end {
            let constraints: [NSLayoutConstraint] = [
                backgroundView.topAnchor.constraint(equalTo: view.topAnchor),
                backgroundView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                backgroundView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                backgroundView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
                datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                datePicker.topAnchor.constraint(equalTo: view.topAnchor, constant: 260.0),
                triangleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                triangleView.bottomAnchor.constraint(equalTo: datePicker.topAnchor),
                triangleView.heightAnchor.constraint(equalToConstant: 20.0),
                triangleView.widthAnchor.constraint(equalToConstant: 25.0)
            ]
            NSLayoutConstraint.activate(constraints)
            datePicker.setDate(fast!.endDate!, animated: false)
            datePicker.removeTarget(self, action: #selector(datePickerForStartDate), for: .valueChanged)
            datePicker.addTarget(self, action: #selector(datePickerForEndDate), for: .valueChanged)
        }
    }
}

extension SaveFastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelAndTimeCell") as! LabelAndTimeCell
            cell.bottomLabel.text = dateFormatter.string(from: fast!.startDate!)
            cell.delegate = self
            cell.isStart()
            return cell
        }
        
        if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelAndTimeCell") as! LabelAndTimeCell
            cell.bottomLabel.text = dateFormatter.string(from: fast!.endDate!)
            cell.delegate = self
            cell.isEnd()
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "LabelAndTimeCell") as! LabelAndTimeCell
            cell.topLabel.text = "TOTAL FASTING TIME"
            cell.bottomLabel.text = "\(fast!.duration) seconds"
            return cell
        }
        
        return UITableViewCell()
    }
}
