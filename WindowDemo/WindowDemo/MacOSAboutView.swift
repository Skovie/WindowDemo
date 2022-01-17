//
//  MacOSAboutView.swift
//  WindowDemo
//
//  Created by Rene Skov on 17/01/2022.
//

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

import Foundation
import SwiftUI

struct MacOSAboutView: View {
    var body: some View {
        VStack(spacing: 10) {
            Image(nsImage: NSImage(named: "fether")!)
                .resizable()
                .frame(width: 200, height: 200, alignment: .center)
                .cornerRadius(25)
            
            Text("\(Bundle.main.appName)")
                .font(.title)
               
            // link to your website - from extension file
            Link("\(MacOSAboutView.offSiteAdr.replacingOccurrences(of: "https://", with: ""))", destination: MacOSAboutView.offCiteUrl )
                .font(.subheadline)
            
            // app version - from extension file
            Text("Ver: \(Bundle.main.appVersionLong) (\(Bundle.main.appBuild)) ")
                .font(.subheadline)
             
        // the copyright info -  from project -> info -> Custom macOS Application Target Properties -> add string to copyright ( human-readble)
            
            Text(Bundle.main.copyright)
                .font(.subheadline)
                .multilineTextAlignment(.center)
        }
        .padding(20)
        .frame(minWidth: 600, minHeight: 600)
    }
}


#if DEBUG
struct MacOSAboutView_Previews: PreviewProvider {
    static var previews: some View {

        MacOSAboutView()
    }
}
#endif
