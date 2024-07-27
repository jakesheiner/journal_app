//
//  customTabView.swift
//  myQuilt
//
//  Created by Jacob Sheiner on 6/16/24.
//


import SwiftUI

struct CustomTabView: View {
    @State private var showingCredits = false
    @State private var selectedTab = 0
    @State private var loading: Bool = false
    @State private var showJournal: Bool = false
   
   
    var body: some View {
 
        ZStack {
            Color(hex:"#FFFAFA")
                .ignoresSafeArea()
            // LinearGradient(gradient: Gradient(colors: [.white, .pink]), startPoint: .top, endPoint: .bottom)
            
            
            
            
            
            //  if selectedTab == 0 {
            //    JournalView(selectedTab: .constant(0))
            // .padding(.horizontal)
            
            //} else {
            QuiltView(showJournal: $showJournal, selectedTab: 0, isLoading: $loading)
            
            //}
            //Spacer()
            
            
            
            // .padding(.bottom)
            
            
            
            
            
            
            if(showingCredits){
                Rectangle()
                    .fill(.thinMaterial)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            }
            //  .padding(320)
            if(showJournal == false){
            VStack {
                Spacer()
                HStack {
                    /*   Button(action: {
                     selectedTab = 0
                     }) {
                     Image(systemName: "book")
                     // Text("First")
                     .foregroundColor(selectedTab == 0 ? .black : .gray)
                     .font(.title2)
                     }
                     
                     .padding(.horizontal, 64)
                     Spacer()
                     */
                    Button(action: {
                        showingCredits.toggle()
                    }) {
                        Image(systemName: "plus")
                        
                        // .resizable()
                        
                            .font(.largeTitle)
                            .foregroundColor(.black)
                            .padding()
                            .background(Circle()
                                .fill(.white)
                                .frame(width: 70, height:70)
                            )
                            .shadow(radius: 5)
                    }
                    
                    
                    
                    .ignoresSafeArea(.keyboard)
                    /*
                     Spacer()
                     Button(action: {
                     selectedTab = 1
                     }) {
                     
                     Image(systemName: "squareshape.split.3x3")
                     .foregroundColor(selectedTab == 1 ? .black : .gray)
                     .font(.title2)
                     
                     }
                     .padding(.horizontal, 64)
                     */
                }
                .padding(30)
            }
        }
            }
            //.edgesIgnoringSafeArea(.bottom)
            .fullScreenCover(isPresented: $showingCredits) {
                TextEntryView(isPresented: $showingCredits, loading: $loading)
                    .presentationDetents([.fraction(0.99), .large])
                    .presentationBackground(.clear)
                
                //.presentationCornerRadius(30)
                
            }
        
      //  .ignoresSafeArea(.keyboard, edges: .all)
    }
    
}






struct CustomTabView_Previews: PreviewProvider {
   
    static var previews: some View {
        CustomTabView()
    }
}
