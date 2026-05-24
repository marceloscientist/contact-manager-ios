import SwiftUI

import CoreData
import Combine

struct ContactFormView: View {

    @Environment(\.dismiss) private var dismiss
    @State private var isLoading = false
    @State private var errorMessage: String?

    @State private var nome = ""
    @State private var email = ""
    @State private var telefone = ""
    @State private var cep = ""
    @State private var bairro = ""
    @State private var logradouro = ""
    @State private var cidade = ""
    @State private var estado = ""
    
    private let service = ViaCEPService()

    var onSave: (Contact) -> Void

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Dados Básicos")) {
                    TextField("Nome", text: $nome)
                    TextField("Email", text: $email)
                    TextField("Telefone", text: $telefone)
                }
                
                Section(header: Text("Endereço")) {

                    TextField("CEP", text: $cep)
                        .keyboardType(.numberPad)
                        .onChange(of: cep) {
                            fetchAddress()
                        }

                    if isLoading {
                        ProgressView("Buscando endereço...")
                    }

                    if let errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                    }

                    TextField("Logradouro", text: $logradouro)
                    TextField("Bairro", text: $bairro)
                    TextField("Cidade", text: $cidade)
                    TextField("Estado", text: $estado)
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
            cep: cep,
            bairro: bairro,
            logradouro: logradouro,
            numero: "",
            cidade: cidade,
            estado: estado,
            createdAt: Date(),
            updatedAt: Date()
        )

        onSave(contact)
        dismiss()
    }

    private func fetchAddress() {

        guard cep.count == 8 else {
            isLoading = false
            errorMessage = nil
            return
        }

        isLoading = true
        errorMessage = nil

        Task {
            let response = await service.fetchAddress(cep: cep)

            await MainActor.run {
                isLoading = false

                if let response {
                    logradouro = response.logradouro ?? ""
                    bairro = response.bairro ?? ""
                    cidade = response.localidade ?? ""
                    estado = response.uf ?? ""
                } else {
                    errorMessage = "CEP não encontrado"
                }
            }
        }
    }
}
