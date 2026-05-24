import Foundation
import CoreData
import SwiftUI
import Combine

final class ContactListViewModel: ObservableObject {

    @Published var contacts: [Contact] = []

    private let repository: ContactRepository

    init(context: NSManagedObjectContext) {
        self.repository = ContactRepository(context: context)
        fetchContacts()
    }

    func fetchContacts() {
        contacts = repository.fetchAll()
    }

    func addContact() {
        let newContact = Contact(
            id: UUID(),
            nome: "Marcelo",
            email: "marcelo@email.com",
            telefone: "11999999999",
            nascimento: Date(),
            cep: "01001000",
            bairro: "Centro",
            logradouro: "Praça da Sé",
            numero: "100",
            cidade: "São Paulo",
            estado: "SP",
            createdAt: Date(),
            updatedAt: Date()
        )

        repository.create(contact: newContact)
        fetchContacts()
    }

    func deleteContact(id: UUID) {
        repository.delete(id: id)
        fetchContacts()
    }
}
