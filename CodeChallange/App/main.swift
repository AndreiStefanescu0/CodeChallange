////
////  main.swift
////  CodeChallange
////
////  Created by Andrei Stefanescu on 30.06.2022.
////
//
import UIKit

let appDelegateClass: AnyClass = NSClassFromString("MockAppDelegate") ?? AppDelegate.self
UIApplicationMain(CommandLine.argc,
                  CommandLine.unsafeArgv,
                  nil,
                  NSStringFromClass(appDelegateClass)
)
