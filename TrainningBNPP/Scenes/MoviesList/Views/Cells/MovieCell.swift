//
//  MovieCell.swift
//  TrainningBNPP
//
//  Created by Khaled El Abed on 22/06/2022.
//

import UIKit
import RxCocoa
import RxSwift
import Kingfisher

protocol Identifiable: AnyObject {
    static var identifier: String { get }
}

extension Identifiable {
    static var  identifier: String { String(describing: self) }
}

private typealias Dependencies = Setupable & Identifiable

final class MovieCell: UITableViewCell, Dependencies {

    // MARK: - Public Properties
    
    var viewModel: MovieViewModel! {
        didSet {
            setupBinding()
        }
    }
    
    // MARK: - Private Properties
    
    private var disposeBag: DisposeBag = DisposeBag()
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = Fonts.subtitle
        }
    }
    
    @IBOutlet private weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = Fonts.body
        }
    }
    
    @IBOutlet private weak var posterImageView: UIImageView!
    
    // MARK: - Initilization
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    // MARK: - Public Functions
    
    func setup(with model: MovieViewModel) {
       viewModel = model
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
    }
    
    // MARK: - Private Functions
    
    private func setupBinding() {
        viewModel.title.drive(titleLabel.rx.text).disposed(by: disposeBag)
        viewModel.description.drive(descriptionLabel.rx.text).disposed(by: disposeBag)
        viewModel.poster.asObservable().compactMap { $0 }.subscribe(onNext: { poster in
            KF.url(poster)
              .placeholder(UIImage(named: "poster-placeholder"))
              .loadDiskFileSynchronously()
              .cacheMemoryOnly()
              .set(to: self.posterImageView)
        }).disposed(by: disposeBag)
    }
}
