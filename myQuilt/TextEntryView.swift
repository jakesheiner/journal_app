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
                Color(hex:"#FFFAFA")
                GeometryReader { _ in
                    VStack {
                        ZStack {
                            
                            
                            HStack{
                                Text(Date(), formatter: dateFormatter)
                                    .font(.headline)
                                    .foregroundColor(Color.black)
                                    .padding(.leading,32)
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
                                    if viewModel.userInput == ""{
                                        Text("cancel")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                            .padding(.horizontal)
                                            .padding(.vertical,2)
                                            .background(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.gray, lineWidth: 1.5) // Rounded rectangle stroke with no fill
                                                                )
                                           
                                    }else{
                                        Text("submit")
                                            .font(.headline)
                                            .foregroundColor(.black)
                                            .padding(.horizontal)
                                            .padding(.vertical,2)
                                            .background(
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color.gray, lineWidth: 1.5)
                                            )
                                    }
                                    
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
                            .ignoresSafeArea(.keyboard)
                        //  .foregroundColor(.white)
                            .font(.custom("HelveticaNeue-Light", size: 17, relativeTo: .body))
                            .textFieldStyle(.plain)
                        // .padding(.vertical,16)
                            .padding(.horizontal,32)
                            .scrollContentBackground(.hidden)
                            .foregroundColor(.black)
                        //.background(Color(hex:"ffffff"))
                        // .shadow(color:.black,radius:10)
                            .cornerRadius(30)
                    }
                }
                .ignoresSafeArea(.keyboard, edges: .bottom)
                //   if viewModel.userInput.isEmpty {
                
                //   }
            }
            
            .cornerRadius(30)
            .padding(.top,16)
            .padding(.horizontal,16)
            .edgesIgnoringSafeArea(.bottom)
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

