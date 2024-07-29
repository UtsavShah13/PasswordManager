//
//  AccountDetailView.swift
//  Password Manager
//
//  Created by Utsav Shah on 29/07/24.
//

import SwiftUI

struct AccountDetails: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel: ViewModel = .init()
    var account: Account
    @State private var isPasswordVisible: Bool = false
    @State private var editedName: String = ""
    @State private var editedEmail: String = ""
    @State private var editedPassword: String = ""
    
    
    var body: some View {
        
        Spacer()
        VStack(alignment: .leading, content: {
            Text("Account Details")
                .font(.title)
                .foregroundColor(Color.blue)
                .background(.clear)
                .padding(.leading, 21)
            
            Form {
                Section(header: Text("Account Type")) {
                    Text(editedName)
                }
                Section(header: Text("Username/ Email")) {
                    Text(editedEmail)
                }
                Section(header: Text("Password")) {
                    HStack {
                        Group {
                            if isPasswordVisible {
                                TextField("Password", text: $editedPassword)
                            } else {
                                SecureField("Password", text: $editedPassword)
                            }
                        }
                        .textContentType(.oneTimeCode)

                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: !isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.gray)
                        }
                    }
                }
                
            }
            .background(.clear)
            .formStyle(.automatic)
            .onAppear {
                editedName = account.name
                editedEmail = account.email
                editedPassword = account.password
            }
            HStack {
                Button(action: {
                    // Handle edit action
                    if let index = viewModel.accounts.firstIndex(where: { $0.id == account.id }) {
                        viewModel.accounts[index] = account
                    }
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Edit")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.black)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    // Handle delete action
                    if let index = viewModel.accounts.firstIndex(where: { $0.id == account.id }) {
                        viewModel.accounts.remove(at: index)
                    }
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Delete")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            
            .padding([.leading, .trailing, .bottom])
        })
        
    }
}

#Preview {
    AccountDetails(account: Account(name: "", email: "", password: ""))
}
