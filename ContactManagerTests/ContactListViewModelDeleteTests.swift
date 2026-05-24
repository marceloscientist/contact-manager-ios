import XCTest
import CoreData
@testable import ContactManager

final class ContactListViewModelDeleteTests: XCTestCase {

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

    func testDeleteContact_shouldOnlyRemoveSelectedContact() {

        // Arrange
        let contact1 = Contact(
            id: UUID(),
            nome: "A",
            email: "",
            telefone: "",
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

        let contact2 = Contact(
            id: UUID(),
            nome: "B",
            email: "",
            telefone: "",
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

        viewModel.add(contact: contact1)
        viewModel.add(contact: contact2)

        // Act
        viewModel.deleteContact(id: contact1.id)

        // Assert
        XCTAssertEqual(viewModel.contacts.count, 1)
        XCTAssertEqual(viewModel.contacts.first?.nome, "B")
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
