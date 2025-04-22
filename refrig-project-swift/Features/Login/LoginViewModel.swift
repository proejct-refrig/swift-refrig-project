//
//  LoginViewModel.swift
//  refrig-project-swift
//
//  Created by 이로운 on 4/22/25.
//

import SwiftUI

class LoginViewModel: ObservableObject {
    @AppStorage("jwt") var jwtToken: String = ""
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    func fetchJWT() {
        // jwt 주는 엔드포인트 알아오기
        guard let url = URL(string: "https://your.backend.com/api/auth/kakao") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data,
               let result = try? JSONDecoder().decode(JWTResponse.self, from: data) {
                DispatchQueue.main.async{
                    self.jwtToken = result.jwtToken
                    self.isLoggedIn = true
                }
            }
        }.resume()
    }
}

struct JWTResponse: Codable {
    let jwtToken: String
}
