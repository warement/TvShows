//
//  PopularTvShows.swift
//  Domain
//
//  Created by Lefteris Altouvas Manolou on 4/7/23.
//

import Foundation

public struct PopularTvShows: Codable {
    
    public let adult: Bool?
    public let backdropPath: String?
    public let firstAirDate: String?
    public let genreIds: [Int]?
    public let id: Int?
    public let name: String?
    public let originCountry: [String]?
    public let originalLanguage: String?
    public let originalName: String?
    public let overview: String?
    public let popularity: Double?
    public let posterPath: String?
    public let voteAverage: Double?
    public let voteCount: Int?
    public let originalTitle: String?
    public let releaseDate: String?
    public let title: String?
    public let video: Bool?
    
    public init(adult: Bool? = nil, backdropPath: String? = nil, firstAirDate: String? = nil, genreIds: [Int]? = nil, id: Int? = nil, name: String? = nil, originCountry: [String]? = nil, originalLanguage: String? = nil, originalName: String? = nil, overview: String? = nil, popularity: Double? = nil, posterPath: String? = nil, voteAverage: Double? = nil, voteCount: Int? = nil, originalTitle: String? = nil, releaseDate: String? = nil, title: String? = nil, video: Bool? = nil) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.firstAirDate = firstAirDate
        self.genreIds = genreIds
        self.id = id
        self.name = name
        self.originCountry = originCountry
        self.originalLanguage = originalLanguage
        self.originalName = originalName
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.originalTitle = originalTitle
        self.releaseDate = releaseDate
        self.title = title
        self.video = video
    }

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case firstAirDate = "first_air_date"
        case genreIds = "genre_ids"
        case id
        case name
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview
        case popularity
        case posterPath = "poster_path"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case originalTitle
        case releaseDate
        case title
        case video
    }
}
