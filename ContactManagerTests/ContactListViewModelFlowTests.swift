import XCTest
import CoreData
@testable import ContactManager

final class ContactListViewModelFlowTests: XCTestCase {

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

    func testFullFlow_createUpdateDelete_shouldMaintainConsistency() {

        // Arrange - Create
        let contact = Contact(
            id: UUID(),
            nome: "Original",
            email: "original@email.com",
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
        XCTAssertEqual(viewModel.contacts.first?.nome, "Original")

        // Act - Update
        let updatedContact = Contact(
            id: contact.id,
            nome: "Atualizado",
            email: "novo@email.com",
            telefone: "999",
            nascimento: contact.nascimento,
            cep: "",
            bairro: "",
            logradouro: "",
            numero: "",
            cidade: "",
            estado: "",
            createdAt: contact.createdAt,
            updatedAt: Date()
        )

        viewModel.update(contact: updatedContact)

        // Assert Update
        XCTAssertEqual(viewModel.contacts.count, 1)
        XCTAssertEqual(viewModel.contacts.first?.nome, "Atualizado")

        // Act - Delete
        viewModel.deleteContact(id: contact.id)

        // Assert Delete
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
