//
//  DayItemButton.swift
//  GT Food Tracker
//
//  Created by Cian Thomas on 7/3/24.
//
// NOT CURRENTLY USING

import SwiftUI

struct DayItemButton: View {
    var item: DayItem
    @State var is_selected: Bool = false
    
    
    
    var body: some View {
        
        Button(action: {
            is_selected = !is_selected
            
            
            if is_selected {
                print("\(item.day_short) is \(is_selected)")
            }
        },
               label: {
            Text(item.day_short)
                .foregroundStyle(is_selected ? Color.white:Color.black)
        }
               
        )
        .padding()
        .background(is_selected ? Color("day_color_selected"):Color("day_color_unselected"))
        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    }
    
    func selected() -> Bool {
        if is_selected {
            return true
        }
        
        return false
    }
    
}

#Preview {
    DayItemButton(item: DayItem(day_short: "M"))
}
