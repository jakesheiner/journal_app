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
           // LinearGradient(gradient: Gradient(colors: [.white, .pink]), startPoint: .top, endPoint: .bottom)
            if (selectedTab == 0) {
                Image("leather")
                    .resizable()
                    //.scaledToFit()
                    .edgesIgnoringSafeArea(.all)
            } else {
               // Image("fabric")
                   // .resizable()
                   // .scaledToFill()
                   // .edgesIgnoringSafeArea(.all)
                LinearGradient(stops: [
                    Gradient.Stop(color: .white, location: 0.7),
                    Gradient.Stop(color: .black, location: 1),
                ], startPoint: .top, endPoint: .bottom)
                    .edgesIgnoringSafeArea(.all)
                    .blendMode(.multiply)
            }
            
            
            
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
                            .foregroundColor(selectedTab == 0 ? .white : .gray)
                            .font(.title2)
                    }
                    
                    .padding(.horizontal, 64)
                    Spacer()
                    Button(action: {
                                   showingCredits.toggle()
                               }) {
                                   Image(systemName: "plus")
                                       .resizable()
                                       .frame(width: 20, height: 20)
                                       .foregroundColor(.white)
                                       .padding()
                                       .background(Circle().fill(Color.gray.opacity(0.3)))
                                       .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                               }
                               .sheet(isPresented: $showingCredits) {
                                   TextEntryView(isPresented: $showingCredits)
                                       .presentationDetents([.fraction(0.99), .large])
                                       .presentationBackground(.ultraThinMaterial)
                                       .presentationCornerRadius(30)
                               }
                    Spacer()
                    Button(action: {
                        selectedTab = 1
                    }) {
                       
                            Image(systemName: "squareshape.split.3x3")
                                .foregroundColor(selectedTab == 1 ? .white : .gray)
                                .font(.title2)
                        
                    }
                    .padding(.horizontal, 64)
                }
                .padding(.bottom)
               
                
            }
          //  .padding(320)
          
        }
      
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
