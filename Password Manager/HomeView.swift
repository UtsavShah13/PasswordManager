//
//  ContentView.swift
//  Password Manager
//
//  Created by Utsav Shah on 28/07/24.
//

import SwiftUI

struct Account: Identifiable {
    let id = UUID()
    var name: String
    var email: String
    var password: String
}


struct HomeScreen: View {
    @State private var showingAddAccount = false
    @State private var showingAccountDetail = false
    @State private var selectedAccount: Account?
    @State private var isActive = false
    @StateObject var viewModel: ViewModel = .init()

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.accounts) { account in
                        HStack {
                            Text(account.name)
                                .fontWeight(.bold)
                            Text("*******")
                                .foregroundColor(.gray)
                            Spacer()
                            Image(systemName: "chevron.right").resizable().frame(width: 6,height: 12)
                                .padding(.all,10)
                                .foregroundColor(.black)
                                .background(.white)
                                .clipShape(Circle())
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .onTapGesture {
                            showingAccountDetail = true
                            selectedAccount = account
                        }
                    }
                    .listRowSeparator(.hidden)
                }
                .listRowSeparator(.hidden)
                .listStyle(.plain)
                
                
                HStack {
                    Spacer()
                    Button(action: {
                        showingAddAccount.toggle()
                    }) {
                        Image("add")
                            .font(.system(size: 24))
                            .foregroundColor(.white)
                    }
                    .frame(width: 60, height: 60)
                    .padding(.trailing, 21)
                }
                .sheet(isPresented: $showingAddAccount, content: {
                    AddAccount(accounts: $viewModel.accounts)
                        .presentationDetents([.fraction(0.5)])
                })
                .sheet(isPresented: $showingAccountDetail, content: {
                    if let account = selectedAccount {
                        AccountDetails(account: account)
                            .presentationDetents([.fraction(0.45)])
                    }
                })
            }
            .navigationTitle("Password Manager")
            
        }
    }
}

struct AddAccount: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var accounts: [Account]
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""
    @State private var isPasswordVisible: Bool = false

    var body: some View {
            VStack(spacing: 10, content: {
                BorderedTextField(placeholder: "Account Name", text: $name)
                BorderedTextField(placeholder: "Username/ Email", text: $email)
                HStack {
                    if isPasswordVisible {
                        Text(password)
                    } else {
                        SecureField("Password", text: ($password))
                    }
                    Spacer()
                    Button(action: {
                        isPasswordVisible.toggle()
                    }) {
                        Image(systemName: !isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                            .foregroundColor(.gray)
                    }
                }

                    .padding()
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.vertical, 5)
                Spacer()
                    .frame(height: 20)
                Button(action: {
                    if name != "" && email != "" {
                        if password.count > 6 {
                            let newAccount = Account(name: name, email: email, password: password)
                            accounts.append(newAccount)
                            self.presentationMode.wrappedValue.dismiss()
                        } else {
                            print("enter valid password")
                        }
                    }
                }, label: {
                    Text("Add New Account")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(.black)
                        .cornerRadius(10)
                })

            })
            .padding(.horizontal, 12)
        }    
}

struct BorderedTextField: View {
    var placeholder: String
    @Binding var text: String

    var body: some View {
        TextField(placeholder, text: $text)
            .padding()
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .padding(.vertical, 5)
    }
}

#Preview {
    HomeScreen()
}
