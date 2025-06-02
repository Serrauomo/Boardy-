//
//  CanvasView.swift
//  Brainstorming
//
//  Created by Alessio Garzia Marotta Brusco on 15/11/24.
//

import SwiftUI
import PencilKit

struct CanvasView: UIViewRepresentable {
  
  @Binding var canvasView: PKCanvasView
  
  func makeUIView(context: Context) -> PKCanvasView {
    canvasView.drawingPolicy = .anyInput
    return canvasView
  }
  
  func updateUIView(_ uiView: PKCanvasView, context: Context) {
    // No updates needed for this implementation
  }
}

