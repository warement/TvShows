//
//  TvShowDetailsVC.swift
//  TvShows
//
//  Created by Lefteris Altouvas Manolou on 15/7/23.
//

import UIKit

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
        setupNavBar()
        setupBaseInfo()
        createOverviewView()
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
        tvShowImageView.image = UIImage(named: "imagePlaceholder")
        tvShowImageView.layer.cornerRadius = 16.0
        tvShowImageView.clipsToBounds = true
        tvShowTitleLbl.attributedText = tvShow.name?.with(.title2(weight: .BOLD, color: .tintPrimary))
        tvShowReleaseDateLbl.attributedText = tvShow.firstAirDate?.with(.title2(weight: .BOLD, color: .tintTertiary))
    }

    func createOverviewView() {
        overviewLbl.text = "Overview"
        let tvShow = viewModel.state.value.tvShow
        let airs = OverviewView(frame: .zero)
        airs.setupView(title: "AIRS", description: tvShow.firstAirDate ?? "")
        overviewStackView.addArrangedSubview(airs)
        let runTime = OverviewView(frame: .zero)
        runTime.setupView(title: "RUNTIME", description: tvShow.episodeRunTime?.first?.description ?? "")
        overviewStackView.addArrangedSubview(runTime)
        let languages = OverviewView(frame: .zero)
        let languagesData = tvShow.languages?.joined(separator: ",") ?? ""
        languages.setupView(title: "LANGUAGES", description: languagesData)
        overviewStackView.addArrangedSubview(languages)
        let genres = OverviewView(frame: .zero)
        let genresData = tvShow.genres?.map({ $0.name ?? "" }).joined(separator: ", ") ?? ""
        genres.setupView(title: "GENRES", description: genresData)
        overviewStackView.addArrangedSubview(genres)
        let synopsis = OverviewView(frame: .zero)
        synopsis.setupView(title: "SYNOPSIS", description: tvShow.overview ?? "", isSeperatorHidden: true)
        overviewStackView.addArrangedSubview(synopsis)
        overviewStackView.layer.cornerRadius = 16.0
        overviewStackView.clipsToBounds = true
        overviewStackView.backgroundColor = .backgroundGroupedPrimary
    }

   

}
