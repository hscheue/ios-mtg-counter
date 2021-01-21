//
//  StoreKitTesting.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/18/21.
//

import SwiftUI
import StoreKit

class UserDefaultsKeys {
    
    class var processCompletedCountKey: String {
        return "processCompletedCount"
    }
    
    class var lastVersionPromptedForReviewKey: String {
        return "lastVersionPromptedForReview"
    }
    
}


struct AppReviewController {
    private static func unwrapURL(string: String) -> URL {
        guard let validURL = URL(string: string) else { fatalError("Expected a valid URL") }
        return validURL
    }
    static let appstoreReview = unwrapURL(string: "itms-apps://apps.apple.com/app/mtg-life-counting-tool/id1546302581?action=write-review")
    static let appstorePage = unwrapURL(string: "itms-apps://apps.apple.com/app/mtg-life-counting-tool/id1546302581")
    
    static func openAppstorePage() { UIApplication.shared.open(appstorePage) }
    static func openManualReview() { UIApplication.shared.open(appstoreReview) }
    
    static func playerStateActivityMetricReached(playerStates: [PlayerState]) {
        let count = playerStates.reduce(into: 0) { result, playerState in
            result += playerState.history.count
        }
        if (playerStates.count > 0 && (count / playerStates.count) > 10) {
            handleMetricReached()
        }
    }
    
    static func handleMetricReached() {
        let infoDictionaryKey = kCFBundleVersionKey as String
        guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: infoDictionaryKey) as? String
            else { return }
        
        let lastVersionPromptedForReview = UserDefaults.standard.string(forKey: UserDefaultsKeys.lastVersionPromptedForReviewKey)
        
        if currentVersion != lastVersionPromptedForReview {
            
            var count = UserDefaults.standard.integer(forKey: UserDefaultsKeys.processCompletedCountKey)
            count += 1
            UserDefaults.standard.set(count, forKey: UserDefaultsKeys.processCompletedCountKey)
            
            if (count >= 4) {
                triggerManualReview()
            }
            
        }
    }
    static func triggerManualReview() {
        // TODO: Add a game timer, Game time + PlayerState length total + version and count checks = prompt
        // https://developer.apple.com/documentation/storekit/skstorereviewcontroller/requesting_app_store_reviews
        let infoDictionaryKey = kCFBundleVersionKey as String
        guard let currentVersion = Bundle.main.object(forInfoDictionaryKey: infoDictionaryKey) as? String
            else { return }
        
        if let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            SKStoreReviewController.requestReview(in: scene)
        }
        
        UserDefaults.standard.set(currentVersion, forKey: UserDefaultsKeys.lastVersionPromptedForReviewKey)
        UserDefaults.standard.set(0, forKey: UserDefaultsKeys.processCompletedCountKey)

    }
}
