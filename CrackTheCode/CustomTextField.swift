//
//  ContentView.swift
//  CrackTheCode
//
//  Created by Ari on 19/03/22.
//

import SwiftUI
import UIKit

struct CustomTextField: UIViewRepresentable {
    class Coordinator: NSObject, UITextFieldDelegate {
        @Binding var text: String
        @Binding var nextResponder: Bool?
        @Binding var isResponder: Bool?
        @Binding var previousResponder: Bool?
        
        init(text: Binding<String>, nextResponder: Binding<Bool?>, isResponder: Binding<Bool?>, previousResponder: Binding<Bool?>) {
            _text = text
            _isResponder = isResponder
            _nextResponder = nextResponder
            _previousResponder = previousResponder
        }
        
        func textFieldDidChangeSelection(_ textField: UITextField) {
            text = textField.text ?? ""
            
            if textField.text == ""{
                DispatchQueue.main.async {
                    self.isResponder = false
                    self.nextResponder = false
                    if self.previousResponder != nil {
                        self.previousResponder = true
                    }
                }
            }
            
            if text.count >= 1 {
                DispatchQueue.main.async {
                    self.text = String(self.text.suffix(1))
                    self.isResponder = false
                    if self.nextResponder != nil {
                        self.nextResponder = true
                    }
                }
            }
        }
        
    }
    
    @Binding var text: String
    @Binding var nextResponder: Bool?
    @Binding var isResponder: Bool?
    @Binding var previousResponder: Bool?
    
    func makeUIView(context: UIViewRepresentableContext<CustomTextField>) -> UITextField {
        let textField = UITextField(frame: .zero)
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        textField.keyboardType = .numberPad
        textField.delegate = context.coordinator
        textField.borderStyle = .none
        textField.font = UIFont(name: "coiny-regular", size: 70)
        textField.textColor = .black
        textField.tintColor = .black
        textField.textAlignment = .center
        textField.placeholder = "0"
        textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        return textField
    }
    
    func makeCoordinator() -> CustomTextField.Coordinator {
        return Coordinator(text: $text, nextResponder: $nextResponder, isResponder: $isResponder, previousResponder: $previousResponder)
    }
    
    func updateUIView(_ uiView: UITextField, context _: UIViewRepresentableContext<CustomTextField>) {
        uiView.text = text
        if isResponder ?? false {
            uiView.becomeFirstResponder()
        }
    }
}

