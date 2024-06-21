import SwiftUI
import Combine




struct TextEntryView: View {
    @FocusState private var keyboardFocused: Bool
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        return formatter
    }
    @Binding var isPresented: Bool
    @StateObject private var viewModel = OpenAIViewModel()
    var body: some View {
        
                ZStack {
                    Image("paper") // Replace "backgroundImage" with the name of your image
                        .resizable()
                        //.scaledToFill()
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .ignoresSafeArea()
                       // .clipped()
                       // .cornerRadius(10)
                        .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                    VStack {
                        ZStack {
                            Text(Date(), formatter: dateFormatter)
                                .font(.custom("PlayfairDisplayRoman-Bold", size: 17, relativeTo: .body))
                                .foregroundColor(Color.black)
                                
                            HStack{
                               
                                Spacer()
                                Button(action: {
                                    if viewModel.userInput == "" {
                                        isPresented.toggle()
                                        
                                    }else{
                                        viewModel.fetchResponse(){
                                            viewModel.uploadResponse()
                                            isPresented.toggle()
                                            viewModel.userInput = ""
                                        }
                                    }
                                    // print(viewModel.responseText)
                                    // print("test")
                                    
                                    
                                }) {
                                    Text("done")
                                        .font(.custom("PlayfairDisplay-Regular", size: 17, relativeTo: .body))
                                        .foregroundColor(.black)
                                      
                                }
                                .padding()
                            }
                        }
                        TextEditor( text: $viewModel.userInput)
                            .focused($keyboardFocused)
                                .onAppear {
                                  DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        keyboardFocused = true
                                    }
                                }
                        //  .foregroundColor(.white)
                            .font(.custom("PlayfairDisplay-Regular", size: 17, relativeTo: .body))
                            .textFieldStyle(.plain)
                            .padding(16)
                            .scrollContentBackground(.hidden)
                            .foregroundColor(.black)
                            //.background(Color(hex:"ffffff"))
                           // .shadow(color:.black,radius:10)
                        .cornerRadius(30)
                    }
                    //   if viewModel.userInput.isEmpty {
                    VStack {
                        
                         
                        
                        
                Spacer()
                    }
                    //   }
                }
                
        .background(Color.clear)
        .contentShape(Rectangle()) // Make the entire VStack tappable
                .onTapGesture {
                    hideKeyboard()
                }
        
        
        
    }
    func hideKeyboard() {
           UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
       }
}

struct TextEntryView_Previews: PreviewProvider {
    @State static var isPresented = true
    static var previews: some View {
        TextEntryView(isPresented: $isPresented)
    }
}

