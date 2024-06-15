import SwiftUI
import Combine




struct TextEntryView: View {
    
    @StateObject private var viewModel = OpenAIViewModel()
    var body: some View {
        ZStack {
            Image("leather")
                .resizable()
            // .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            VStack {
                ZStack {
                    Image("paper") // Replace "backgroundImage" with the name of your image
                        .resizable()
                        //.scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .clipped()
                        .cornerRadius(30)
                    TextEditor( text: $viewModel.userInput)
                    //  .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .padding(16)
                        .scrollContentBackground(.hidden)
                        //.background(Color(hex:"ffffff"))
                        .shadow(color:.black,radius:10)
                        .cornerRadius(16)
                    //   if viewModel.userInput.isEmpty {
                    VStack {
                        
                     
                            
                            HStack {
                                Text("Whats on you mind?")
                                    .lineLimit(nil)
                                    .padding()
                                    .opacity(0.5)
                                // .foregroundColor(.white)
                                
                                
                                
                                Spacer()
                            }
                            .padding(16)
                        
                        
                        Spacer()
                    }
                    //   }
                }
                
                
                
                
                HStack {
                    Button(action: {
                        viewModel.fetchResponse(){
                            viewModel.uploadResponse()
                        }
                        
                        // print(viewModel.responseText)
                        // print("test")
                        
                        
                    }) {
                        Text("clear")
                            .padding([.leading,.trailing],48)
                            .padding([.top,.bottom],16)
                            //.background(Color(hex: "#008080"))
                            .border(Color.red,width: 5)
                            .foregroundColor(.red)
                            .cornerRadius(16)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    }
                    Spacer()
                    Button(action: {
                        viewModel.fetchResponse(){
                            viewModel.uploadResponse()
                        }
                        
                        // print(viewModel.responseText)
                        // print("test")
                        
                        
                    }) {
                        Text("Submit")
                            .padding([.leading,.trailing],48)
                            .padding([.top,.bottom],16)
                            .background(Color(hex: "#ffffff"))
                            .foregroundColor(.brown)
                            .cornerRadius(16)
                            .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    }
                
                }
                .padding(.vertical,32)
                .padding(.horizontal)
                
                
                Text(viewModel.responseText)
                    .padding()
                    .foregroundColor(.black)
                Spacer()
            }
            
            .padding()
            
        }
        
        
        
        
    }
    
}

struct TextEntryView_Previews: PreviewProvider {
    static var previews: some View {
        TextEntryView()
    }
}

