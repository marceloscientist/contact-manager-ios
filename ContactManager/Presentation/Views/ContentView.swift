//
//  ContentView.swift
//  ContactManager
//
//  Created by Santana, Marcelo de Carvalho on 23/05/26.
//

import SwiftUI
import CoreData
import Combine
import Foundation

struct ContentView: View {

    @StateObject private var viewModel: ContactListViewModel
    @State private var showingForm = false
    @State private var selectedContact: Contact?

    init() {
        let context = PersistenceController.shared.container.viewContext
        _viewModel = StateObject(
            wrappedValue: ContactListViewModel(context: context)
        )
    }

    var body: some View {
        NavigationView {
            List {

                ForEach(viewModel.contacts) { contact in
                    Button {
                        selectedContact = contact
                    } label: {
                        Text(contact.nome)
                    }
                }
                .onDelete { indexSet in
                    for index in indexSet {
                        let contact = viewModel.contacts[index]
                        viewModel.deleteContact(id: contact.id)
                    }
                }

            }
            .navigationTitle("Contacts")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingForm = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }

            // ✅ CREATE
            .sheet(isPresented: $showingForm) {
                ContactFormView { contact in
                    viewModel.add(contact: contact)
                }
            }

            // ✅ EDIT
            .sheet(item: $selectedContact) { contact in
                ContactFormView(contactToEdit: contact) { updatedContact in
                    viewModel.update(contact: updatedContact)
                }
            }
        }
    }
}
