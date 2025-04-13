//
//  AddTransactionView.swift
//  IncomeApp
//
//  Created by MAC on 06/04/2025.
//

import SwiftUI

struct AddTransactionView: View {
    
    
    
    @Binding var transactions: [TransactionModel]
    var transactionToEdit: TransactionModel?
    @State private var amount = 0.0
    @State private var selectedTransactinType: TransactionType = .expense
    @State private var title = ""
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @Environment(\.dismiss) var dismiss
    
    @AppStorage("currency") var currency: Currency = .usd
    
    var numberFormatter: NumberFormatter{
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
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
                guard title.count >= 2 else{
                    alertTitle = "Invalid Title"
                    alertMessage = "Title must be 2 or more characters long"
                    showAlert = true
                    return
                }
                let transaction = TransactionModel(title: title, date: Date.now, type: selectedTransactinType, amount: amount)
                if let transactionToEdit = transactionToEdit{
                    guard let index = transactions.firstIndex(of: transactionToEdit) else{
                        alertTitle = "Update Failed"
                        alertMessage = "Something went wrong while updating transaction"
                        showAlert = true
                        return
                    }
                    transactions[index] = transaction
                }
                else{
                    transactions.append(transaction)
                }
                
                
                
                dismiss()
                
            }, label: {
                Text(transactionToEdit == nil ? "Create" : "Update")
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
        .onAppear(perform: {
            if let transactionToEdit = transactionToEdit {
                amount = transactionToEdit.amount
                title = transactionToEdit.title
                selectedTransactinType = transactionToEdit.type
            }
        })
        .padding(.top)
        .alert(alertTitle, isPresented: $showAlert) {
            Button {
                
            } label: {
                Text("OK")
            }

        } message: {
            Text(alertMessage)
        }

    }
}

#Preview {
    AddTransactionView(transactions: .constant([]))
}
