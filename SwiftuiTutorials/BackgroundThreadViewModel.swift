//
//  BackgroundThreadViewModel.swift
//  SwiftuiTutorials
//
//  Created by RURU.jr on 2023/04/21.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {

    @Published var dataArray: [String] = []


    func fetchData() {

//        バックグランドで処理
        DispatchQueue.global(qos: .background).async {
            let newData = self.downloadData()

            print("CHECK 1: \(Thread.isMainThread)")
            print("CHECK 1: \(Thread.current)")

//            メインスレッドで処理
            DispatchQueue.main.async {
                self.dataArray = newData
                print("CHECK 2: \(Thread.isMainThread)")
                print("CHECK 2: \(Thread.current)")
            }

        }

    }

    private func downloadData() -> [String] {
        var data: [String] = []
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        return data
    }


}

struct BackgroundThreadBootcamp: View {

    @StateObject var vm = BackgroundThreadViewModel()

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }

                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundColor(.red)
                }
            }
        }
    }
}

struct BackgroundThreadBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundThreadBootcamp()
    }
}