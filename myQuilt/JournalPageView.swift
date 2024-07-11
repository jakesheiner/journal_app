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
            
              
               // .edgesIgnoringSafeArea(.all)
          //  LinearGradient(gradient: Gradient(colors: [colorItem.color.color, Color.clear]), // Define your colors here
                      //  startPoint: .top, // Gradient starts at the top
                      //  endPoint: .bottom // Gradient ends at the bottom
                  //  )
            VStack {
                ZStack {
                    HStack {
                        Text(colorItem.date, formatter: dateFormatter)
                            .font(Font.custom("HelveticaNeue-Medium", size: 12))
                            .foregroundColor(colorItem.color.color.isDark() ? .white : .black)
                            .opacity(0.7)
                        .padding(.top)
                        .padding(.leading,32)
                        Spacer()
                    }
                    HStack {
                        
                    }
                    .padding([.top, .leading, .trailing], 32)
                .padding(.bottom, 16)
                }
                
                HStack {
                    Text(colorItem.text)
                        .font(Font.custom("HelveticaNeue-Medium", size: 20))
                        .foregroundColor(colorItem.color.color.isDark() ? .white : .black)
                        .padding(.horizontal, 32)
                        .padding(.bottom, 32)
                    Spacer()
                }
        
                
                HStack {
                    VStack {
                        Text(colorItem.name)
                            .font(Font.custom("HelveticaNeue-MediumItalic", size: 12))
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Text(colorItem.expl)
                            .font(Font.custom("HelveticaNeue-Italic", size: 12))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom,18)
                       
                    }
                   
                        .padding(.horizontal, 32)
                        .foregroundColor(colorItem.color.color.isDark() ? .white : .black)
                        .opacity(0.7)
                    Spacer()
                }
                Spacer()
                ZStack{
                    
                    if let imagePath = colorItem.imagePath,
                       let uiImage = loadImage(from: imagePath) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .aspectRatio( contentMode: .fit)
                            .frame(maxWidth: 360, maxHeight: 360)
                        // .padding(.vertical)
                            .edgesIgnoringSafeArea(.all)
                            .opacity(0.5)
                        //.cornerRadius(30)
                            .blendMode(.multiply)
                    }
                   Rectangle()
                        
                        .fill(LinearGradient(colors: [colorItem.color.color, Color.clear], startPoint: .top, endPoint: .center))
                        .frame(maxWidth: 360, maxHeight: 360)
                }
            }
        }
        
        .cornerRadius(30)
       .padding(.horizontal,16)
        
    }
    private func loadImage(from path: String) -> UIImage? {
            let fileURL = URL(fileURLWithPath: path)
            if let data = try? Data(contentsOf: fileURL) {
                return UIImage(data: data)
            }
            return nil
        }
}

#Preview {
    JournalPageView(
        colorItem: JournalEntry(
            text: "Sample Journal Entry, it shodl be longer to look more realistic. Y'know lorem Ipsum n shit",
            color: Color(hex: "999999"),
            date: Date(),
            name: "Sample Name",
            expl:"what is going on and on and on and on and this color was chosen for a reason etc.",
            imagePath: "/Users/jacobsheiner/Library/Developer/Xcode/UserData/Previews/Simulator Devices/AD675D2E-8C79-48F8-8260-DAEE1D626692/data/Containers/Data/Application/7D3FF4C8-EC7D-4482-9191-7FA38004E016/Documents/2682E845-8F3C-4EC2-B142-1829B415D901.png"
           
        ),
        selectedTab: .constant(2),
        journalEntryList: JournalEntryList.shared
    )
    .tabViewStyle(.page(indexDisplayMode: .automatic))
    .cornerRadius(30)
    //.padding()
    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
}
