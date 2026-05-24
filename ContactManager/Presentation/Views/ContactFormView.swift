import SwiftUI

import CoreData
import Combine

struct ContactFormView: View {

    @Environment(\.dismiss) private var dismiss

    @State private var nome = ""
    @State private var email = ""
    @State private var telefone = ""

    var onSave: (Contact) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dados Básicos")) {
                    TextField("Nome", text: $nome)
                    TextField("Email", text: $email)
                    TextField("Telefone", text: $telefone)
                }
            }
            .navigationTitle("Novo Contato")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancelar") {
                        dismiss()
                    }
                }

                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Salvar") {
                        saveContact()
                    }
                    .disabled(nome.isEmpty)
                }
            }
        }
    }

    private func saveContact() {
        let contact = Contact(
            id: UUID(),
            nome: nome,
            email: email,
            telefone: telefone,
            nascimento: Date(),
            cep: "",
            bairro: "",
            logradouro: "",
            numero: "",
            cidade: "",
            estado: "",
            createdAt: Date(),
            updatedAt: Date()
        )

        onSave(contact)
        dismiss()
    }
}
