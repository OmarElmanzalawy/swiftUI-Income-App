//
//  AddTransactionView.swift
//  IncomeApp
//
//  Created by MAC on 06/04/2025.
//

import SwiftUI

struct AddTransactionView: View {
    
    @State private var amount = 0.0
    @State private var selectedTransactinType: TransactionType = .expense
    @State private var title = ""
    
    var numberFormatter: NumberFormatter{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter
    }
    
    var body: some View {
        VStack{
            TextField("0.00", value: $amount, formatter: numberFormatter)
                .font(.system(size: 60,weight: .thin))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            
            Rectangle()
                .fill(Color(UIColor.lightGray))
                .frame(height: 1)
                .padding(.horizontal,30)
            
            Picker("Transaction Type", selection: $selectedTransactinType) {
                ForEach(TransactionType.allCases){transactionType in
                    Text(transactionType.title)
                        .tag(transactionType)
                }
            }
            .pickerStyle(.palette)
            .padding(.horizontal)
            
            TextField("Title", text: $title)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal,30)
                .padding(.top)
            Button(action: {
            }, label: {
                Text("Create")
                    .font(.system(size: 15,weight: .semibold))
                    .frame(height: 40)
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(.primaryLightGreen)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            })
            .padding(.top)
            .padding(.horizontal,30)

            Spacer()
        }
        .padding(.top)
    }
}

#Preview {
    AddTransactionView()
}
