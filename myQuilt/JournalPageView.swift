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
            Image("paper")
                .resizable()
               // .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            colorItem.color
                .blendMode(.multiply)
                .edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    if selectedTab > 0 {
                        Button(action: { selectedTab = 0 }, label: {
                            Image(systemName:"arrowshape.turn.up.backward.2")
                                .foregroundColor(colorItem.color.isDark() ? .white : .black)
                                .opacity(0.5)
                                .font(.title)
                        })
                    }
                    
                    Spacer()
                    Button(action: { journalEntryList.removeObject(withID: colorItem.id) }, label: {
                        Image(systemName:"x.circle")
                            .foregroundColor(colorItem.color.isDark() ? .white : .black)
                            .opacity(0.5)
                            .font(.title)
                    })
                }
                .padding([.top, .leading, .trailing], 32)
                .padding(.bottom, 16)
                
                HStack {
                    Text(colorItem.text)
                        .font(.title)
                        .foregroundColor(colorItem.color.isDark() ? .white : .black)
                        .padding(.leading, 32)
                        .padding(.bottom, 32)
                    Spacer()
                }
                
                HStack {
                    Text("\(colorItem.name)\n\(colorItem.date, formatter: dateFormatter)")
                        .padding(.leading, 32)
                        .foregroundColor(colorItem.color.isDark() ? .white : .black)
                        .opacity(0.5)
                    Spacer()
                }
                Spacer()
            }
        }
        .cornerRadius(30)
        
    }
}

#Preview {
    JournalPageView(
        colorItem: JournalEntry(
            text: "Sample Journal Entry",
            color: .blue,
            date: Date(),
            name: "Sample Name"
           
        ),
        selectedTab: .constant(0),
        journalEntryList: JournalEntryList.shared
    )
    .tabViewStyle(.page(indexDisplayMode: .automatic))
    .cornerRadius(30)
    .padding()
    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
}
