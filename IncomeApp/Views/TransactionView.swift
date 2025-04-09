//
//  TransactionView.swift
//  IncomeApp
//
//  Created by MAC on 06/04/2025.
//

import SwiftUI

struct TransactionView: View {
    let transaction: TransactionModel
    var body: some View {
        VStack {
            HStack{
                Spacer()
                Text(transaction.displayDate)
                    .font(.system(size: 14))
                    
                Spacer()
            }
            
            .padding(.vertical,5)
            .background(Color.lightGrayShade.opacity(0.5))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            HStack{
                Image(systemName: transaction.type == .income ? "arrow.up.forward" : "arrow.down.forward")
                    .font(.system(size: 16,weight: .bold))
                    .foregroundStyle(transaction.type == .income ? .green : .red)
                VStack(alignment: .leading, spacing: 5){
                    HStack {
                        Text(transaction.title)
                            .font(.system(size: 15,weight: .bold))
                        Spacer()
                        Text(transaction.displayAmount)
                            .font(.system(size: 15,weight:  .bold))
                    }
                    Text("COMPLETED")
                        .font(.system(size: 14))
                    
                }
            }
        }
    }
}

#Preview {
    TransactionView(transaction: TransactionModel(title: "Apple", date: Date.now, type: TransactionType.expense, amount: 5))
}
