//
//  PencilKitPreviewView.swift
//  Brainstorming
//
//  Created by Andrés Zamora on 19/11/24.
//

import SwiftUI
import PencilKit

struct PencilKitPreviewView: View {
  var drawingData: Data
  
  var drawing: PKDrawing? {
    try? PKDrawing(data: drawingData)
  }
  
  var body: some View {
    VStack {
      if let drawing = drawing {
        Image(uiImage: drawing.image(from: drawing.bounds, scale: 1.0))
          .resizable()
          .scaledToFit()
          .frame(width: 150, height: 150)
          .background(
            RoundedRectangle(cornerRadius: 8)
              .stroke(Color.gray.opacity(0.3), lineWidth: 2)
              .shadow(radius: 5)
          )
      } else {
        Color.clear
          .frame(width: 150, height: 150)
          .background(
            RoundedRectangle(cornerRadius: 8)
              .stroke(Color.gray.opacity(0.3), lineWidth: 2)
              .shadow(radius: 5)
          )
      }
    }
  }
}
