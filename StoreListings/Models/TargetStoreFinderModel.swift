//
//  TargetStoreFinderModel.swift
//  StoreListings
//
//  Created by Kelvin CK Chan on 12/16/21.
//

import Foundation
import UIKit

struct TargetStoresResponse: Decodable {
    struct TargetData: Decodable {
        struct NearbyStores: Decodable {
            struct NearbyStore: Decodable {
                struct MailingAddress: Decodable {
                    let addressLine1: String
                    let city: String
                    let state: String
                    let postalCode: String
                    
                    var description: String {
                        return "\(addressLine1) \(city), \(state) \(postalCode)"
                    }
                }
                let locationName: String
                let mailingAddress: MailingAddress
            }
            let stores: [NearbyStore]
            let count: Int
        }
        let nearbyStores: NearbyStores
    }
    let data: TargetData
}

typealias TargetStore = TargetStoresResponse.TargetData.NearbyStores.NearbyStore

struct TargetStoreFinder {
    func getStores(where zipCode: String, callback: @escaping ([TargetStore]) -> Void) {
            if (zipCode.range(of: #"^\d{5}$"#,
                              options: .regularExpression) == nil) {
                callback([])
            }
            guard let url = URL(string: "https://redsky.target.com/redsky_aggregations/v1/web_platform/nearby_stores_v1?limit=5&within=100&place=\(zipCode)&key=8df66ea1e1fc070a6ea99e942431c9cd67a80f02") else {
                assertionFailure("Invalid URL")
                return
            }
            let task = URLSession.shared.dataTask(with: url) { (maybeData: Data?, maybeUrlResponse: URLResponse?, maybeError: Error?) in
                guard let targetData = maybeData else {
                    assertionFailure("No data response from API")
                    return
                }
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    let response = try decoder.decode(TargetStoresResponse.self, from: targetData)
                    callback(response.data.nearbyStores.stores)
                } catch {
                    print(error)
                }
            }
            task.resume()
        }
}
