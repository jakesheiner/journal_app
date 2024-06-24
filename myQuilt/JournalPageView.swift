//
//  JournalPageView.swift
//  myQuilt
//
//  Created by Jacob Sheiner on 6/14/24.
//

import SwiftUI

struct JournalPageView: View {
    var colorItem: JournalEntry
    @Binding var selectedTab: Int
    @ObservedObject var journalEntryList: JournalEntryList
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        ZStack {
          //  Image("paper")
               // .resizable()
               // .scaledToFill()
              //  .edgesIgnoringSafeArea(.all)
            colorItem.color.color
              //  .blendMode(.multiply)
                .edgesIgnoringSafeArea(.all)
            VStack {
                ZStack {
                    HStack {
                        Text(colorItem.date, formatter: dateFormatter)
                            .font(.headline)
                            .foregroundColor(colorItem.color.color.isDark() ? .white : .black)
                            .opacity(0.7)
                        .padding(.top)
                        .padding(.leading,32)
                        Spacer()
                    }
                    HStack {
                        Spacer()
                        if selectedTab > 0 {
                            Button(action: { selectedTab = 0 }, label: {
                                Image(systemName:"arrowshape.turn.up.backward.2")
                                    .foregroundColor(colorItem.color.color.isDark() ? .white : .black)
                                    .opacity(0.7)
                                    .font(.title2)
                            })
                            .padding(.horizontal,32)
                        }
                            
                       // Spacer()
                        Button(action: { journalEntryList.removeObject(withID: colorItem.id) }, label: {
                            Image(systemName:"x.circle")
                                .foregroundColor(colorItem.color.color.isDark() ? .white : .black)
                                .opacity(0.7)
                                .font(.title2)
                        })
                    }
                    .padding([.top, .leading, .trailing], 32)
                .padding(.bottom, 16)
                }
                
                HStack {
                    Text(colorItem.text)
                        .font(Font.custom("HelveticaNeue-Medium", size: 28))
                        .foregroundColor(colorItem.color.color.isDark() ? .white : .black)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 32)
                    Spacer()
                }
        
                HStack {
                    VStack {
                        Text(colorItem.name)
                            .font(Font.custom("HelveticaNeue-MediumItalic", size: 18))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        Text(colorItem.expl)
                            .font(Font.custom("HelveticaNeue-Italic", size: 18))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom,18)
                       
                    }
                   
                        .padding(.horizontal, 32)
                        .foregroundColor(colorItem.color.color.isDark() ? .white : .black)
                        .opacity(0.7)
                    Spacer()
                }
                Spacer()
            }
        }
       
        .cornerRadius(30)
       .padding(.horizontal,16)
        
    }
}

#Preview {
    JournalPageView(
        colorItem: JournalEntry(
            text: "Sample Journal Entry, it shodl be longer to look more realistic. Y'know lorem Ipsum n shit",
            color: Color(hex: "111111"),
            date: Date(),
            name: "Sample Name",
            expl:"what is going on and on and on and on and this color was chosen for a reason etc."
           
        ),
        selectedTab: .constant(2),
        journalEntryList: JournalEntryList.shared
    )
    .tabViewStyle(.page(indexDisplayMode: .automatic))
    .cornerRadius(30)
    //.padding()
    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
}
