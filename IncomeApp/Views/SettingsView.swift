//
//  SettingsView.swift
//  IncomeApp
//
//  Created by MAC on 13/04/2025.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("orderDescending") private var orderDescending = false
    @AppStorage("currency") private var currency: Currency = .usd
    @AppStorage("filterMinimum") private var filterMinimum: Double = 0.0
 
    var numberFormatter: NumberFormatter{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }
    
    var body: some View {
        NavigationStack {
            List{
                Toggle("Order \(orderDescending ? "Latest" : "Earliest")", isOn: $orderDescending)
                HStack{
                    Picker("Currency", selection: $currency) {
                        ForEach(Currency.allCases,id: \.self){currency in
                            Text(currency.title)
                        }
                    }
                }
                HStack{
                    Text("Filter Minimum")
                    TextField("", value: $filterMinimum, formatter: numberFormatter)
                        .multilineTextAlignment(.trailing)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
