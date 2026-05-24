import Foundation

final class ViaCEPService {

    func fetchAddress(cep: String) async -> ViaCEPResponse? {

        let cleanedCEP = cep.replacingOccurrences(of: "-", with: "")
        guard cleanedCEP.count == 8 else { return nil }

        let urlString = "https://viacep.com.br/ws/\(cleanedCEP)/json/"

        guard let url = URL(string: urlString) else { return nil }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(ViaCEPResponse.self, from: data)
            return response
        } catch {
            print("Erro ao buscar CEP:", error)
            return nil
        }
    }
}
