//
//  ContactManagerTests.swift
//  ContactManagerTests
//
//  Created by Santana, Marcelo de Carvalho on 23/05/26.
//
import XCTest
import CoreData
@testable import ContactManager

final class ContactListViewModelTests: XCTestCase {

    var viewModel: ContactListViewModel!
    var context: NSManagedObjectContext!

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

    // ✅ Teste CREATE
    func testAddContact_shouldIncreaseContactsCount() {

        // Arrange
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

        // Act
        viewModel.add(contact: contact)

        // Assert
        XCTAssertEqual(viewModel.contacts.count, 1)
    }

    // ✅ Teste DELETE
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

        // Act
        viewModel.deleteContact(id: contact.id)

        // Assert
        XCTAssertEqual(viewModel.contacts.count, 0)
    }
    
    
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
