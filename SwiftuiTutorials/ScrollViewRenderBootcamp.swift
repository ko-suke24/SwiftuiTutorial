//
//  ScrollViewRenderBootcamp.swift
//  SwiftuiTutorials
//
//  Created by RURU.jr on 2023/04/18.
//

import SwiftUI

struct ScrollViewRenderBootcamp: View {

    @State var scrollToIndex: Int = 0
    @State var textFieldText: String = ""

    var body: some View {
        VStack {
            TextField("Enter a # here...", text: $textFieldText)
                .frame(height: 55)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)

            Button("SCROLL NOW") {
//                スクロールしながら指定idに飛ぶアニメーション
                withAnimation(.spring()) {
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                }
            }


            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0..<50) { index in
                        Text("This is item #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(Color.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
//                        idは単にindex
                            .id(index)
                    }
//                    入力された数字を受け取ってその位置に遷移する
                    .onChange(of: scrollToIndex, perform: { value in
                        withAnimation(.spring()) {
                            proxy.scrollTo(value, anchor: .top)
                        }
                    })
                }
            }
        }
    }
}

struct ScrollViewRenderBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewRenderBootcamp()
    }
}
