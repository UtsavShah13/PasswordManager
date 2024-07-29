//
//  ContentView.swift
//  Password Manager
//
//  Created by Utsav Shah on 28/07/24.
//

import SwiftUI

struct HomeScreen: View {
    @State private var accounts = [
        Account(name: "Google", email: "user@gmail.com", password: "password123"),
        Account(name: "LinkedIn", email: "user@linkedin.com", password: "password123"),
        Account(name: "Twitter", email: "user@twitter.com", password: "password123"),
        Account(name: "Facebook", email: "amitshah165@mail.com", password: "password123"),
        Account(name: "Instagram", email: "user@instagram.com", password: "password123")
    ]
    @State private var showingAddAccount = false
    @State private var showingAccountDetail = false
    @State private var selectedAccount: Account?
    @State private var isActive = false
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(accounts) { account in
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
                    AddAccount(accounts: $accounts)
                        .presentationDetents([.fraction(0.5)])
                })
                .sheet(isPresented: $showingAccountDetail, content: {
                    if let account = selectedAccount {
                        AccountDetails(accounts: $accounts, account: account)
                            .presentationDetents([.fraction(0.5)])
                    }
                })
            }
            .navigationTitle("Password Manager")
            
        }
    }
}

struct Account: Identifiable {
    let id = UUID()
    var name: String
    var email: String
    var password: String
}

struct AddAccount: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var accounts: [Account]
    @State private var name = ""
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        NavigationView {
            VStack(spacing: 10, content: {
                BorderedTextField(placeholder: "Account Name", text: $name)
                BorderedTextField(placeholder: "Username/ Email", text: $email)
                SecureField("Password", text: $password)
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
                    let newAccount = Account(name: name, email: email, password: password)
                    accounts.append(newAccount)
                    self.presentationMode.wrappedValue.dismiss()
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

struct AccountDetails: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var accounts: [Account]
    var account: Account

    var body: some View {
        VStack(alignment: .leading, content: {
            Text("Account Details")
                .font(.title)
                .foregroundColor(Color.blue)
                .background(.clear)
                
            Form {
                Section(header: Text("Account Type")) {
                    Text(account.name)
                }
                Section(header: Text("Username/ Email")) {
                    Text(account.email)
                }
                Section(header: Text("Password")) {
                    SecureField("Password", text: .constant(account.password))
                }
            }
            .background(.clear)
            .formStyle(.automatic)
            
            HStack {
                Button(action: {
                    // Handle edit action
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
//                    accounts.remov
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


struct ContentView: View {
    var body: some View {
        HomeScreen()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
