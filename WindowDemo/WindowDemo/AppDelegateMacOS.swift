//
//  AppDelegateMacOS.swift
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
import Cocoa
import SwiftUI

class AppDelegateMacOS: NSObject, NSApplicationDelegate, NSWindowDelegate {
    private var aboutBoxWindowController: NSWindowController?
   
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {


    }
    
   // replacint about in menu with your own custom view
   func showAboutWnd() {
        
           if aboutBoxWindowController == nil {
               let styleMask: NSWindow.StyleMask = [.closable, .titled]
               let window = NSWindow()
               window.styleMask = styleMask
               window.title = "About \(Bundle.main.appName)"
               window.contentView = NSHostingView(rootView: MacOSAboutView())
               window.center()
               aboutBoxWindowController = NSWindowController(window: window)
           }
           
           aboutBoxWindowController?.showWindow(aboutBoxWindowController?.window)
    }

    func applicationWillFinishLaunching(_ notification: Notification) {
 
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
      
    }
    func applicationDidHide(_ notification: Notification) {
     
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
    
        return true
    }
   
    // Do we have a minimized window? If so, pull it up
    func applicationDidBecomeActive(_ notification: Notification) {
           if let window = NSApp.windows.first {
               window.deminiaturize(nil)
           }
    }
       
       // Did we minimize? If so, deactivate by activating Finder.app
    func applicationDidChangeOcclusionState(_ notification: Notification) {
           if let window = NSApp.windows.first,
              window.isMiniaturized {
               NSWorkspace.shared.runningApplications.first(where: { $0.activationPolicy == .regular })?.activate(options: .activateAllWindows)
           }
    }
}

