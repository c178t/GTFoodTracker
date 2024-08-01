//
//  ContentView.swift
//  GT Food Tracker
//
//  Created by Cian Thomas on 7/1/24.
//

import SwiftUI
import SwiftData

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
        .padding(14)
        .background(is_selected ? Color("day_color_selected"):Color("day_color_unselected"))
        .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
    }
}








struct TrackerView: View {
    @Environment(\.modelContext) var modelContext
    
    @State private var balance: Int? = 0
    @State private var frequency: Int = 1
    @State private var endDate: String = ""
    @State private var preDate: Date = Date()
    @State private var balancePadding = 30
    
    @State private var excludedDays: [Int] = []
    
    
    @State private var sundayBool: Bool = false
    @State private var mondayBool: Bool = false
    @State private var tuesdayBool: Bool = false
    @State private var wednesdayBool: Bool = false
    @State private var thursdayBool: Bool = false
    @State private var fridayBool: Bool = false
    @State private var saturdayBool: Bool = false
    
    
    
    
    // Only change after pressing something
    @State private var editBalance: Bool = false
    @State private var negativeBalance: Bool = false
    @State private var zeroSelectedDays: Bool = false
    @State private var pressCalculateOnce:Bool = false
    @State private var maxMealPlanBalance:Bool = false
    @State private var enterIsPressed = false
    @State private var helpPresented = false
    
    @FocusState private var balanceIsFocused: Bool
    
    
    let frequencyTypes = [1, 2, 3]
    let closedDays: [String] = ["11/23/24","11/24/24","11/25/24","12/15/24","12/16/24","12/17/24","12/18/24","12/19/24","12/20/24","12/21/24","12/22/24","12/23/24","12/24/24","12/25/24","12/26/24","12/27/24","12/28/24","12/29/24","12/30/24","12/31/24","1/1/25","1/2/25","1/3/25","1/4/25","3/17/25","3/18/25","3/19/25","3/20/25","3/21/25","3/22/25","3/23/25"] //update for this year!!!
    

    
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
                        
                        
                        VStack {
                            
                            
                            
                            TextField("0", value: $balance, format: .number)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .font(.system(size: 100, design: .rounded))
                                .fontWeight(.black)
                                .padding(.top, CGFloat(balancePadding))
                                .padding(.bottom, 200)
                                .focused($balanceIsFocused)
                                .frame(width: 250, height: 100)
                                .shadow(radius: 10, x: 0, y: 10)
                                .onTapGesture {
                                    balancePadding = 200
                                    
                                    if balance == 0 {
                                        balance = nil
                                    }
                                }
    
    
                            
                            if balance == 0 {
                                VStack {
                                    Image(systemName: "arrow.up")
                                        .font(.system(size: 40))
                                        .bold()
                                        .offset(y: -40)

                                    Text("Tap on balance to edit")
                                        .bold()
                                        .font(.title2)
                                }
                                .animation(.easeInOut(duration: 0.5), value: balance)
                                
                                    
                            }
                                                                                            
                            
                            if balanceIsFocused {
                                Button {
                                    balancePadding = 30
                                    
                                    balanceIsFocused = false
                                    
                                    if balance ?? 0 > 200 {
                                        balance = 200
                                        maxMealPlanBalance = true
                                    }
                                    
                                    if balance == nil {
                                        balance = 0
                                    }
                                    
                                    
                                    
                                } label: {
                                    
                                    Text("Save")
                                        .font(.title)
                                        
                                    
                                }
                                
                                
                            }
                            
                        }
                        .alert("Maximum meal swipes that can be added is 200", isPresented: $maxMealPlanBalance) {
                            Button("Ok"){}
                        }
    
                        
                        VStack {
                            
                            Text("Pick the days you eat on campus")
                            HStack {
                                Spacer()
                                DayButton(dayNameShort: "S", is_selected: $sundayBool)
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
                                    ForEach(frequencyTypes, id: \.self) {
                                        Text("\($0)x")
                                    }
                                }
                                .pickerStyle(.segmented)
                            }
                            .fontDesign(.default)
                            
                            Spacer()

