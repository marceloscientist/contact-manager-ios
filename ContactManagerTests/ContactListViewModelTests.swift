import XCTest
import CoreData
@testable import ContactManager

final class ContactListViewModelTests: XCTestCase {

    var viewModel: ContactListViewModel!
    var context: NSManagedObjectContext!

    // MARK: - Setup

    override func setUp() {
        super.setUp()

        context = createInMemoryContext()
        viewModel = ContactListViewModel(context: context)
    }

    override func tearDown() {
        viewModel = nil
        context = nil
        super.tearDown()
    }

    // MARK: - Tests

    func testInitialState_shouldStartEmpty() {
        XCTAssertEqual(viewModel.contacts.count, 0)
    }

    func testAddContact_shouldIncreaseContactsCount() {

        let contact = Contact(
            id: UUID(),
            nome: "Teste",
            email: "teste@email.com",
            telefone: "123",
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

        viewModel.add(contact: contact)

        XCTAssertEqual(viewModel.contacts.count, 1)
    }

    func testDeleteContact_shouldRemoveContact() {

        let contact = Contact(
            id: UUID(),
            nome: "Teste",
            email: "teste@email.com",
            telefone: "123",
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

        viewModel.add(contact: contact)
        viewModel.deleteContact(id: contact.id)

        XCTAssertEqual(viewModel.contacts.count, 0)
    }

    // MARK: - Helpers

    private func createInMemoryContext() -> NSManagedObjectContext {

        let container = NSPersistentContainer(name: "ContactManager")

        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType

        container.persistentStoreDescriptions = [description]

        container.loadPersistentStores { _, error in
            XCTAssertNil(error)
        }

        return container.viewContext
    }
}
