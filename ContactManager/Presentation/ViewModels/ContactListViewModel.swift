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

    func add(contact: Contact) {
        repository.create(contact: contact)
        fetchContacts()
    }

    func deleteContact(id: UUID) {
        repository.delete(id: id)
        fetchContacts()
    }

    func update(contact: Contact) {
        repository.delete(id: contact.id)
        repository.create(contact: contact)
        fetchContacts()
    }
}
