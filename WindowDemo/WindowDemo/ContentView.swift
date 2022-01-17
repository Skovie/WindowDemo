//
//  ContentView.swift
//  WindowDemo
//
//  Created by Rene Skov on 17/01/2022.

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

struct ContentView: View {
    @State private var window: NSWindow?
    
    var body: some View {
        ZStack{
            VStack {
                Spacer()
               Text("WindowDemo,  the 2 buttons below shows how to open view \n in a new widnow or 'replacce' the view  \n in this window.")
                  .lineLimit(5)
                  .padding()
               Spacer()
                HStack {
                Spacer()
                Button(action: {
                   // open a new window using func  from extension
                    MacOSAboutView().openInWindow(title: "", sender: self)
                   
                }, label: {
                   
                    VStack {
                        Text("In window")
                        Image(systemName:"square")
                          .resizable()
                          .renderingMode(.template)
                          .foregroundColor(.green)
                          .aspectRatio(1, contentMode: .fit)
                     }.frame(width: 130, height: 130)

                }).buttonStyle(BorderlessButtonStyle())
                Spacer()
                Button(action: {
                    // replacing view in window  -  from extension
                    if nil != window {
                        window!.contentView = NSHostingView(rootView: MacOSAboutView())
                    }
                       
                }, label: {
                       
                        VStack {
                            Text("New window")
                            Image(systemName:"square.on.square")
                              .resizable()
                              .renderingMode(.template)
                              .foregroundColor(.green)
                              .aspectRatio(1, contentMode: .fit)
                         }.frame(width: 130, height: 130)

                }).buttonStyle(BorderlessButtonStyle())
                Spacer()
                }
                Spacer()
            }
            
        }.frame(width: 600, height: 600, alignment: .center)
        
        // using WindowsAccessor from extension to get window and set it to ContentView window
        .background(WindowAccessor(window: $window))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
