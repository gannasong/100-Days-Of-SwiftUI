//
//  ContentView.swift
//  UnitConversion
//
//  Created by SUNG HAO LIN on 2022/7/29.
//

import SwiftUI

/*
 TODO: write a unit conversion app
 - Temperature conversion
 - Length conversion
    - [] a segmented [kilometers, feet, yard, iles] for input
    - [] a second segmented [kilometers, feet, yard, iles] for output
    - [] a text field user can input number
    - [] a text view showing result of the conversion
 - Time conversion
 - Volume conversion
 
 */
struct ContentView: View {
    enum Unit: String, CaseIterable {
        case seconds
        case minute
        case hour
        case day
    }
    
    @State var inputValue: Double = 1
    @State var inputUnit: Unit = .minute
    @State var outputUnit: Unit = .seconds
    @FocusState private var isFocused: Bool
    
    var conversionResult: String {
        let input: Double
        switch inputUnit {
        case .seconds:
            input = inputValue
        case .minute:
            input = inputValue * 60
        case .hour:
            input = inputValue * 60 * 60
        case .day:
            input = inputValue * 60 * 60 * 24
        }
        
        var conversionValue: Double
        switch outputUnit {
        case .seconds:
            conversionValue = 1
        case .minute:
            conversionValue = 60
        case .hour:
            conversionValue = 60 * 60
        case .day:
            conversionValue = 60 * 60 * 24
        }

        return (input / conversionValue).formatted()
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("time value", value: $inputValue, format: .number)
                        .keyboardType(.numberPad)
                        .focused($isFocused)
                    
                    Picker("Input unit", selection: $inputUnit) {
                        ForEach(Unit.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                                .tag(unit)
                        }
                        .onTapGesture {
                            isFocused = false
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                } header: {
                    Text("Type the value to be converted in the textfield")
                }
                .textCase(nil)
                
                Section {
                    Picker("Input unit", selection: $outputUnit) {
                        ForEach(Unit.allCases, id: \.self) { unit in
                            Text(unit.rawValue)
                                .tag(unit)
                        }
                        .onTapGesture {
                            isFocused = false
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                } header: {
                    Text("Select the unit to be converted")
                }
                .textCase(nil)
                
                Section {
                    Text("\(conversionResult) \(outputUnit.rawValue)")
                } header: {
                    Text("Converted Reslult")
                }
                .textCase(nil)
            }
            .navigationTitle("Time Unit Conversion")
            .onChange(of: isFocused) { newValue in
                if newValue {
                    inputValue = 0
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
