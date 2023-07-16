//
//  TvShowDetailsVC.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 15/7/23.
//

import UIKit
import Domain
import RxSwift
import RxCocoa

class TvShowDetailsVC: UIViewController {
    
    @IBOutlet weak var tvShowImageView: UIImageView!
    @IBOutlet weak var tvShowTitleLbl: UILabel!
    @IBOutlet weak var tvShowReleaseDateLbl: UILabel!
    @IBOutlet weak var overviewLbl: UILabel!
    @IBOutlet weak var overviewStackView: UIStackView!
    
    private var viewModel: TvShowDetailsViewModel
    
    init(viewModel: TvShowDetailsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
   }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupObservers()
        viewModel.onTriggeredEvent(event: .getImageData)
        viewModel.onTriggeredEvent(event: .getOverviewData)
        setupNavBar()
        setupBaseInfo()
        self.view.backgroundColor = .backgroundDefaultPrimary
    }
    
    func setupNavBar() {
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .black
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    
    func setupBaseInfo() {
        let tvShow = viewModel.state.value.tvShow
        tvShowTitleLbl.attributedText = tvShow.name?.with(.title2(weight: .BOLD, color: .tintPrimary))
        tvShowReleaseDateLbl.attributedText = tvShow.firstAirDate?.with(.title2(weight: .BOLD, color: .tintTertiary))
    }
    
    func setupImageView(imageData: Data) {
        tvShowImageView.image = UIImage(data: imageData)
        tvShowImageView.layer.cornerRadius = 16.0
        tvShowImageView.clipsToBounds = true
    }

    func createOverviewView(overviewData: [OverviewData]) {
        overviewLbl.text = "Overview"
        let numberOfData = overviewData.count
        for (index, element) in overviewData.enumerated() {
            let isSeperatorHidden = index == (numberOfData - 1)
            let overviewView = OverviewView(frame: .zero)
            overviewView.setupView(title: element.title, description: element.description, isSeperatorHidden: isSeperatorHidden)
            overviewStackView.addArrangedSubview(overviewView)
        }
        overviewStackView.layer.cornerRadius = 16.0
        overviewStackView.clipsToBounds = true
        overviewStackView.backgroundColor = .backgroundGroupedPrimary
    }
    
    func setupObservers() {
        viewModel.stateObserver
            .observe(on: MainScheduler.instance)
            .map { $0.imageData }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] imageData in
                self?.setupImageView(imageData: imageData)
            }).disposed(by: rx.disposeBag)
        
        viewModel.stateObserver
            .observe(on: MainScheduler.instance)
            .map { $0.overviewData }
            .distinctUntilChanged()
            .subscribe(onNext: { [weak self] overviewData in
                self?.createOverviewView(overviewData: overviewData)
            }).disposed(by: rx.disposeBag)
    }
}
