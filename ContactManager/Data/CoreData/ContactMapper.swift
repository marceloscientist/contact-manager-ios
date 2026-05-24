import Foundation
import CoreData


struct ContactMapper {

    static func toDomain(entity: ContactEntity) -> Contact {
        return Contact(
            id: entity.id ?? UUID(),
            nome: entity.nome ?? "",
            email: entity.email ?? "",
            telefone: entity.telefone ?? "",
            nascimento: entity.nascimento ?? Date(),
            cep: entity.cep ?? "",
            bairro: entity.bairro ?? "",
            logradouro: entity.logradouro ?? "",
            numero: entity.numero ?? "",
            cidade: entity.cidade ?? "",
            estado: entity.estado ?? "",
            createdAt: entity.createdAt ?? Date(),
            updatedAt: entity.updatedAt ?? Date()
        )
    }

    static func toEntity(contact: Contact, context: NSManagedObjectContext) -> ContactEntity {
        let entity = ContactEntity(context: context)

        entity.id = contact.id
        entity.nome = contact.nome
        entity.email = contact.email
        entity.telefone = contact.telefone
        entity.nascimento = contact.nascimento
        entity.cep = contact.cep
        entity.bairro = contact.bairro
        entity.logradouro = contact.logradouro
        entity.numero = contact.numero
        entity.cidade = contact.cidade
        entity.estado = contact.estado
        entity.createdAt = contact.createdAt
        entity.updatedAt = contact.updatedAt

        return entity
    }
}
