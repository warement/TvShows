//
//  TvShowDetails.swift
//  Domain
//
//  Created by Lefteris Altouvas Manolou on 9/7/23.
//

import Foundation

// MARK: - TvShowDetails
public struct TvShowDetails: Codable {
        
    public let adult: Bool?
    public let backdropPath: String?
    public let createdBy: [CreatedBy]?
    public let episodeRunTime: [Int]?
    public let firstAirDate: String?
    public let genres: [Genres]?
    public let homepage: String?
    public let id: Int?
    public let inProduction: Bool?
    public let languages: [String]?
    public let lastAirDate: String?
    public let lastEpisodeToAir: EpisodeDetails?
    public let name: String?
    public let nextEpisodeToAir: EpisodeDetails?
    public let networks: [TvNetworks]?
    public let numberOfEpisodes: Int?
    public let numberOfSeasons: Int?
    public let originCountry: [String]?
    public let originalLanguage: String?
    public let originalName: String?
    public let overview: String?
    public let popularity: Double?
    public let posterPath: String?
    public let seasons: [Seasons]?
    public let spokenLanguages: [SpokenLanguages]?
    public let status: String?
    public let tagline: String?
    public let type: String?
    public let voteAverage: Double?
    public let voteCount: Int?
    
    public init(adult: Bool? = nil, backdropPath: String? = nil, createdBy: [CreatedBy]? = nil, episodeRunTime: [Int]? = nil, firstAirDate: String? = nil, genres: [Genres]? = nil, homepage: String? = nil, id: Int? = nil, inProduction: Bool? = nil, languages: [String]? = nil, lastAirDate: String? = nil, lastEpisodeToAir: EpisodeDetails? = nil, name: String? = nil, nextEpisodeToAir: EpisodeDetails? = nil, networks: [TvNetworks]? = nil, numberOfEpisodes: Int? = nil, numberOfSeasons: Int? = nil, originCountry: [String]? = nil, originalLanguage: String? = nil, originalName: String? = nil, overview: String? = nil, popularity: Double? = nil, posterPath: String? = nil, seasons: [Seasons]? = nil, spokenLanguages: [SpokenLanguages]? = nil, status: String? = nil, tagline: String? = nil, type: String? = nil, voteAverage: Double? = nil, voteCount: Int? = nil) {
        self.adult = adult
        self.backdropPath = backdropPath
        self.createdBy = createdBy
        self.episodeRunTime = episodeRunTime
        self.firstAirDate = firstAirDate
        self.genres = genres
        self.homepage = homepage
        self.id = id
        self.inProduction = inProduction
        self.languages = languages
        self.lastAirDate = lastAirDate
        self.lastEpisodeToAir = lastEpisodeToAir
        self.name = name
        self.nextEpisodeToAir = nextEpisodeToAir
        self.networks = networks
        self.numberOfEpisodes = numberOfEpisodes
        self.numberOfSeasons = numberOfSeasons
        self.originCountry = originCountry
        self.originalLanguage = originalLanguage
        self.originalName = originalName
        self.overview = overview
        self.popularity = popularity
        self.posterPath = posterPath
        self.seasons = seasons
        self.spokenLanguages = spokenLanguages
        self.status = status
        self.tagline = tagline
        self.type = type
        self.voteAverage = voteAverage
        self.voteCount = voteCount
    }

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case createdBy = "created_by"
        case episodeRunTime = "episode_run_time"
        case firstAirDate = "first_air_date"
        case genres, homepage , id
        case inProduction = "in_production"
        case languages
        case lastAirDate = "last_air_date"
        case lastEpisodeToAir = "last_episode_to_air"
        case name
        case nextEpisodeToAir = "next_episode_to_air"
        case networks
        case numberOfEpisodes = "number_of_episodes"
        case numberOfSeasons = "number_of_seasons"
        case originCountry = "origin_country"
        case originalLanguage = "original_language"
        case originalName = "original_name"
        case overview, popularity
        case posterPath = "poster_path"
        case seasons
        case spokenLanguages = "spoken_languages"
        case status, tagline, type
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    
}

// MARK: - CreatedBy
public struct CreatedBy: Codable {
    
    public let id: Int?
    public let creditId: String?
    public let name: String?
    public let gender: String?
    public let profilePath: String?
    
    public init(id: Int? = nil, creditId: String? = nil, name: String? = nil, gender: String? = nil, profilePath: String? = nil) {
        self.id = id
        self.creditId = creditId
        self.name = name
        self.gender = gender
        self.profilePath = profilePath
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case creditId = "credit_id"
        case name, gender
        case profilePath = "profile_path"
    }
}

// MARK: - Genres
public struct Genres: Codable {
    
    public let id: Int?
    public let name: String?
    
    public init(id: Int? = nil, name: String? = nil) {
        self.id = id
        self.name = name
    }
}

// MARK: - Episode Details
public struct EpisodeDetails: Codable {
    
    public let id: Int?
    public let name: String?
    public let overview: String?
    public let voteAverage: Double?
    public let voteCount: Int?
    public let airDate: String?
    public let episodeNumber: Int?
    public let productionCode: String?
    public let runtime: Int?
    public let seasonNumber: Int?
    public let showId: Int?
    public let stillPath: String?
    
    public init(id: Int? = nil, name: String? = nil, overview: String? = nil, voteAverage: Double? = nil, voteCount: Int? = nil, airDate: String? = nil, episodeNumber: Int? = nil, productionCode: String? = nil, runtime: Int? = nil, seasonNumber: Int? = nil, showId: Int? = nil, stillPath: String? = nil) {
        self.id = id
        self.name = name
        self.overview = overview
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.airDate = airDate
        self.episodeNumber = episodeNumber
        self.productionCode = productionCode
        self.runtime = runtime
        self.seasonNumber = seasonNumber
        self.showId = showId
        self.stillPath = stillPath
    }
    
    enum CodingKeys: String, CodingKey {
        case id, name, overview
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
        case airDate = "air_date"
        case episodeNumber = "episode_number"
        case productionCode = "production_code"
        case runtime
        case seasonNumber = "season_number"
        case showId = "show_id"
        case stillPath = "still_path"
        
        
    }
}

// MARK: - Seasons
public struct Seasons: Codable {
    
    public let airDate: String?
    public let episodeCount: Int?
    public let id: Int?
    public let name: String?
    public let overview: String?
    public let posterPath: String?
    public let seasonNumber: Int?
    
    public init(airDate: String? = nil, episodeCount: Int? = nil, id: Int? = nil, name: String? = nil, overview: String? = nil, posterPath: String? = nil, seasonNumber: Int? = nil) {
        self.airDate = airDate
        self.episodeCount = episodeCount
        self.id = id
        self.name = name
        self.overview = overview
        self.posterPath = posterPath
        self.seasonNumber = seasonNumber
    }
    
    enum CodingKeys: String, CodingKey {
        case airDate = "air_date"
        case episodeCount = "episode_count"
        case id, name, overview
        case posterPath = "poster_path"
        case seasonNumber = "season_number"
    }
}

//MARK: - Spoken Languages
public struct SpokenLanguages: Codable {
    
    public let englishName: String?
    public let iso6391: String?
    public let name: String?
    
    public init(englishName: String? = nil, iso6391: String? = nil, name: String? = nil) {
        self.englishName = englishName
        self.iso6391 = iso6391
        self.name = name
    }
    
    enum CodingKeys: String, CodingKey {
        case englishName = "english_name"
        case iso6391 = "iso_639_1"
        case name
    }
}
