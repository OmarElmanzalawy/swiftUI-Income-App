//
//  ContentView.swift
//  IncomeApp
//
//  Created by MAC on 19/03/2025.
//

import SwiftUI

struct ContentView: View {
    
    @Environment(\.managedObjectContext) var moc
    
    @State private var showAddTransactionView = false
    @State private var transactionToEdit: TransactionItem?
    @State private var showSettingsSheet: Bool = false
    
    @FetchRequest(sortDescriptors: [
        SortDescriptor(\.date, order: .reverse)
    ]) var transactionsCoreData: FetchedResults<TransactionItem>
    
    @AppStorage("orderdescending") var orderDescending = false
    @AppStorage("currency") var currency: Currency = .usd
    @AppStorage("filterMinimum") private var filterMinimum: Double = 0.0
    
    var displayTransactions: [TransactionModel] {
        let transactions = transactionsCoreData.map { TransactionModel.fromCoreData($0) }
        let sortedTransactions = orderDescending ?
            transactions.sorted(by: {$0.date < $1.date}) :
            transactions.sorted(by: {$0.date > $1.date})
        return sortedTransactions.filter({$0.amount >= filterMinimum})
    }
    
    var expenses: String {
        let sumExpenses = displayTransactions
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: sumExpenses as NSNumber) ?? "0"
    }
    
    var income: String {
        let sumIncome = displayTransactions
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
        return numberFormatter.string(from: sumIncome as NSNumber) ?? "0"
    }
    
    var total: String {
        let sumExpenses = displayTransactions
            .filter { $0.type == .expense }
            .reduce(0) { $0 + $1.amount }
        let sumIncome = displayTransactions
            .filter { $0.type == .income }
            .reduce(0) { $0 + $1.amount }
        let total = sumIncome - sumExpenses
        
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.locale = currency.locale
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
                AddTransactionView()
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
                    List(displayTransactions) { transaction in
                        Button(action: {
                            // Find corresponding CoreData object
                            transactionToEdit = transactionsCoreData.first { $0.wrappedId == transaction.id }
                        }, label: {
                            TransactionView(transaction: transaction)
                                .foregroundStyle(.black)
                        })
                    }
                    .scrollContentBackground(.hidden)
                }
                
                FloatingButton()
            }
            .navigationTitle("Income")
            .navigationDestination(item: $transactionToEdit) { transaction in
                AddTransactionView(transactionToEdit: transaction)
            }
            .sheet(isPresented: $showSettingsSheet) {
                SettingsView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        showSettingsSheet = true
                    } label: {
                        Image(systemName: "gearshape.fill")
                            .foregroundStyle(.primaryLightGreen)
                    }
                }
            }
        }
    }
    
    private func deleteItem(at offsets: IndexSet) {
        for offset in offsets {
            let transaction = transactionsCoreData[offset]
            moc.delete(transaction)
        }
        try? moc.save()
    }
    
    private func saveContext() {
        do {
            try moc.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, DataManager.shared.container.viewContext)
}
