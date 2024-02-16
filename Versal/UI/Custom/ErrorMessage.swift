//
// Copyright (C) 2019-2024 Six Clovers, Inc. - All rights reserved.
//
// Restricted and proprietary.
//

import SwiftUI

struct ErrorMessage: View {
    var message: String

    var body: some View {
        HStack(alignment: /*@START_MENU_TOKEN@*/ .center/*@END_MENU_TOKEN@*/, content: {
            Image("ic_warning")
            Text(message)
                .multilineTextAlignment(.center)
                .font(.system(size: 12))
                .foregroundColor(.versalError500)
        })
    }
}
