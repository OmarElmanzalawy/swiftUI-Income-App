//
//  ContentView.swift
//  IncomeApp
//
//  Created by MAC on 19/03/2025.
//

import SwiftUI

struct ContentView: View {
    
    @State private var transactions: [TransactionModel] = [
        TransactionModel(title: "Apples", date: Date(), type: TransactionType.expense, amount: 5.00)]
    
    @State private var showAddTransactionView = false
    @State private var transactionToEdit: TransactionModel?
    
    var expenses: String {
        let sumExpenses = transactions.filter({ $0.type == .expense }).reduce(0, { $0 + $1.amount})
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: sumExpenses as NSNumber) ?? "0"
    }
    
    var income: String {
        let sumIncome = transactions.filter({ $0.type == .income }).reduce(0, { $0 + $1.amount})
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: sumIncome as NSNumber) ?? "0"
    }
    
    var total: String {
        let sumExpenses = transactions.filter({ $0.type == .expense }).reduce(0, { $0 + $1.amount})
        let sumIncome = transactions.filter({ $0.type == .income }).reduce(0, { $0 + $1.amount})
        let total = sumIncome - sumExpenses
       
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: total as NSNumber) ?? "0"
    }
    
    
    
    fileprivate func BalanceView() -> some View{
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(.primaryLightGreen)
            VStack(alignment: .leading,spacing: 5){
                HStack{
                    VStack(alignment: .leading){
                        Text("BALANCE")
                            .font(.caption)
                            .foregroundStyle(.white)
                        Text(total)
                            .font(.system(size: 42,weight: .light))
                            .foregroundStyle(.white)
                    }
                    
                    Spacer()
                }
                .padding(.top)
                
                HStack(spacing: 25){
                    VStack(alignment:.leading){
                        Text("Expense")
                            .font(.system(size: 15,weight: .semibold))
                            .foregroundStyle(.white)
                        Text(expenses)
                            .font(.system(size: 15))
                            .foregroundStyle(.white)
                        
                    }
//                    .frame(width: 200)
                    VStack(alignment: .leading){
                        Text("Income")
                            .font(.system(size: 15,weight: .semibold))
                            .foregroundStyle(.white)
                        Text(income)
                            .font(.system(size: 15))
                            .foregroundStyle(.white)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .shadow(color: Color.black.opacity(0.3),radius: 10,x: 0,y: 5)
        .frame(height: 150)
        .padding(.horizontal)
    }
    
    fileprivate func FloatingButton() -> some View {
        VStack {
            Spacer()
            NavigationLink {
                AddTransactionView(transactions: $transactions)
            } label: {
                Text("+")
                    .font(.largeTitle)
                    .frame(width: 70,height: 70)
                    .foregroundStyle(.white)
//                    .background()
            }
            .background(.primaryLightGreen)
            .clipShape(Circle())
            
        }
    }
    
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BalanceView()
                    List(transactions){transaction in
                        ForEach(transactions){transaction in
                            Button(action: {
    //                            showAddTransactionView = true
                                transactionToEdit = transaction
                            },label:{
                                TransactionView(transaction: transaction)
                                    .foregroundStyle(.black)
                            })
                        }
                        .onDelete(perform: deleteItem)
                    }
                    .scrollContentBackground(.hidden)
                }
                
                FloatingButton()
                    
            }
            .navigationTitle("Income")
            .navigationDestination(item: $transactionToEdit, destination: { transaction in
                AddTransactionView(transactions: $transactions,transactionToEdit: transactionToEdit)
            })
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.primaryLightGreen)
                    }

                }
            }
        }
    }
    
    private func deleteItem(at offsets: IndexSet){
        transactions.remove(atOffsets: offsets)
    }
}

#Preview {
    ContentView()
}
