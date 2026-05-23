import Foundation

struct Contact: Identifiable {
    let id: UUID
    var nome: String
    var email: String
    var telefone: String
    var nascimento: Date

    var cep: String
    var bairro: String
    var logradouro: String
    var numero: String
    var cidade: String
    var estado: String

    var createdAt: Date
    var updatedAt: Date
}
