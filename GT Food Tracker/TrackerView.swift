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
    @State private var balanceString: String = ""
    @State private var balance: Int = 0
    @State private var frequency: Int = 1
    @State private var days: Int = 0
    @State private var endDate: String = ""
    @State private var preDate: Date = Date()
    
    @State private var excludedDays: [Int] = []
    
    
    @State private var sundayBool: Bool = false
    @State private var mondayBool: Bool = false
    @State private var tuesdayBool: Bool = false
    @State private var wednesdayBool: Bool = false
    @State private var thursdayBool: Bool = false
    @State private var fridayBool: Bool = false
    @State private var saturdayBool: Bool = false
    
    
    
    
    
    @State private var editBalance: Bool = false
    @State private var negativeBalance: Bool = false
    @State private var zeroSelectedDays: Bool = false
    @State private var pressCalculateOnce:Bool = false
    @State private var maxMealPlanBalance:Bool = false
    @State private var enterIsPressed = false
    @State private var helpPresented = false
    
    @FocusState private var balanceIsFocused: Bool
    
    
    let frequencyAmount = [1, 2, 3]
    

    
    var body: some View {
        
        
            NavigationView {
                
                ZStack {
                    
                    RadialGradient(stops: [
                        
                        .init(color: Color(red: 179/255, green: 163/255, blue: 105/255), location: 0.4),
                        .init(color: Color(red: 0/255, green: 48/255, blue: 87/255), location: 0.6)
                        
                    ],center: .top, startRadius: 200, endRadius: 700)
                        .ignoresSafeArea()
                    
                    VStack {
                        
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
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
                                .shadow(radius: 10, x: 0, y: 10)
                            
                            
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
                        
                        VStack {
                            
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
                            
//                            Text("\(endDate)")
//                                .font(.title)
//                                .fontWeight(.regular)
//                            Text(pressCalculateOnce ? "Estimated date excluding today" : "")
                            
                        }
                        .frame(maxWidth: .infinity, maxHeight: 400)
                        .padding(10)
                        .background(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 40))
                        
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()

                        
                        Text("\(endDate)")
                            .font(.system(size: 27))
                            .fontWeight(.regular)
                            .foregroundStyle(.white)
                            .bold()
                        Text(pressCalculateOnce ? "Estimated date excluding today" : "")
                            .foregroundStyle(.white)
                        
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        Spacer()
//                        
                        
                    }
                    .toolbar {
                        ToolbarItemGroup(placement: .topBarTrailing) {
                            
                            Button {
                                print("help presented")
                                
                                helpPresented = true
                            } label: {
                                Image(systemName: "questionmark.circle")
                            }
                            .sheet(isPresented: $helpPresented, content: {
                                
                                VStack {
                                    HStack {
                                        Spacer()
                                        Button("Return") {
                                            helpPresented = false
                                        }
                                        .padding()
                                        .buttonStyle(BorderedButtonStyle())
                                    }
                                    
                                    
                                    Text("Welcome to GT Food Tracker!")
                                        .font(.title)
                                        .bold()
                                    Spacer()
                                    
                                    Text("This app allows you to accurately calculate which day your meal plan will end if you are using swipes. If your on the unlimited plan, feel free to uninstall :) ")
                                        .padding()
                                    Spacer()
                                    
                                    Text("Otherwise, click on the big number you see at the top of the main screen to edit the total swipes you have currently. The maximum input amount is 200, as GT only allows for a maximum of 200 swipes. Next, select from the row of buttons which indicate which days you will be dining on campus. Next select how many times a day you eat (Don't be shy, I won't judge ;)")
                                        .padding()
                                    Spacer()
                                    
                                    Text("The last step is to click the calculate button to predict the day your mealplan will end with the previous conditions applied. This estimate does not include whether you eat or ate in the current day. If you already ate or want to reflect some change to your swipe balance, just click the big Use One Now button to use up a swipe and update the estimate. The estimate will always exclude the current day.  ")
                                        .padding()
                                    
                                    
                                    
                                    
                                    
                                }
                            })
                            
                            
                            
                        }
                    }

                    
                }
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
