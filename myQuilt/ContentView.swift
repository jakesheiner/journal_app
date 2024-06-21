import SwiftUI

struct ContentView: View {
    @State private var showingCredits = false
    init() {
            // Customizing the tab bar appearance
            let appearance = UITabBarAppearance()
            appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.clear// Background color of the tab bar
        appearance.stackedLayoutAppearance.selected.iconColor = UIColor(red:1,green:1,blue:1,alpha:1)// Selected icon color
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: UIColor.gray] // Selected text color
            appearance.stackedLayoutAppearance.normal.iconColor = UIColor.gray // Unselected icon color
           // appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white] // Unselected text color
            
            UITabBar.appearance().standardAppearance = appearance
      
        
        }
   
    var body: some View {
     
        ZStack {
            TabView {
                    
                 //  TextEntryView()
                     //   .tabItem {
                        //    Image(systemName: "pencil")
                                //Text("Write")
                    //}
                    
                    JournalView()
                        .tabItem {
                            Image(systemName: "book")
                            //Text("Journal")
                        }
                    
                    
                    QuiltView()
                        .tabItem {
                            Image(systemName: "squareshape.split.3x3")
                           // Text("My Quilt")
                        }
            }
            VStack {
                Spacer()
                
                Button("Show Credits") {
                    showingCredits.toggle()
                }
                .sheet(isPresented: $showingCredits) {
                    TextEntryView(isPresented: $showingCredits)
                }
            }
        }
        
       
           // .accentColor(.orange)
           
      
    }

   
    }

    
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
