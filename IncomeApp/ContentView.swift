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
    
    fileprivate func BalanceView() -> some View{
        ZStack{
            RoundedRectangle(cornerRadius: 8)
                .fill(.primaryLightGreen)
            VStack(alignment: .leading,spacing: 5){
                HStack{
                    VStack{
                        Text("BALANCE")
                            .font(.caption)
                            .foregroundStyle(.white)
                        Text("$2")
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
                        Text("$22")
                            .font(.system(size: 15))
                            .foregroundStyle(.white)
                        
                    }
//                    .frame(width: 200)
                    VStack(alignment: .leading){
                        Text("Income")
                            .font(.system(size: 15,weight: .semibold))
                            .foregroundStyle(.white)
                        Text("$22")
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
                    List(transactions){transaction in
                        TransactionView(transaction: transaction)
                    }
                    .scrollContentBackground(.hidden)
                }
                FloatingButton()
                    .navigationTitle("Income")
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
    }
}

#Preview {
    ContentView()
}
