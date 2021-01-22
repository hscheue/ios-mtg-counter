//
//  DebounceSettingView.swift
//  TcgLifeCounter
//
//  Created by harry scheuerle on 1/22/21.
//

import SwiftUI

struct DebounceSettingView {
    let debounceValues = [
        0.25, 0.5, 1.0, 2.0, 5.0, 10.0
    ];
}

extension DebounceSettingView: View {
    
    var body: some View {
        Text("Hello, World!")
    }
}

struct DebounceSettingView_Previews: PreviewProvider {
    static var previews: some View {
        DebounceSettingView()
            .previewLayout(.sizeThatFits)
    }
}
