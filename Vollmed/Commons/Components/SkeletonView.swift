//
//  SkeletonView.swift
//  Vollmed
//
//  Created by Felipe Assis on 13/01/24.
//

import SwiftUI

struct SkeletonView: View {
    var body: some View {
        VStack(spacing: 35) {
            ForEach(0..<4, id: \.self) { _ in
                SkeletonRow()
            }
        }
    }
}

struct SkeletonRow: View {
    private var placeholderString: String = "************************"

    var body: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16) {
                LinearGradient(gradient: Gradient(colors: [.gray, .white, .gray]),
                               startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                    .mask(
                        Circle()
                            .frame(width: 60, height: 60, alignment: .leading)
                            .redactedAnimation()
                    )
                    .frame(width: 60, height: 60)
                
                VStack(alignment: .leading, spacing: 8.0) {
                    LinearGradient(gradient: Gradient(colors: [.gray, .white, .gray]),
                                   startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                    .mask(
                        Text(placeholderString)
                            .redacted(reason: /*@START_MENU_TOKEN@*/.placeholder/*@END_MENU_TOKEN@*/)
                            .redactedAnimation()
                    )
                    
                    LinearGradient(gradient: Gradient(colors: [.gray, .white, .gray]),
                                   startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
                    .mask(
                        Text(placeholderString)
                            .redacted(reason: /*@START_MENU_TOKEN@*/.placeholder/*@END_MENU_TOKEN@*/)
                            .redactedAnimation()
                    )

                }
            }
        }
    }
}

#Preview {
    SkeletonView()
}
