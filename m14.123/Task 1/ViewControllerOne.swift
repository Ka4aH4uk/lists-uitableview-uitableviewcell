//
//  ViewController.swift
//  m14.123
//
//  Created by Ka4aH on 21.01.2023.
//

import UIKit

class ViewControllerOne: UIViewController {
    private lazy var tableView: UITableView = { // таблица
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.backgroundColor = .systemBlue
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 120
        tableView.separatorStyle = .singleLine
        return tableView
    }()
    
    let cellWithImageAndLabel = "cellWithImageAndLabel" // идентификатор
    
    private func setupConstraints() {
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    }
    
    let countries: [CellWithImageAndLabelViewModel] = [
        CellWithImageAndLabelViewModel(image: Constants.Image.austria ?? UIImage(), title: "Austria"),
        CellWithImageAndLabelViewModel(image: Constants.Image.belg ?? UIImage(), title: "Belgium"),
        CellWithImageAndLabelViewModel(image: Constants.Image.france ?? UIImage(), title: "France"),
        CellWithImageAndLabelViewModel(image: Constants.Image.germ ?? UIImage(), title: "Germany"),
        CellWithImageAndLabelViewModel(image: Constants.Image.greece ?? UIImage(), title: "Greece")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //регистрация ячейки: nib - название созданного xib файла + идентификатор
        tableView.register(UINib(nibName: "CellWithImageAndLabel", bundle: nil), forCellReuseIdentifier: cellWithImageAndLabel)
        tableView.dataSource = self
        tableView.delegate = self
        setupViews()
        setupConstraints()
    }
    
    private func setupViews() {
        view.addSubview(tableView)
    }
}

//MARK: - DataSource
extension ViewControllerOne: UITableViewDataSource { //отвечает за данные, с которыми мы работаем
    
    //количество записей в секции
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        countries.count
    }
    //метод отвечает за наполнение нашей ячейки
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //приведение типов
        let cell = tableView.dequeueReusableCell(withIdentifier: cellWithImageAndLabel) as? CellWithImageAndLabel //класс нашей ячейки
        let viewModel = countries[indexPath.row]
        cell?.imageCell?.image = viewModel.image
        cell?.labelCell?.text = viewModel.title
        return cell ?? UITableViewCell()
    }
}

//MARK: - Delegate
extension ViewControllerOne: UITableViewDelegate {
    
}
