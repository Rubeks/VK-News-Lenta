//
//  NewsfeedViewController.swift
//  VKNewsLenta
//
//  Created by Раис Аглиуллов on 11/06/2019.
//  Copyright (c) 2019 Раис Аглиуллов. All rights reserved.
//

import UIKit

protocol NewsfeedDisplayLogic: class {
    func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData)
}

class NewsfeedViewController: UIViewController, NewsfeedDisplayLogic {
    
    var interactor: NewsfeedBusinessLogic?
    var router: (NSObjectProtocol & NewsfeedRoutingLogic)?
    
    //Свойство в котором лежит структура модели для заполнения ячейки
    private var feedViewModel = FeedViewModel.init(cells: [])
    
    //MARK: - Outlets
    @IBOutlet weak var table: UITableView!
    
    // MARK: Setup
    private func setup() {
        let viewController        = self
        let interactor            = NewsfeedInteractor()
        let presenter             = NewsfeedPresenter()
        let router                = NewsfeedRouter()
        viewController.interactor = interactor
        viewController.router     = router
        interactor.presenter      = presenter
        presenter.viewController  = viewController
        router.viewController     = viewController
    }
    
    // MARK: Routing
    
    
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        //Регистрация ячейки
        table.register(UINib(nibName: "NewsfeedCell", bundle: nil), forCellReuseIdentifier: NewsfeedCell.reuseId)
        
        //Запрос в Интерактор для создания на сервер для получения данных
        interactor?.makeRequest(request: Newsfeed.Model.Request.RequestType.getNewsFeed)
        
    }
    
    func displayData(viewModel: Newsfeed.Model.ViewModel.ViewModelData) {
        switch viewModel {
            
        case .displayNewsFeed(let feedViewModel):
            
            self.feedViewModel = feedViewModel
            table.reloadData()
        }
    }
}

extension NewsfeedViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return feedViewModel.cells.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //Ячейка
        let cell = table.dequeueReusableCell(withIdentifier: NewsfeedCell.reuseId, for: indexPath) as! NewsfeedCell
        
        //1 элемент из массива
        let cellViewModel = feedViewModel.cells[indexPath.row]
        
        //Передача этого элемента в функцию в ячейке для заполнения аутлетов
        cell.set(viewModel: cellViewModel)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 212
    }
}
