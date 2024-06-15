import SwiftUI

struct JournalView: View {
    @StateObject private var journalEntryList = JournalEntryList.shared
    @State private var selectedTab = 0
   
    var body: some View {
        ZStack {
            Image("leather")
                .resizable()
               // .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                HStack {
                    Text("My Journal")
                        .font(.headline)
                    Spacer()
                }
                .padding(.leading, 48)
                
                TabView(selection: $selectedTab) {
                    if journalEntryList.myArray.isEmpty {
                        Text("no entries yet ;)")
                            .foregroundColor(.gray)
                            .font(.title)
                            .tag(0)
                    }
                    ForEach(journalEntryList.myArray) { colorItem in
                        JournalPageView(colorItem: colorItem, selectedTab: $selectedTab, journalEntryList: journalEntryList)
                            .tag(journalEntryList.myArray.firstIndex(where: { $0.id == colorItem.id }) ?? 0 + 1)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .automatic))
                //.cornerRadius(30)
                .padding()
                .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                
                if journalEntryList.myArray.count > 1 {
                    Text("give it a swipe!")
                        .font(.caption2)
                        .foregroundColor(.gray)
                        .padding(.bottom, 32)
                }
            }
        }
        //.background(Color(hex:"ede8e8"))
    }
}

#Preview {
    JournalView()
}
