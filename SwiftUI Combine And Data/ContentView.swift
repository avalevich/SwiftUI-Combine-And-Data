//
//  ContentView.swift
//  SwiftUI Combine And Data
//
//  Created by Alyaxey Valevich on 15/03/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var contentOffset = CGFloat(0)
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                TrackableScrollView(offsetChanged: { offset in
                    contentOffset = offset.y
                }, content: {
                    content
                })
                Color.clear.background(.regularMaterial)
                    .opacity(contentOffset < -16 ? 1 : 0)
                    .animation(.easeIn, value: contentOffset < -16 ? 1: 0)
                    .ignoresSafeArea()
                    .frame(height: 0)
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .background(AccountBackground())
            .toolbar(.hidden)
        }
    }
    var content: some View {
        VStack {
            VStack {
                NavigationLink {
                    FAQView()
                } label: {
                    MenuRow()
                }
                divider
                NavigationLink {
                    PackagesView()
                } label: {
                    MenuRow(title: "SwiftUI Packages", leftIcon: "square.stack.3d.up.fill")
                }
                divider
                Link(destination: URL(string: "https://www.apple.com")!, label: {
                    MenuRow(title: "YouTube Channel", leftIcon: "play.rectangle.fill", rightIcon: "link")
                })
            }
            .padding(16)
            .background(Color("Background 1"))
            .background(MaterialView(blurEffect: .systemUltraThinMaterialDark))
            .overlay(RoundedRectangle(cornerRadius: 20, style: .continuous).stroke(Color.white, lineWidth: 1).blendMode(.overlay))
            .mask(RoundedRectangle(cornerRadius: 20, style: .continuous))
            .padding(.top, 20)
            
            Text("Version 1.0")
                .foregroundColor(.white.opacity(0.7))
                .padding(.top, 20)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
                .font(.footnote)
        }
        .foregroundColor(.white)
        .padding(.top, 20)
        .padding(.horizontal, 20)
        .padding(.bottom, 10)
    }
    
    var divider: some View {
        Divider()
            .background(Color.white.blendMode(.overlay))
    }
}

struct MaterialView: UIViewRepresentable {
    let material: UIBlurEffect.Style
    let vibrancyStyle: UIVibrancyEffectStyle?
    
    init(blurEffect: UIBlurEffect.Style, vibrancyStyle: UIVibrancyEffectStyle? = nil) {
        self.material = blurEffect
        self.vibrancyStyle = vibrancyStyle
    }

    func makeUIView(context: Context) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: material)
        let visualView = UIVisualEffectView(effect: blurEffect)
        if let vibrancyStyle = vibrancyStyle {
            visualView.effect = UIVibrancyEffect(blurEffect: blurEffect, style: vibrancyStyle)
        } else {
            visualView.effect = blurEffect
        }
        return visualView
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {
        let blurEffect = UIBlurEffect(style: material)
        if let vibrancyStyle = vibrancyStyle {
            uiView.effect = UIVibrancyEffect(blurEffect: blurEffect, style: vibrancyStyle)
        } else {
            uiView.effect = blurEffect
        }
    }
}

#Preview {
    ContentView()
}
