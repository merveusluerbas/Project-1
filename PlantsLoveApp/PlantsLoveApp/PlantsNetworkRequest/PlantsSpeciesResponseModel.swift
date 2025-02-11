//
//  PlantsSpeciesResponseModel.swift
//  PlantsLoveApp
//
//  Created by Merve Uslu Erbas on 25/7/24.
//

import Foundation

// MARK: - PlantsSpecies

struct PlantsSpecies: Codable {
    let data: [Datum]?
    let to, perPage, currentPage, from: Int?
    let lastPage, total: Int?

    enum CodingKeys: String, CodingKey {
        case data, to
        case perPage = "per_page"
        case currentPage = "current_page"
        case from
        case lastPage = "last_page"
        case total
    }
}

// MARK: - Datum
struct Datum: Codable {
    let id: Int?
    let commonName: String?
    let scientificName, otherName: [String]?
    let cycle: Cycle?
    let watering: Watering?
    let sunlight: [Sunlight]?
    let defaultImage: DefaultImage?

    enum CodingKeys: String, CodingKey {
        case id
        case commonName = "common_name"
        case scientificName = "scientific_name"
        case otherName = "other_name"
        case cycle, watering, sunlight
        case defaultImage = "default_image"
    }
}

enum Cycle: String, Codable {
    case perennial = "Perennial"
}

// MARK: - DefaultImage
struct DefaultImage: Codable {
    let license: Int?
    let licenseName: LicenseName?
    let licenseURL: String?
    let originalURL, regularURL, mediumURL, smallURL: String?
    let thumbnail: String?

    enum CodingKeys: String, CodingKey {
        case license
        case licenseName = "license_name"
        case licenseURL = "license_url"
        case originalURL = "original_url"
        case regularURL = "regular_url"
        case mediumURL = "medium_url"
        case smallURL = "small_url"
        case thumbnail
    }
}

enum LicenseName: String, Codable {
    case attributionLicense = "Attribution License"
    case attributionShareAlike30UnportedCCBYSA30 = "Attribution-ShareAlike 3.0 Unported (CC BY-SA 3.0)"
    case attributionShareAlikeLicense = "Attribution-ShareAlike License"
    case cc010UniversalCC010PublicDomainDedication = "CC0 1.0 Universal (CC0 1.0) Public Domain Dedication"
}

enum Sunlight: String, Codable {
    case filteredShade = "filtered shade"
    case fullSun = "full sun"
    case partShade = "part shade"
    case partSunPartShade = "part sun/part shade"
    case sunlightFullSun = "Full sun"
}

enum Watering: String, Codable {
    case average = "Average"
    case frequent = "Frequent"
}
