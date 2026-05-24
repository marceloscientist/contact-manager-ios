import XCTest
import CoreData
@testable import ContactManager

final class ContactListViewModelEdgeCasesTests: XCTestCase {

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

    func testUpdateContact_whenContactDoesNotExist_shouldNotCrash() {

        // Arrange
        let contact = Contact(
            id: UUID(),
            nome: "Inexistente",
            email: "email@test.com",
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

        // Act
        viewModel.update(contact: contact)

        // Assert
        XCTAssertEqual(viewModel.contacts.count, 1)
    }

    func testDeleteContact_whenContactDoesNotExist_shouldNotCrash() {

        // Arrange
        let randomId = UUID()

        // Act
        viewModel.deleteContact(id: randomId)

        // Assert
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
