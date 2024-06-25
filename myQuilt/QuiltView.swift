import SwiftUI



struct QuiltView: View {
    @ObservedObject private var journalEntryList = JournalEntryList.shared
    
    
    @State private var selectedSquare: JournalEntry? = nil
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
       // formatter.timeStyle = .short
        return formatter
    }
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
       // formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    
    var body: some View {
        ZStack {
            
            GeometryReader { geometry in
                
                let screenWidth = geometry.size.width
                let itemSize = (screenWidth-12) / 3
                
                ZStack(alignment: .top) {
                    
                    ScrollView{
                        
                    LazyVGrid(columns: Array(repeating: GridItem(.fixed(itemSize), spacing: 3), count: 3), spacing: 3) {
                        ForEach(journalEntryList.myArray) { square in
                            ZStack {
                                square.color.color
                                    .cornerRadius(2)
                                VStack {
                                    HStack {
                                        
                                        Text("\(square.date, formatter: dateFormatter)")
                                            .font(.caption)
                                            .fontWeight(.heavy)
                                       
                                            .foregroundColor(square.color.color.isDark() ? .white : .black)
                                    
                                        Spacer()
                                    }
                                    HStack {
                                        Text(square.date, formatter: timeFormatter)
                                            .font(.caption2)
                                            .foregroundColor(square.color.color.isDark() ? .white : .black)
                                        Spacer()
                                    }
                                        Spacer()
                                    
                                    
                                    Spacer()
                                       
                                }
                                .padding()
                            }
                                 
                                    //.blendMode(.multiply)
                                  //  .shadow(color:Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.2),radius: 10)
                                    .frame(width: itemSize, height: itemSize)
                                    .onTapGesture {
                                        selectedSquare = square
                                    }
                                    .contextMenu {
                                        Button(action: {
                                            journalEntryList.removeObject(withID: square.id)
                                        }) {
                                            Text("Remove")
                                            Image(systemName: "trash")
                                        }
                                }
                            
                        }
                    }
                }
                    .frame(width: screenWidth)
                  
                }
            }
          
            LinearGradient(stops: [
                Gradient.Stop(color: .clear, location: 0.5),
                Gradient.Stop(color:Color(hex:"#FFFAFA"), location: 1),
            ], startPoint: .center, endPoint: .bottom)
                    .allowsHitTesting(false)
            
            //.edgesIgnoringSafeArea(.top) // Ensures the grid takes up the full screen
        //.background(Color(hex:"ede8e8"))
            
        }
    }
    
    
}

struct QuiltView_Previews: PreviewProvider {
    static var previews: some View {
        QuiltView()
    }
}
