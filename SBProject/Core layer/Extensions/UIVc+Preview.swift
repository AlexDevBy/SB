//
//  UIVc+Preview.swift
//  SBProject
//
//  Created by Alex Misko on 10.12.2022.
//

import SwiftUI

@available(iOS 13.0, *)
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {}
    }
    
    public var preview: some View {
        return Preview(viewController: self)
    }
    
}






@available(iOS 13.0, *)
extension UIView {
    private struct Preview: UIViewRepresentable {
        
        let view: UIView
        
        func makeUIView(context: Context) -> UIView {
            view
        }
        
        func updateUIView(_ uiView: UIView, context: Context) {}
    }
    
    public var preview: some View {
        return Preview(view: self)
    }
    
}
