//
//  ContentView.swift
//  CrackTheCode
//
//  Created by Ari on 19/03/22.
//

import SwiftUI

let levelData = ["level1": ["image": "img1", "correctAnswer": "164"], "level2":  ["image": "img2", "correctAnswer": "205"], "level3":  ["image": "img3", "correctAnswer": "319"], "level4": ["image": "img4", "correctAnswer": "118"]]

struct ContentView: View {
    
    @State private var isPin1FirstResponder: Bool? = true
    @State private var isPin2FirstResponder: Bool? = false
    @State private var isPin3FirstResponder: Bool? = false
    @State private var isPin4FirstResponder: Bool? = false
    
    @State private var token1 = ""
    @State private var token2 = ""
    @State private var token3 = ""
    
    @State private var i = 1
    @State var finalString = ""
  
    @State var attempts: Int = 0
    
    //Screen bound
    let screenSize = UIScreen.main.bounds
    
    var body: some View {
        
        ZStack(alignment: .top){
            Rectangle()
                .frame(width: screenSize.width * 0.94, height: screenSize.height * 0.94, alignment: .center)
                .foregroundColor(Color("backgroundColor"))
                .cornerRadius(20)
            
            VStack(alignment: .center, spacing: 50) {
                
                Text("Level \(i)")
                    .font(.custom("coiny-regular", size: 80))
                    .foregroundColor(Color("themeColor"))
                    .shadow(color: Color("shadowColor"), radius: 0, x: 5, y: 5)
                
                
                Image(levelData["level\(i)"]!["image"] ?? "")
                
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: screenSize.width * 0.8, height:  screenSize.width * 0.6, alignment: .center)
                
                HStack(alignment: .center, spacing: 30) {
                    Group {
                        
                        VStack {
                            CustomTextField(text: self.$token1,
                                            nextResponder: self.$isPin2FirstResponder,
                                            isResponder: self.$isPin1FirstResponder, previousResponder: .constant(nil))
                            
                            
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color("customPurple"))
                                .frame(width: 70, height: 20, alignment: .center)
                            
                        }
                        
                        
                        VStack {
                            CustomTextField(text: self.$token2,
                                            nextResponder: self.$isPin3FirstResponder,
                                            isResponder: self.$isPin2FirstResponder, previousResponder: self.$isPin1FirstResponder)
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 70, height: 20, alignment: .center)
                                .foregroundColor(Color("customYellow"))
                        }
                        
                        VStack {
                            CustomTextField(text: self.$token3,
                                            nextResponder: self.$isPin4FirstResponder,
                                            isResponder: self.$isPin3FirstResponder, previousResponder: self.$isPin2FirstResponder)
                            
                            
                            RoundedRectangle(cornerRadius: 10)
                                .frame(width: 70, height: 20, alignment: .center)
                                .foregroundColor(Color("customBlue"))
                        }
                        
                        
                        
                        
                    }
                    .frame(width: screenSize.width * 0.06, height: 5)
                    .font(Font.system(size: 40, design: .default))
                    .multilineTextAlignment(.center)
                }
                .modifier(Shake(animatableData: CGFloat(attempts)))
                .padding(.top, 85.0)
                
                
                VStack{
                    Button("Submit") {
                        finalString = token1 + token2 + token3
                        token1 = ""
                        token2 = ""
                        token3 = ""
                        
                        let answer = levelData["level\(i)"]!["correctAnswer"]
                        if answer == finalString {
                            i += 1
                        } else {
                            withAnimation(.default) {
                                self.attempts += 5
                            }
                        }
                    }
                    
                    .frame(width: screenSize.width * 0.35, height: 90, alignment: .center)
                    .background(Color("themeColor"))
                    
                    .font(.custom("coiny-regular", size: 50))
                    .cornerRadius(70)
                    .padding(.top, 140.0)
                    .foregroundColor(.white)
                }
                
                .shadow(color: Color("shadowColor"), radius: 0, x: -3, y: 12)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
