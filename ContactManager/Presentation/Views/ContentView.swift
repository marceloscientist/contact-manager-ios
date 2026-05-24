//
//  ContentView.swift
//  ContactManager
//
//  Created by Santana, Marcelo de Carvalho on 23/05/26.
//

import SwiftUI
import CoreData
import Combine

import SwiftUI

struct ContentView: View {

    @Environment(\.managedObjectContext) private var viewContext
    @StateObject private var viewModel: ContactListViewModel
    @State private var showingForm = false

    init() {
        let context = PersistenceController.shared.container.viewContext
        _viewModel = StateObject(
            wrappedValue: ContactListViewModel(context: context)
        )
    }

    var body: some View {
        NavigationView {
            List(viewModel.contacts) { contact in
                Text(contact.nome)
            }
            .navigationTitle("Contacts")
            .toolbar {
                Button {
                    showingForm = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingForm) {
                ContactFormView { contact in
                    viewModel.add(contact: contact)
                }
            }
        }
    }
}

