//
//  ContentView.swift
//  Animations
//
//  Created by COBE on 16/04/2021.
//

import SwiftUI

struct CornerRotateModifier: ViewModifier {
    let amount: Double
    let anchor: UnitPoint
    func body(content: Content) -> some View {
        content.rotationEffect(.degrees(amount), anchor: anchor)
            .clipped()
    }
}

extension AnyTransition {
    static var pivot : AnyTransition {
        .modifier(active: CornerRotateModifier(amount: -90, anchor:
                                                .topLeading),
                  identity: CornerRotateModifier(amount: 0, anchor: .topLeading))
    }
}

struct ContentView: View {
    //@State private var animationAmount = 0.0
    //@State private var enabled = false
    //@State private var dragAmount = CGSize.zero
//    let letters = Array("Hello SwiftUI")
//    @State private var enabled = false
//    @State private var dragAmount = CGSize.zero
    @State private var isShowingRed = false
    var body: some View {
        //print (animationAmount)
//        Button("Tap me"){
////self.animationAmount += 1
//        }
//        .padding()
//        .background(Color.red)
//        .foregroundColor(.white)
//        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
//        .overlay(
//            Circle()
//                .stroke(Color.red)
//                .scaleEffect(animationAmount)
//                .opacity(Double(2 - animationAmount))
//                .animation(Animation.easeInOut(duration: 1)
//                            .repeatForever(autoreverses: false))
//        )
//        //.scaleEffect(animationAmount)
//        //.blur(radius: (animationAmount - 1) * 3)
//        .onAppear() {
//            self.animationAmount = 2
//        }
//       return VStack {
//            Stepper("Scale amount", value:
//                        $animationAmount.animation(
//                            Animation.easeInOut(duration: 1)
//                                .repeatCount(3, autoreverses: true)
//                        ), in: 1...10)
//            Spacer()
//            Button("Tap me"){
//                self.animationAmount += 1
//            }
//            .padding(40)
//            .background(Color.red)
//            .foregroundColor(.white)
//            .clipShape(Circle())
//            .scaleEffect(animationAmount)
//        }
//        Button("Tap me"){
//            withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
//                self.animationAmount += 360
//            }
//        }
//        .padding(50)
//        .background(Color.red)
//        .foregroundColor(.white)
//        .clipShape(Circle())
//        .rotation3DEffect(.degrees(animationAmount), axis: (x: 0, y: 1, z: 0))
//        Button("Tap me "){
//            //do nothing
//            self.enabled.toggle()
//        }
//        .frame(width: 200, height: 200)
//        .background(enabled ? Color.blue : Color.red)
//        .animation(nil)
//        .foregroundColor(.white)
//        .clipShape(RoundedRectangle(cornerRadius: enabled ? 60 : 0))
//        .animation(.interpolatingSpring(stiffness: 10, damping: 1))
//        LinearGradient(gradient: Gradient(colors: [.yellow,
//                                                   .red]), startPoint: .topLeading, endPoint:
//                                                    .bottomTrailing)
//            .frame(width: 300, height: 200)
//            .clipShape(RoundedRectangle(cornerRadius: 10))
//            .offset(dragAmount)
//            .gesture(
//            DragGesture()
//                .onChanged { self.dragAmount = $0.translation }
//                .onEnded { _ in
//                    withAnimation(.spring()){
//                    self.dragAmount = .zero
//                        }
//                    }
//            )
//            //.animation(.spring())
        
//        HStack(spacing: 0){
//            ForEach(0..<letters.count){ num in
//                Text(String(self.letters[num]))
//                    .padding(5)
//                    .font(.title)
//                    .background(self.enabled ? Color.blue : Color.red)
//                    .offset(self.dragAmount)
//                    .animation(Animation.default.delay(Double(num)/20))
//            }
//        }.gesture(
//            DragGesture()
//                .onChanged{ self.dragAmount = $0.translation}
//                .onEnded { _ in
//                    self.dragAmount = .zero
//                    self.enabled.toggle()
//                }
//        )
        VStack {
            Button("tap me"){
                withAnimation{
                    self.isShowingRed.toggle()
                }
            }
            if isShowingRed {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 200, height: 200)
                    .transition(.pivot)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
