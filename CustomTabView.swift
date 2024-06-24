//
//  customTabView.swift
//  myQuilt
//
//  Created by Jacob Sheiner on 6/16/24.
//

import SwiftUI

import SwiftUI

struct CustomTabView: View {
    @State private var showingCredits = false
    @State private var selectedTab = 0

    var body: some View {
 
            ZStack {
                Color(hex:"#FFFAFA")
                    .ignoresSafeArea()
                // LinearGradient(gradient: Gradient(colors: [.white, .pink]), startPoint: .top, endPoint: .bottom)
                
                
                
                
                VStack {
                    if selectedTab == 0 {
                        JournalView()
                        // .padding(.horizontal)
                        
                    } else {
                        QuiltView()
                    }
                    //Spacer()
                    
                    Spacer()
                    HStack {
                        Button(action: {
                            selectedTab = 0
                        }) {
                            Image(systemName: "book")
                            // Text("First")
                                .foregroundColor(selectedTab == 0 ? .black : .gray)
                                .font(.title2)
                        }
                        
                        .padding(.horizontal, 64)
                        Spacer()
                        Button(action: {
                            showingCredits.toggle()
                        }) {
                            Image(systemName: "plus.app.fill")
                               // .resizable()
                               // .frame(width: 20, height: 20)
                                .font(.title)
                                .foregroundColor(.gray)
                                .padding()
                               // .background(Circle().fill(Color.gray.opacity(0.3)))
                               // .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                        }
                        
                        
                        
                        .ignoresSafeArea(.keyboard)
                        Spacer()
                        Button(action: {
                            selectedTab = 1
                        }) {
                            
                            Image(systemName: "squareshape.split.3x3")
                                .foregroundColor(selectedTab == 1 ? .black : .gray)
                                .font(.title2)
                            
                        }
                        .padding(.horizontal, 64)
                    }
                    .padding(.bottom)
                    
                    
                }
                if(showingCredits){
                    Rectangle()
                        .fill(.thinMaterial)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                }
                //  .padding(320)
                
            }
            .fullScreenCover(isPresented: $showingCredits) {
                TextEntryView(isPresented: $showingCredits)
                    .presentationDetents([.fraction(0.99), .large])
                    .presentationBackground(.clear)
                
                //.presentationCornerRadius(30)
                
            }
        
      //  .ignoresSafeArea(.keyboard, edges: .all)
    }
    
}


struct YourApp: App {
    var body: some Scene {
        WindowGroup {
            CustomTabView()
        }
    }
}


#Preview {
    CustomTabView()
}
