//
//  ContentView.swift
//  SwiftuiTutorials
//
//  Created by RURU.jr on 2023/04/17.
//

import SwiftUI

struct ContentView: View {

    @State var isComplete: Bool = false
    
    var body: some View {
        Text(isComplete ? "ComPLETED" : "NOT COMPLETE")
            .padding()
            .padding(.horizontal)
            .background(isComplete ? Color.green : Color.gray)
            .cornerRadius(10)
            .onTapGesture {
                isComplete.toggle()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
