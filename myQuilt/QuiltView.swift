import SwiftUI



struct QuiltView: View {
    @State private var showJournal = false
    @ObservedObject private var journalEntryList = JournalEntryList.shared
    @State var selectedTab: Int
    
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
        VStack {
            ZStack {
                
                GeometryReader { geometry in
                    
                    let screenWidth = geometry.size.width
                    let itemSize = (screenWidth-12) / 3
                    
                    ZStack(alignment: .top) {
                       
                        ScrollView{
                            
                        LazyVGrid(columns: Array(repeating: GridItem(.fixed(itemSize), spacing: 3), count: 3), spacing: 3) {
                            ForEach(journalEntryList.myArray) { square in
                                ZStack {
                                    if let imagePath = square.imagePath,
                                       let uiImage = loadImage(from: imagePath) {
                                        Image(uiImage: uiImage)
                                            .resizable()
                                            .opacity(0.5)
                                    }
                                    square.color.color
                                        .cornerRadius(2)
                                        .blendMode(.multiply)
                                    LinearGradient(gradient: Gradient(colors: [square.color.color, Color.clear]), // Define your colors here
                                                startPoint: .leading, // Gradient starts at the top
                                                endPoint: .trailing // Gradient ends at the bottom
                                            )
                                    VStack {
                                        HStack {
                                            
                                            Text("\(square.date, formatter: dateFormatter)")
                                            
                                                .font(.caption)
                                                .fontWeight(.heavy)
                                           
                                                .foregroundColor(square.color.color.isDark() ? .white : .black)
                                        
                                            Spacer()
                                        }
                                       // Text("\(journalEntryList.indexOfEntry(withID: square.id) ?? 0)")
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
                                .frame(width: itemSize, height: itemSize*0.618)
                                        .onTapGesture {
                                            selectedTab = journalEntryList.indexOfEntry(withID: square.id) ?? 0
                                            selectedSquare = square
                                            
                                        
                                            
                                            showJournal.toggle()
                                           // JournalView()
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
                        if(showJournal){
                           
                            ZStack {
                                Rectangle()
                                    .fill(.thinMaterial)
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                                    .ignoresSafeArea()
                                JournalView(selectedTab: $selectedTab)
                                    .transition(.scale)
                                    .onTapGesture {
                                        showJournal.toggle()
                                }
                            }
                        }
                    }
                }
              
             //   LinearGradient(stops: [
               //     Gradient.Stop(color: .clear, location: 0.6),
                 //   Gradient.Stop(color:Color(hex:"#FFFAFA"), location: 1),
              //  ], startPoint: .center, endPoint: .bottom)
                 //       .allowsHitTesting(false)
                
                //.edgesIgnoringSafeArea(.top) // Ensures the grid takes up the full screen
            //.background(Color(hex:"ede8e8"))
                
            }
        }
       // Divider()
         //   .overlay(Color.black)
           // .frame(minHeight:2)
    }
    private func loadImage(from path: String) -> UIImage? {
            let fileURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: fileURL) {
                return UIImage(data: data)
            }
            return nil
        }
    
}

struct QuiltView_Previews: PreviewProvider {
    static var previews: some View {
        QuiltView(selectedTab: 0)
    }
}
