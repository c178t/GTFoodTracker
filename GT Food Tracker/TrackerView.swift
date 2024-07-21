//
//  ContentView.swift
//  GT Food Tracker
//
//  Created by Cian Thomas on 7/1/24.
//

import SwiftUI

struct DayButton: View {
    var dayNameShort: String
    @Binding var is_selected: Bool
    
    var body: some View {
        
        Button(action: {
            is_selected = !is_selected
            
            
        },
               label: {
            Text(dayNameShort)
                .foregroundStyle(is_selected ? Color.white:Color.primary)
        }
               
        )
        .padding()
        .background(is_selected ? Color("day_color_selected"):Color("day_color_unselected"))
        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    }
}








struct TrackerView: View {
    @State var balanceString: String = ""
    @State var balance: Int = 0
    @State var frequency: Int = 1
    @State var days: Int = 0
    @State var endDate: String = ""
    @State var preDate: Date = Date()
    
    @State var excludedDays: [Int] = []
    
    
    @State var sundayBool: Bool = false
    @State var mondayBool: Bool = false
    @State var tuesdayBool: Bool = false
    @State var wednesdayBool: Bool = false
    @State var thursdayBool: Bool = false
    @State var fridayBool: Bool = false
    @State var saturdayBool: Bool = false
    
    
    
    
    
    @State var editBalance: Bool = false
    @State var negativeBalance: Bool = false
    @State var zeroSelectedDays: Bool = false
    @State var pressCalculateOnce:Bool = false
    @State var maxMealPlanBalance:Bool = false
    @State var enterIsPressed = false
    @FocusState private var balanceIsFocused: Bool
    
    
    let frequencyAmount = [1, 2, 3]
    

    
    var body: some View {
        
        
        
            VStack {
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                HStack {
                    
                    TextField("0", value: $balance, format: .number)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 100, design: .rounded))
                        .fontWeight(.black)
                        .padding(.top, 30)
                        .padding(.bottom, 200)
                        .focused($balanceIsFocused)
                        .frame(width: 250, height: 100)
                        
                    
                    if balanceIsFocused {
                        Button {
                           
                            
                            balanceIsFocused = false
                            
                            if balance > 200 {
                                balance = 200
                                maxMealPlanBalance = true
                            }
                            
                        } label: {
                            Image(systemName: "return")
                                .font(.title)
                                .imageScale(.large)
                                
                        }
                        .padding(.bottom, 150)
                        
                    }

                }
                .alert("Maximum meal swipes that can be added is 200", isPresented: $maxMealPlanBalance) {
                    Button("Ok"){}
                }
                
                
                Text("Pick the days you eat on campus")
                HStack {
                    Spacer()
                    DayButton(dayNameShort: "U", is_selected: $sundayBool)
                    Spacer()
                    DayButton(dayNameShort: "M", is_selected: $mondayBool)
                    Spacer()
                    DayButton(dayNameShort: "T", is_selected: $tuesdayBool)
                    Spacer()
                    DayButton(dayNameShort: "W", is_selected: $wednesdayBool)
                    Spacer()
                    DayButton(dayNameShort: "R", is_selected: $thursdayBool)
                    Spacer()
                    DayButton(dayNameShort: "F", is_selected: $fridayBool)
                    Spacer()
                    DayButton(dayNameShort: "S", is_selected: $saturdayBool)
                    Spacer()
                    
                    
                }.padding(.bottom, 10.0)
                
                
                Section("How many times a day?") {
                    Picker("Frequency", selection: $frequency) {
                        ForEach(frequencyAmount, id: \.self) {
                            Text("\($0)x")
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .fontDesign(.default)
                
                
                Button(action: {

                    excludedDays = []
                    if !sundayBool {excludedDays.append(1) }
                    if !mondayBool {excludedDays.append(2) }
                    if !tuesdayBool {excludedDays.append(3) }
                    if !wednesdayBool {excludedDays.append(4) }
                    if !thursdayBool {excludedDays.append(5) }
                    if !fridayBool {excludedDays.append(6) }
                    if !saturdayBool {excludedDays.append(7) }
                    
                    if (excludedDays.count == 7) {
                        zeroSelectedDays = true
                    } else {
                        pressCalculateOnce = true
                        preDate = calculateDate(excludedDays:                     excludedDays, balanceLeft: balance) ?? preDate
                        
                        endDate = formattedDate(from: preDate)
                        
                    }
                    
                    if (balance > 0 && !zeroSelectedDays) {
                        balance -= 1
                    } else if (balance <= 0 && !zeroSelectedDays){
                        negativeBalance = true
                    }
                    
                }, label: {
                    Text("Use One Now")
                        .font(.title2)
                        .foregroundColor(Color.white)
                        .frame(width: 200, height: 50)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.top)
                    
                }).alert("Balance cannot be less than 0", isPresented: $negativeBalance) {
                    Button("Ok") {}
                }
                
                Spacer()
                
                Button("Calculate") {
                    
                    excludedDays = []
                    if !sundayBool {excludedDays.append(1) }
                    if !mondayBool {excludedDays.append(2) }
                    if !tuesdayBool {excludedDays.append(3) }
                    if !wednesdayBool {excludedDays.append(4) }
                    if !thursdayBool {excludedDays.append(5) }
                    if !fridayBool {excludedDays.append(6) }
                    if !saturdayBool {excludedDays.append(7) }
                    
                    if (excludedDays.count == 7) {
                        zeroSelectedDays = true
                    } else {
                        pressCalculateOnce = true
                        preDate = calculateDate(excludedDays:                     excludedDays, balanceLeft: balance) ?? preDate
                        
                        endDate = formattedDate(from: preDate)
                        
                    }
                    
                }
                .buttonStyle(BorderedButtonStyle())
                .font(.title)
                .alert("You have to select at least one day", isPresented: $zeroSelectedDays) {
                    Button("Ok"){}
                }
                
                
                Spacer()
                Spacer()
                
                Text("\(endDate)")
                    .font(.title)
                    .fontWeight(.regular)
                Text(pressCalculateOnce ? "Estimated date excluding today" : "")
                Spacer()
                Spacer()
                Spacer()
                
                
                
            }
            .toolbar {

            }
            
        
        
    }
    
    func calculateDate(excludedDays: [Int], balanceLeft: Int) -> Date? {
        var date = Date()
        var remainingBalance = balanceLeft
        
        let calendar = Calendar.current
        
        while remainingBalance > 0 {
            
            
            date = calendar.date(byAdding: .day, value: 1, to: date) ?? date
            
            let day = calendar.component(.weekday, from: date)
            
            if !excludedDays.contains(day) {
                remainingBalance -= frequency
            }
        }
        
        return date
        
    }
    
    func formattedDate(from date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .full
        return dateFormatter.string(from: date)
    }
    
    
    
}

#Preview {
    TrackerView()
}
