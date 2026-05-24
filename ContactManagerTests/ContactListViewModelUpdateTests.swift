import XCTest
import CoreData
@testable import ContactManager

final class ContactListViewModelUpdateTests: XCTestCase {

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

    func testUpdateContact_shouldUpdateName() {

        // Arrange
        let original = Contact(
            id: UUID(),
            nome: "Original",
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

        viewModel.add(contact: original)

        let updated = Contact(
            id: original.id,
            nome: "Atualizado",
            email: "novo@email.com",
            telefone: "999",
            nascimento: original.nascimento,
            cep: "",
            bairro: "",
            logradouro: "",
            numero: "",
            cidade: "",
            estado: "",
            createdAt: original.createdAt,
            updatedAt: Date()
        )

        // Act
        viewModel.update(contact: updated)

        // Assert
        XCTAssertEqual(viewModel.contacts.first?.nome, "Atualizado")
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
