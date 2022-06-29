//
//  MovieDetailsViewController.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 23/06/2022.
//

import UIKit
import Kingfisher
import RxSwift
import RxCocoa

final class MovieDetailsViewController: UIViewController {
    
    // MARK: - Constants
    
    private enum Constants {
        static let bannerPlaceholder = "banner-placeholder"
        static let posterPlaceholder = "poster-placeholder"
    }
    
    // MARK: - Public Properties
    
    var viewModel: MovieDetailsViewModel! {
        didSet {
            
        }
    }
    
    var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var bannerImageView: UIImageView!
    @IBOutlet private weak var posterImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = Fonts.tilte
            titleLabel.textColor = .white
        }
    }
    
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = Fonts.body
            descriptionLabel.textColor = .black
        }
    }
    
    @IBOutlet private weak var dateLabel: UILabel! {
        didSet {
            dateLabel.font = Fonts.subtitle
            dateLabel.textColor = .white
        }
    }
    
    // MARK: - LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBinding()
    }
    
    // MARK: - Private Functions
    
    private func setupBinding() {
        viewModel.title.drive(titleLabel.rx.text).disposed(by: disposeBag)
        viewModel.description.drive(descriptionLabel.rx.text).disposed(by: disposeBag)
        viewModel.date.drive(dateLabel.rx.text).disposed(by: disposeBag)
        
        viewModel.poster.asObservable().subscribe(onNext: { poster in
            KF.url(poster)
                .placeholder(UIImage(named: Constants.posterPlaceholder))
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .set(to: self.posterImageView)
        }).disposed(by: disposeBag)
        
        viewModel.banner.asObservable().subscribe(onNext: { banner in
            KF.url(banner)
                .loadDiskFileSynchronously()
                .placeholder(UIImage(named: Constants.bannerPlaceholder))
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .set(to: self.bannerImageView)
        }).disposed(by: disposeBag)
    }
    
}
