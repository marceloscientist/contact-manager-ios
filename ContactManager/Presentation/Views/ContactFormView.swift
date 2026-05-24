import CoreData
import Combine
import SwiftUI


struct ContactFormView: View {

    @Environment(\.dismiss) private var dismiss

    var contactToEdit: Contact?
    var onSave: (Contact) -> Void

    @State private var nome: String
    @State private var email: String
    @State private var telefone: String

    @State private var cep: String
    @State private var bairro: String
    @State private var logradouro: String
    @State private var cidade: String
    @State private var estado: String

    @State private var isLoading = false
    @State private var errorMessage: String?

    @State private var debounceTask: Task<Void, Never>?

    private let service = ViaCEPService()

    init(contactToEdit: Contact? = nil, onSave: @escaping (Contact) -> Void) {
        self.contactToEdit = contactToEdit
        self.onSave = onSave

        _nome = State(initialValue: contactToEdit?.nome ?? "")
        _email = State(initialValue: contactToEdit?.email ?? "")
        _telefone = State(initialValue: contactToEdit?.telefone ?? "")

        _cep = State(initialValue: contactToEdit?.cep ?? "")
        _bairro = State(initialValue: contactToEdit?.bairro ?? "")
        _logradouro = State(initialValue: contactToEdit?.logradouro ?? "")
        _cidade = State(initialValue: contactToEdit?.cidade ?? "")
        _estado = State(initialValue: contactToEdit?.estado ?? "")
    }

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
                            debounceFetchAddress()
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
            .navigationTitle(contactToEdit == nil ? "Novo Contato" : "Editar Contato")
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
            id: contactToEdit?.id ?? UUID(),
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
            createdAt: contactToEdit?.createdAt ?? Date(),
            updatedAt: Date()
        )

        onSave(contact)
        dismiss()
    }

    private func debounceFetchAddress() {

        debounceTask?.cancel()

        debounceTask = Task {
            try? await Task.sleep(nanoseconds: 800_000_000)

            if !Task.isCancelled {
                fetchAddress()
            }
        }
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
