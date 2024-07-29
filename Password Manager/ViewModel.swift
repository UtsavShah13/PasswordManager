//
//  ViewModel.swift
//  Password Manager
//
//  Created by Utsav Shah on 30/07/24.
//

import Foundation

class ViewModel : ObservableObject{
    @Published var accounts = [
        Account(name: "Google", email: "user@gmail.com", password: "password123"),
        Account(name: "LinkedIn", email: "user@linkedin.com", password: "password123"),
        Account(name: "Twitter", email: "user@twitter.com", password: "password123"),
        Account(name: "Facebook", email: "amitshah165@mail.com", password: "password123"),
        Account(name: "Instagram", email: "user@instagram.com", password: "password123")
    ]

}
