//
//  WeakSelfBootcamp.swift
//  SwiftuiTutorials
//
//  Created by RURU.jr on 2023/04/21.
//

import SwiftUI

struct WeakSelfBootcamp: View {

    @AppStorage("count") var count: Int?

    init() {
        count = 0
    }

    var body: some View {
        NavigationView {
            NavigationLink("Navigate", destination: WeakSelfSecondScreen())
                .navigationTitle("Screen 1")
        }
        .overlay(
            Text("\(count ?? 0)")
                .font(.largeTitle)
                .padding()
                .background(Color.green.cornerRadius(10))
            , alignment: .topTrailing
        )
    }
}

struct WeakSelfSecondScreen: View {

    @StateObject var vm = WeakSelfSecondScreenViewModel()

    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font: UIFont(name: "Arial", size: 32)!]
    }

    var body: some View {
        VStack {
            Text("Second View")
                .font(.largeTitle)
                .foregroundColor(.red)

            if let data = vm.data {
                Text(data)
            }
        }
    }
}

class WeakSelfSecondScreenViewModel: ObservableObject {

    @Published var data: String? = nil

    init() {
        print("INITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount + 1, forKey: "count")
        getData()
    }

    deinit {
        print("DEINITIALIZE NOW")
        let currentCount = UserDefaults.standard.integer(forKey: "count")
        UserDefaults.standard.set(currentCount - 1, forKey: "count")
    }

    func getData() {

//        バックグラウンド処理に500秒かかるコード。 500秒経過するまでこのコードは生き続けるためweak selfを記述。

        DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "NEW DATA!!!!"
        }

    }

}

struct WeakSelfBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        WeakSelfBootcamp()
    }
}
