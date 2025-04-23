//
//  LoginViewModel.swift
//  refrig-project-swift
//
//  Created by 이로운 on 4/22/25.
//

import SwiftUI
import AuthenticationServices

class LoginViewModel: NSObject, ObservableObject {
    @AppStorage("jwtToken") var jwtToken: String = ""
    @AppStorage("isLoggedIn") var isLoggedIn: Bool = false
    
    private let scheme = "myapp"
    private let callbackHost = "login-callback"
    
    // MARK: - 딥링크에서 jwt토큰 추출 후 저장
    func handleIncomingURL(_ url: URL) {
        guard url.scheme == "myapp",
              url.host == "login-success",
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false),
              let token = components.queryItems?.first(where: { $0.name == "token" })?.value else {
            print("딥링크 URL 파싱 실패")
            return
        }

        DispatchQueue.main.async {
            self.jwtToken = token
            self.isLoggedIn = true
        }
    }
}

struct JWTResponse: Codable {
    let jwtToken: String
}
