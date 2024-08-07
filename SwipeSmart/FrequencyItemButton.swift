//
//  FrequencyItemButton.swift
//  GT Food Tracker
//
//  Created by Cian Thomas on 7/7/24.
//

import SwiftUI

struct FrequencyItemButton: View {
    var item: FrequencyItem
    @State var is_selected: Bool = false
    
    var body: some View {
        
        
        
        
        Button(action: {
            is_selected = !is_selected
                print("frequency of \(item.frequency) is \(is_selected)")
            
        }, label: {
            Text("\(item.frequency)x")
                .foregroundStyle(is_selected ? Color.white:Color.black)
        })
        .padding()
        .background(is_selected ? Color.dayColorSelected:Color.dayColorUnselected)
        .cornerRadius(5)
        
    }
    
    
    func isSelected() -> Bool {
        return is_selected
    }
    
    func off() {
        is_selected = false
    }
}

#Preview {
    FrequencyItemButton(item: FrequencyItem(frequency: 1))
}
