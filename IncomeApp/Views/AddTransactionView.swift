//
//  AddTransactionView.swift
//  IncomeApp
//
//  Created by MAC on 06/04/2025.
//

import SwiftUI

struct AddTransactionView: View {
    
    
    
//    @Binding var transactions: [TransactionItem]
    var transactionToEdit: TransactionItem?
    @State private var amount = 0.0
    @State private var selectedTransactinType: TransactionType = .expense
    @State private var title = ""
    @State private var showAlert = false
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @Environment(\.dismiss) private var dismiss
    @Environment(\.managedObjectContext) private var viewContext
    
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

                if let transactionToEdit = transactionToEdit{
                    transactionToEdit.title = title
                    transactionToEdit.amount = amount
                    transactionToEdit.type = Int16(selectedTransactinType.rawValue)
                    
                    do{
                        try viewContext.save()
                    } catch{
                        alertTitle = "Something went wrong"
                        alertMessage = "Cannot update this transaction right now"
                        showAlert = true
                        return
                    }
                }
                else{
                    
                    let transaction = TransactionItem(context: viewContext)
                    transaction.amount = amount
                    transaction.title = title
                    transaction.date = Date.now
                    transaction.type = Int16(selectedTransactinType.rawValue)
                    transaction.id = UUID()
                    
                    try? viewContext.save()
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
                title = transactionToEdit.wrappedTitle
                selectedTransactinType = transactionToEdit.wrappedType
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
    AddTransactionView()
}
