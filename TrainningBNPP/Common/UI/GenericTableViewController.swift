//
//  GenericTableViewController.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 23/06/2022.
//

import UIKit
import RxSwift

private typealias Dependencies = Loadable & Alertable

class GenericTableViewController<ViewModel: GenericTableViewModel<MovieViewModel>, Cell: UITableViewCell>: UIViewController where ViewModel: DataSourced, Cell: Setupable, ViewModel.ViewModel == Cell.ViewModel {
    
    
    var viewModel: ViewModel!
    
    let disposeBag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.isLoading.subscribe(onNext: { isLoading in
            isLoading ? self.showLoadingView() : self.hideLoadingView()
        }).disposed(by: disposeBag)
        
        viewModel.hasError.subscribe( onNext: { error in
            
            guard let error = error else { return }
            
            self.showError(error)
        }).disposed(by: disposeBag)
    }
    
    // Enable detection of shake motion
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        print("---", motion)
        viewModel.activateMock(motion == .motionShake)
        viewModel.reload.accept(true)
    }
}

extension GenericTableViewController: Dependencies {}
