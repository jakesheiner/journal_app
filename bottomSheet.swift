//
//  bottomSheet.swift
//  myQuilt
//
//  Created by Jacob Sheiner on 6/16/24.
//

import SwiftUI

struct bottomSheet: View {
    @State private var showingCredits = false

    var body: some View {
        
        Color(.red)
            .ignoresSafeArea()
        Button("Show Credits") {
            showingCredits.toggle()
        }
        .sheet(isPresented: $showingCredits) {
            TextEntryView(isPresented: $showingCredits)
             
               
        }
       
    }
}

#Preview {
    bottomSheet()
}
