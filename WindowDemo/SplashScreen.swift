/// Copyright (c) 2019 Razeware LLC
/// 
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
/// 
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
/// 
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
/// 
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI


struct SplashScreen: View {
  @State private var window: NSWindow?
    
  static var shouldAnimate = true
  let demoGreen = Color.green
  let uLineWidth: CGFloat = 5
  let uZoomFactor: CGFloat = 1
  let lineWidth:  CGFloat = 4
  let lineHeight: CGFloat = 28
  let uSquareLength: CGFloat = 12
  
  @State var percent = 0.0
  @State var uScale: CGFloat = 0.8
  @State var squareColor = Color.white
  @State var squareScale: CGFloat = 1
  @State var lineScale: CGFloat = 1
  @State var textAlpha = 0.0
  @State var textScale: CGFloat = 1
  @State var coverCircleScale: CGFloat = 1
  @State var coverCircleAlpha = 0.0
    
  @State private var serverChecked = false

  var body: some View {
    ZStack {
     Color.green.edgesIgnoringSafeArea(.top)
      
      Circle()
        .fill(demoGreen)
        .frame(width: 1, height: 1,
               alignment: .center)
        .scaleEffect(coverCircleScale)
        .opacity(coverCircleAlpha)
        
        
      
      Text("Dem       ")
      
        .font(.system(size: 95))
        .foregroundColor(.white)
        .opacity(textAlpha)
        .offset(x: -10, y: 5)
        .shadow(color: Color.gray, radius: 2.0, x: 2, y: 2)
      
      
      DemoO(percent: percent)
        .stroke(Color.white, lineWidth: uLineWidth)
        .rotationEffect(.degrees(-90))
        .aspectRatio(1, contentMode: .fit)
        .padding(5)
        .shadow(color: Color.gray, radius: 1.0, x: 1, y:1)
        .onAppear() {
          self.handleAnimations()
      }
      .scaleEffect(uScale * uZoomFactor)
      .frame(width:35, height: 35,alignment: .center)
      .offset(x: 100, y: 0)
  
    }
    .background(demoGreen)
    .edgesIgnoringSafeArea(.all)
    .frame(width: 600, height: 600, alignment: .center)
    .onAppear() {
               
        servercheck()
       
    } // using WindowsAccessor from extension to get window and set it to splashScreen window
    .background(WindowAccessor(window: $window))
 
  }
    
}

extension SplashScreen {
  var uAnimationDuration: Double { return 1.4 }
  var uAnimationDelay: Double { return  0.2 }
  var uExitAnimationDuration: Double { return 0.5 }
  var finalAnimationDuration: Double { return 0.4 }
  var minAnimationInterval: Double { return 0.1 }
  var fadeAnimationDuration: Double { return 0.4 }
  
  func handleAnimations() {
    
    runAnimationPart1()
    runAnimationPart2()
    runAnimationPart3()
    if SplashScreen.shouldAnimate {
     restartAnimation()
    }
  }
  
  func runAnimationPart1() {
     
    withAnimation(.easeIn(duration: uAnimationDuration)) {
      percent = 1
      uScale = 5
      lineScale = 1
    }
    
    withAnimation(Animation.easeIn(duration: uAnimationDuration).delay(0.6)) {
      textAlpha = 1.0
    }
    
    let deadline: DispatchTime = .now() + uAnimationDuration + uAnimationDelay
    DispatchQueue.main.asyncAfter(deadline: deadline) {
      withAnimation(.easeOut(duration: self.uExitAnimationDuration)) {
        self.uScale = 0
        self.lineScale = 0
      }
      withAnimation(.easeOut(duration: self.minAnimationInterval)) {
        self.squareScale = 0
      }
      
      withAnimation(Animation.spring()) {
        self.textScale = self.uZoomFactor
      }
    }
  }
  
  func runAnimationPart2() {
    let deadline: DispatchTime = .now() + uAnimationDuration + uAnimationDelay + minAnimationInterval
    DispatchQueue.main.asyncAfter(deadline: deadline) {
      self.squareColor = Color.white
      self.squareScale = 1
      withAnimation(.easeOut(duration: self.fadeAnimationDuration)) {
        self.coverCircleAlpha = 1
        self.coverCircleScale = 1000
      }
    }
  }
  
  func runAnimationPart3() {
    DispatchQueue.main.asyncAfter(deadline: .now() + 1*uAnimationDuration) {
      withAnimation(.easeIn(duration: self.finalAnimationDuration)) {
        self.textAlpha = 0
        self.squareColor = self.demoGreen
      }
    }
  }
  
  func restartAnimation() {
    let deadline: DispatchTime = .now() + 2*uAnimationDuration + finalAnimationDuration
    DispatchQueue.main.asyncAfter(deadline: deadline) {
      self.percent = 0
      self.textScale = 1
      self.coverCircleAlpha = 0
      self.coverCircleScale = 1
      self.handleAnimations()
    }
  }
  
   
  func servercheck(){
     // delay befor seting th contentview as window root " replacing view "
      DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
          if nil != window {
              window!.contentView = NSHostingView(rootView: ContentView())
          }
      }
    }

}

struct DemoO: Shape {
  var percent: Double
  
  func path(in rect: CGRect) -> Path {
    let end = percent * 360
    var p = Path()
    
    p.addArc(center: CGPoint(x: rect.size.width/2, y: rect.size.width/2),
             radius: rect.size.width/2,
             startAngle: Angle(degrees: 0),
             endAngle: Angle(degrees: end),
             clockwise: false)
    
    return p
  }
  
  var animatableData: Double {
    get { return percent }
    set { percent = newValue }
  }
}

#if DEBUG
struct SplashScreen_Previews : PreviewProvider {
  static var previews: some View {
    SplashScreen()
  }
}
#endif
