//
//  ContentView.swift
//  BetterRest
//
//  Created by SUNG HAO LIN on 2022/8/5.
//

import SwiftUI
import CoreML

struct ContentView: View {
    @State private var wakeUp = defaultWakeTime
    @State private var sleepAmount = 8.0
    @State private var coffeeAmount = 1
    
    @State private var alertTitle = "Please input value..."
    @State private var alertMessage = "???"
    @State private var showingAlert = false
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                } header: {
                    Text("When do you want ot wake up?")
                        .font(.headline)
                        .textCase(nil)
                }

                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25)
                } header: {
                    Text("Desired amount of sleep")
                        .font(.headline)
                        .textCase(nil)
                }
                
                Section {
                    Picker("Daily coffee intake", selection: $coffeeAmount) {
                        ForEach(1..<21) { number in
                            Text("\(number) \(number == 1 ? "cup" : "cups")")
                        }
                        
                    }
                    .pickerStyle(.menu)
                }
            }
            .onChange(of: wakeUp, perform: { _ in calculateBedtime()})
            .onChange(of: sleepAmount, perform: { _ in calculateBedtime()})
            .onChange(of: coffeeAmount, perform: { _ in calculateBedtime()})
            .overlay(alignment: .center) {
                VStack {
                    Text(alertTitle)
                        .font(.largeTitle)
    
                    Text(alertMessage)
                        .font(.largeTitle)
                        .foregroundColor(.red)
                }
                .offset(y: 20)
            }
            .navigationTitle("BetterRest")
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try SleepCalculator(configuration: config)
            
            let components = Calendar.current.dateComponents([.hour, .minute], from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction = try model.prediction(wake: Double(hour + minute),
                                                  estimatedSleep: sleepAmount,
                                                  coffee: Double(coffeeAmount))
            
            let sleepTime = wakeUp - prediction.actualSleep
            
            alertTitle = "Your ideal bedtime is..."
            alertMessage = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime."
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
