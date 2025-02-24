//
//  ContentView.swift
//  SwiftLibrary
//
//  Created by Pieter Yoshua Natanael on 28/01/25.
//

import SwiftUI
import AuthenticationServices

struct ContentView: View {
    @State private var idToken: String? = nil
    @State private var session: ASWebAuthenticationSession?
    @StateObject private var contextProvider = ContextProvider()

    let clientID = ""
    let keycloakURL = "https://keycloak.dev"
    let tokenURL = "https://keycloak.dev"
    let redirectURI = "//callback"

    var body: some View {
        VStack {
            if let token = idToken {
                Text("ID Token:")
                    .font(.headline)
                ScrollView {
                    Text(token)
                        .font(.system(size: 12, weight: .medium, design: .monospaced))
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                        .padding()
                }

                Button("Logout") {
                    logout()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(8)
            } else {
                Button("Login with Keycloak") {
                    login()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.blue)
                .cornerRadius(8)
            }
        }
    }

    func login() {
        guard let authURL = URL(string: "\(keycloakURL)?client_id=\(clientID)&response_type=code&redirect_uri=\(redirectURI)") else { return }

        session = ASWebAuthenticationSession(url: authURL, callbackURLScheme: "effort") { callbackURL, error in
            guard error == nil, let callbackURL = callbackURL else { return }
            
            if let code = extractAuthCode(from: callbackURL) {
                exchangeCodeForToken(authCode: code)
            }
        }
        session?.presentationContextProvider = contextProvider
        session?.start()
    }

    func extractAuthCode(from url: URL) -> String? {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else { return nil }
        return components.queryItems?.first(where: { $0.name == "code" })?.value
    }

    func exchangeCodeForToken(authCode: String) {
        guard let url = URL(string: tokenURL) else { return }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let bodyParams = "grant_type=authorization_code&client_id=\(clientID)&code=\(authCode)&redirect_uri=\(redirectURI)"
        request.httpBody = bodyParams.data(using: .utf8)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else { return }
            if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
               let idToken = json["id_token"] as? String {
                DispatchQueue.main.async {
                    self.idToken = idToken
                }
            }
        }.resume()
    }

    func logout() {
        idToken = nil
    }
}

class ContextProvider: NSObject, ASWebAuthenticationPresentationContextProviding, ObservableObject {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return UIApplication.shared.connectedScenes
            .compactMap { $0 as? UIWindowScene }
            .flatMap { $0.windows }
            .first(where: { $0.isKeyWindow }) ?? UIWindow()
    }
}


#Preview {
    ContentView()
}
