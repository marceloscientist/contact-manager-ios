import Foundation

struct ViaCEPResponse: Decodable {
    let cep: String?
    let logradouro: String?
    let bairro: String?
    let localidade: String?
    let uf: String?
}
