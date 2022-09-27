//
//  PickerView.swift
//  JsonAPI
//
//  Created by N N on 27/09/2022.
//

import SwiftUI

struct PickerView: View {
    
    @State private var selectDisplay = 0
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("", selection: $selectDisplay) {
                    Text("Map").tag(0)
                    Text("List").tag(1)
                }
                .pickerStyle(.segmented)
                
                if selectDisplay == 0 {
                    ContentView()
                } else {
                    ListView()
                }
            }
            .navigationBarTitle(Text("Coworking places"), displayMode: .large)
                .scrollContentBackground(.hidden)
                .background(Color("Background"))
        }
    }

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        PickerView()
    }
}
