//
//  MoviesListViewController.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 23/06/2022.
//

import UIKit
import RxCocoa
import RxSwift

final class MoviesListViewController: GenericTableViewController<MoviesViewModel, MovieCell> {

    
    // MARK: - Private Properties
    
    var delegate: MoviesFlow?
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var searchBar: UISearchBar!
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            setupTableView()
        }
    }
    
    // MARK: - Initializations
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
    }
    
    // MARK: - Private Functions
    
    private func setupTableView() {
        let nib = UINib(nibName: MovieCell.identifier, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: MovieCell.identifier)
        tableView.rx.setDelegate(self).disposed(by: disposeBag)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
    }
    
    private func setupBinding() {
        searchBar.rx.text.bind(to: viewModel.input.name).disposed(by: disposeBag)
        
        viewModel?.movies.drive(tableView.rx.items(cellIdentifier: MovieCell.identifier, cellType: MovieCell.self)) { (_, viewModel, cell) in
            cell.setup(with: viewModel)
        }.disposed(by: disposeBag)
            
        tableView.rx.modelSelected(MovieViewModel.self).bind(to: viewModel.input.selectedMovie).disposed(by: disposeBag)
        
        tableView.rx.modelSelected(MovieViewModel.self).subscribe(onNext: { selectedMovie in
            print("**🔥**","SelectedItem: \(selectedMovie.movie.title)", self.delegate)
            
            self.delegate?.navigateToMovieDetails(movie: selectedMovie.movie)
        }).disposed(by: disposeBag)
        
        // Called when apiClient or apiClientMock setted
        viewModel?.reload.filter { $0 }.subscribe(onNext: { _ in
            self.viewModel?.input.name.accept(nil)
        }).disposed(by: disposeBag)
        
        
    }
}

extension MoviesListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
