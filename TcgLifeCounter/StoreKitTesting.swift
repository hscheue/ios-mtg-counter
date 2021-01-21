//
//  StoreKitTesting.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/18/21.
//

import SwiftUI
//import StoreKit

struct AppReviewController {
    private static func unwrapURL(string: String) -> URL {
        guard let validURL = URL(string: string) else { fatalError("Expected a valid URL") }
        return validURL
    }
    static let appstoreReview = unwrapURL(string: "itms-apps://apps.apple.com/app/mtg-life-counting-tool/id1546302581?action=write-review")
    static let appstorePage = unwrapURL(string: "itms-apps://apps.apple.com/app/mtg-life-counting-tool/id1546302581")
    
    static func openAppstorePage() { UIApplication.shared.open(appstorePage) }
    static func openManualReview() { UIApplication.shared.open(appstoreReview) }
    
//    static func triggerManualReview() {
//        // TODO: Add a game timer, Game time + PlayerState length total + version and count checks = prompt
//        // https://developer.apple.com/documentation/storekit/skstorereviewcontroller/requesting_app_store_reviews
//        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
//            SKStoreReviewController.requestReview(in: scene)
//        }
//    }
}
