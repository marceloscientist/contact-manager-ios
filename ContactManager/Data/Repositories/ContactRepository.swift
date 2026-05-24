import Foundation
import CoreData

final class ContactRepository {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func create(contact: Contact) {
        _ = ContactMapper.toEntity(contact: contact, context: context)
        saveContext()
    }

    func fetchAll() -> [Contact] {
        let request = ContactEntity.fetchRequest()

        do {
            let entities = try context.fetch(request)
            return entities.compactMap { ContactMapper.toDomain(entity: $0) }
        } catch {
            print("Error fetching contacts:", error)
            return []
        }
    }

    func delete(id: UUID) {
        let request: NSFetchRequest<ContactEntity> = ContactEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", id as CVarArg)

        do {
            let results = try context.fetch(request)
            results.forEach { context.delete($0) }
            saveContext()
        } catch {
            print("Error deleting:", error)
        }
    }

    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context:", error)
        }
    }
}
