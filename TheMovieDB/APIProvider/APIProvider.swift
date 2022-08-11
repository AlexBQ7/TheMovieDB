//
//  APIProvider.swift
//  TheMovieDB
//
//  Created by Alejandro Barreto on 10/08/22.
//

import Foundation

final class APIProvider {
    static let shared = APIProvider()
    private let token = "1288e2b85807efeeabc728712a3d48ef"
    let base_url = "https://api.themoviedb.org/3/"
    
    func requestToken() {
        guard let url = URL(string: "\(base_url)authentication/token/new?api_key=\(token)") else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try JSONDecoder().decode(TokenRequest.self, from: data)
                print(response)
                UserDefaults.standard.set(response.request_token, forKey: "request_token")
                UserDefaults.standard.synchronize()
            } catch {
                print(error)
            }
        }
        task.resume()
    }
    
    func getPopular(success: @escaping (_ response: [Movie]) -> (), failure: @escaping (_ error: String?) -> ()) {
        guard let url = URL(string: "\(base_url)movie/popular?api_key=\(token)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try JSONDecoder().decode(MovieResult.self, from: data)
                success(response.results)
            } catch {
                failure(error.localizedDescription)
            }

        }
        task.resume()
    }
    
    func getTopRated(success: @escaping (_ response: [Movie]) -> (), failure: @escaping (_ error: String?) -> ()) {
        guard let url = URL(string: "\(base_url)movie/top_rated?api_key=\(token)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try JSONDecoder().decode(MovieResult.self, from: data)
                success(response.results)
            } catch {
                failure(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func login(username: String, password: String, success: @escaping (_ response: TokenRequest) -> (), failure: @escaping (_ error: String?) -> ()) {
        let parameters = ["username" : username, "password" : password, "request_token" : UserDefaults.standard.string(forKey: "request_token")]
        guard let url = URL(string: "\(base_url)authentication/token/validate_with_login?api_key=\(token)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        request.httpBody = httpBody
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try JSONDecoder().decode(TokenRequest.self, from: data)
                print(response)
                success(response)
            } catch {
                failure(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}