                            Button("Calculate") {
                                
                                balancePadding = 30
                                balanceIsFocused = false
                                
                                if balance ?? 0 > 200 {
                                    balance = 200
                                    maxMealPlanBalance = true
                                }
                                                            
                                excludedDays = []
                                if !sundayBool {excludedDays.append(1) }
                                if !mondayBool {excludedDays.append(2) }
                                if !tuesdayBool {excludedDays.append(3) }
                                if !wednesdayBool {excludedDays.append(4) }
                                if !thursdayBool {excludedDays.append(5) }
                                if !fridayBool {excludedDays.append(6) }
                                if !saturdayBool {excludedDays.append(7) }
                                                            
                                if (excludedDays.count == 7) { //if no days selected
                                    zeroSelectedDays = true
                                } else {
                                    pressCalculateOnce = true
                                    preDate = calculateDate(excludedDays: excludedDays, balanceLeft: balance ?? 0) ?? preDate
                                                                
                                    endDate = formattedDate(from: preDate)
                                                                
                                }
                                                                    
                            }
                            .foregroundColor(.white)
                            .frame(width: 200, height: 50)
                            .background(.blue)
                            .cornerRadius(10)
                            .font(.title)
                            .alert("You have to select at least one day", isPresented: $zeroSelectedDays) {
                                Button("Ok"){}
                            }

                            Spacer()
                            
                            Text("Ate extra?")
                            
                            Button(action: {
                                
                                balancePadding = 30
                                balanceIsFocused = false
                                
                                if balance ?? 0 > 200 {
                                    balance = 200
                                    maxMealPlanBalance = true
                                }
                                
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
                                    preDate = calculateDate(excludedDays:                     excludedDays, balanceLeft: (balance ?? 0) - 1) ?? preDate
                                    
                                    endDate = formattedDate(from: preDate)
                                    
                                }
                                
                                if (balance ?? 0 > 0 && !zeroSelectedDays) {
                                    balance! -= 1
                                } else if (balance ?? 0 <= 0 && !zeroSelectedDays){
                                    negativeBalance = true
                                }
                                
                            }, label: {
                                Text("Subtract and recalculate")
                                    .font(.title2)
                                    
                                
                            }).alert("Balance cannot be less than 0", isPresented: $negativeBalance) {
                                Button("Ok") {}
                            }
                            .buttonStyle(BorderedButtonStyle())
                            
                            
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
                        Text(pressCalculateOnce ? "Estimated date including today" : "")
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
                    .animation(.bouncy, value: balance)
                    .toolbar {
                        
                        ToolbarItem(placement: .topBarLeading) {
                            if (pressCalculateOnce) {
                                Button("Reset") {
                                    balance = 0
                                    frequency = 1
                                    sundayBool = false
                                    mondayBool = false
                                    tuesdayBool = false
                                    wednesdayBool = false
                                    thursdayBool = false
                                    fridayBool = false
                                    saturdayBool = false
                                    pressCalculateOnce = false
                                    endDate = ""
                                    
                                }
                                .font(.title2)
            
                            }
                        }
                        
                        
                        
                        ToolbarItemGroup(placement: .topBarTrailing) {
                            
                            Button {
                                print("help presented")
                                
                                helpPresented = true
                            } label: {
                                Image(systemName: "questionmark.circle")
                                    .font(.title2)
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
                                    
                                    Text("The last step is to click the calculate button to predict the day your mealplan will end with the previous conditions applied. This estimate assumes you haven't ate today. If you already ate or want to reflect some change to your swipe balance, just click the Subtract and recalculate button to use up a swipe and update the estimate.  ")
                                        .padding()
                                    
                                    Spacer()
                                    
                                    
                                    
                                    
                                    
                                }
                            })
                            
                            
                            
                        }
                    }

                    
                } //ZStack

                
            } //NavigationView
        
        
    }
    
    func calculateDate(excludedDays: [Int], balanceLeft: Int) -> Date? {
        var date = Date()
        var remainingBalance = balanceLeft
        
        let calendar = Calendar.current
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short

        while remainingBalance - frequency > 0 {
            
            
            date = calendar.date(byAdding: .day, value: 1, to: date) ?? date
            
            //print(dateFormatter.string(from: date))
            
            //print(!closedDays.contains(dateFormatter.string(from: date)))
            
            let day = calendar.component(.weekday, from: date)
            
            if (!excludedDays.contains(day) && !closedDays.contains(dateFormatter.string(from: date))) {
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
