//
//  ContentView.swift
//  ContactManager
//
//  Created by Santana, Marcelo de Carvalho on 23/05/26.
//

import SwiftUI
import CoreData
import Combine

struct ContentView: View {

    @Environment(\.managedObjectContext) private var viewContext

    @StateObject private var viewModel: ContactListViewModel

    init() {
        let context = PersistenceController.shared.container.viewContext
        _viewModel = StateObject(
            wrappedValue: ContactListViewModel(context: context)
        )
    }

    var body: some View {
        NavigationView {
            VStack {

                List(viewModel.contacts) { contact in
                    Text(contact.nome)
                }

                Button("Adicionar Contato") {
                    viewModel.addContact()
                }
                .padding()

            }
            .navigationTitle("Contacts")
        }
    }
}
