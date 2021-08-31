//
//  HomeViewModel.swift
//  MvvM-RxSwift
//
//  Created by Soda on 8/29/21.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

class HomeViewModel {
    
    var loadingBehavoir = BehaviorRelay<Bool>(value: false)
    var newsPublishSubject = PublishRelay<[Article]>()
    private var isTableHidden = BehaviorRelay<Bool>(value: false)
    
    var isTableHiddenObservable: Observable<Bool> {
        return isTableHidden.asObservable()
    }
    
    func getData() {
        
        loadingBehavoir.accept(true)
        let url = "https://newsapi.org/v2/top-headlines?country=eg&apiKey=809ad9947e1f40829ff2d2e9b67d0a4d"
        
        ApiService.Shared.fetchData(url: url, parms: nil, headers: nil, method: .get) { [weak self] (sucess:NewsResponseModel?, failer:NewsResponseErrroModel?, error) in
            
            guard let self = self else {return}
            self.loadingBehavoir.accept(false)
            if let error  = error {
                print(error.localizedDescription)
            }
            
            else if let fail = failer {
                print(fail.message ?? "")
            }
            else {
                guard let newsRespone = sucess else {return}
                
                if newsRespone.articles?.count ?? 0 > 0 {
                    
                    self.newsPublishSubject.accept(newsRespone.articles ?? [])
                    self.isTableHidden.accept(false)
                }
                else {
                    self.isTableHidden.accept(true)
                }
            }
        }
    }
}
