//
//  ContentView.swift
//  thirdTask
//
//  Created by  Pavel Nepogodin on 6.10.23.
//

import SwiftUI

private enum Constants {
    static let iconHeight: CGFloat = 50
    enum circleTransprency: Double {
        case start = 0.0
        case finish = 0.6
    }
}

struct ContentView: View {
    @State private var animationTriggered = true
    @State private var transparency = Constants.circleTransprency.start
    @State private var scale = 1.0
    
    var body: some View {
        Button(action: {
            animationTriggered.toggle()
            transparency = Constants.circleTransprency.finish
            scale = 0.5
            withAnimation(.easeOut, {
                transparency = Constants.circleTransprency.start
                scale = 1
            })
        }) {
            ZStack {
                Circle()
                    .frame(width: 150)
                    .opacity(transparency.rawValue)
                    .foregroundColor(.gray)
                    .scaleEffect(scale)
                    .animation(
                        .interpolatingSpring(
                            stiffness: 100,
                            damping: 15
                        ),
                        value: scale
                    )
                NextLabelView(animationTriggered: $animationTriggered)
            }
        }
    }
}

struct NextLabelView: View {
    @Binding var animationTriggered: Bool
    
    private var nextImage: some View {
        Image(systemName: "play.fill")
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
    
    var body: some View {
        HStack(spacing: 0) {
            nextImage
                .opacity(animationTriggered ? 1 : 0)
                .scaleEffect(animationTriggered ? 1 : 0, anchor: .trailing)
                .frame(
                    height: animationTriggered ? Constants.iconHeight : .zero
                )
            
            nextImage
                .frame(height: Constants.iconHeight)
            
            nextImage
                .opacity(animationTriggered ? 0 : 1)
                .scaleEffect(
                    animationTriggered ? 0 : 1,
                    anchor: .trailing
                )
                .frame(
                    height: animationTriggered ? .zero : Constants.iconHeight
                )
            
        }.animation(!animationTriggered ?
            .none : .interpolatingSpring(
                stiffness: 150,
                damping: 15
            ), value: animationTriggered)
        .onChange(of: animationTriggered) { newValue in
            if !newValue {
                animationTriggered = true
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
