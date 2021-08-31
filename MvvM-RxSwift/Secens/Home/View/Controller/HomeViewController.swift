//
//  HomeViewController.swift
//  MvvM-RxSwift
//
//  Created by Soda on 8/28/21.
//

import UIKit
import RxCocoa
import RxSwift
import JGProgressHUD


class HomeViewController: UIViewController , UITableViewDelegate{
    
    @IBOutlet weak var newsTabelView: UITableView!    
    @IBOutlet weak var contianerView: UIView!
    
    let cellID = "NewsTableViewCell"
    let newsViewModel = HomeViewModel()
    let disposeBag = DisposeBag()
    let hud = JGProgressHUD()
    var articilesModel = [Article]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "News"
        navigationController?.isNavigationBarHidden = false
        setupTableView()
        setupLoading()
        setupDataSource()
        getNews()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        newsTabelView.rowHeight = UITableView.automaticDimension
        title = "News"
        navigationController?.isNavigationBarHidden = false
        
    }
    
    func setupTableView() {
        newsTabelView.register(UINib(nibName: cellID, bundle: nil), forCellReuseIdentifier: cellID)
        
    }
    
    func setupTableHidden() {
        
        newsViewModel.isTableHiddenObservable.subscribe(onNext: { (isHidden) in
            
            if isHidden {
                
                self.contianerView.isHidden = true
            }
            else {
                self.contianerView.isHidden = false
            }
            
        }).disposed(by: disposeBag)
    }
    
    func setupLoading() {
        
        newsViewModel.loadingBehavoir.subscribe(onNext: { (isLoading) in
            if isLoading == true {
                self.hud.show(in: self.view)
            }
            else {
                self.hud.dismiss()
            }
        }).disposed(by: disposeBag)
    }
    
    
    func setupDataSource() {
        
        newsTabelView.rx
            .setDelegate(self)
            .disposed(by: disposeBag)
        
        newsViewModel
            .newsPublishSubject
            .asObservable()
            .bind(to: newsTabelView.rx.items(cellIdentifier: cellID,cellType: NewsTableViewCell.self)) {  index , element, cell in
                cell.ConfgiureCell(data: element)
            }
            .disposed(by: disposeBag)
    }
    
    
    func getNews() {
        newsViewModel.getData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
    
    
}


