import SwiftUI



struct QuiltView: View {
    @StateObject private var journalEntryList = JournalEntryList.shared
    
    
    @State private var selectedSquare: JournalEntry? = nil
    
    var body: some View {
        ZStack {
            Image("fabric")
                .resizable()
               // .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            LinearGradient(gradient: Gradient(colors: [.white, .gray]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
                .blendMode(.multiply)
            GeometryReader { geometry in
                
                let screenWidth = geometry.size.width
                let itemSize = screenWidth / 3
                
                ZStack(alignment: .top) {
                    ScrollView{
                    LazyVGrid(columns: Array(repeating: GridItem(.fixed(itemSize), spacing: 0), count: 3), spacing: 0) {
                        ForEach(journalEntryList.myArray) { square in
                            square.color
                                .blendMode(.multiply)
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
                    
                    if let square = selectedSquare {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                            .onTapGesture {
                                selectedSquare = nil
                            }
                        
                        VStack {
                            square.color
                                .frame(width: 200, height: 200)
                                .cornerRadius(10)
                            Text(square.text)
                                .font(.headline)
                                .padding()
                        }
                        .frame(width: geometry.size.width * 0.6, height: geometry.size.height * 0.3)
                        .background(Color.white)
                        .cornerRadius(20)
                        .shadow(radius: 10)
                        .position(x: geometry.size.width / 2, y: geometry.size.height / 2)
                        .transition(.scale)
                    }
                }
            }
            .edgesIgnoringSafeArea(.top) // Ensures the grid takes up the full screen
        //.background(Color(hex:"ede8e8"))
        }
    }
    
    
}

struct QuiltView_Previews: PreviewProvider {
    static var previews: some View {
        QuiltView()
    }
}
