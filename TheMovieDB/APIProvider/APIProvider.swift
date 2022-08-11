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
    let base_url = "https://api.themoviedb.org/3"
    let images_url = "https://image.tmdb.org/t/p/w500"
    
    func requestToken() {
        guard let url = URL(string: "\(base_url)/authentication/token/new?api_key=\(token)") else {
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
        guard let url = URL(string: "\(base_url)/movie/popular?api_key=\(token)") else { return }
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
        guard let url = URL(string: "\(base_url)/movie/top_rated?api_key=\(token)") else { return }
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
    
    func getAiringToday(success: @escaping (_ response: [TVShow]) -> (), failure: @escaping (_ error: String?) -> ()) {
        guard let url = URL(string: "\(base_url)/tv/airing_today?api_key=\(token)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try JSONDecoder().decode(TVResult.self, from: data)
                success(response.results)
            } catch {
                failure(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func getOnTV(success: @escaping (_ response: [TVShow]) -> (), failure: @escaping (_ error: String?) -> ()) {
        guard let url = URL(string: "\(base_url)/tv/popular?api_key=\(token)") else { return }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try JSONDecoder().decode(TVResult.self, from: data)
                success(response.results)
            } catch {
                failure(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func login(username: String, password: String, success: @escaping (_ response: TokenRequest) -> (), failure: @escaping (_ error: String?) -> ()) {
        let parameters = ["username": username, "password": password, "request_token": UserDefaults.standard.string(forKey: "request_token")!]
        guard let url = URL(string: "\(base_url)/authentication/token/validate_with_login?api_key=\(token)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else {
            return
        }
        print(parameters)
        request.httpBody = httpBody
        print(request)
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
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
    
    func logout(success: @escaping (_ response: Bool) -> (), failure: @escaping (_ error: String?) -> ()) {
        let params = ["session_id": UserDefaults.standard.string(forKey: "session") ?? ""]
        guard let url = URL(string: "\(base_url)/authentication/session?api_key=\(token)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject:params, options: []) else { return }
        request.httpBody = httpBody
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try JSONDecoder().decode(Session.self, from: data)
                print(response)
                success(response.success ?? false)
            } catch {
                failure(error.localizedDescription)
            }
        }
        task.resume()
    }
    
    func createSession(success: @escaping (_ response: Session) -> (), failure: @escaping (_ error: String?) -> ()) {
        guard let url = URL(string: "\(base_url)/authentication/session/new?api_key=\(token)") else { return }
        let parameteters = ["request_token": UserDefaults.standard.string(forKey: "request_token")!]
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameteters, options: []) else {
            return
        }
        request.httpBody = httpBody
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            do {
                let response = try JSONDecoder().decode(Session.self, from: data)
                print(response)
                success(response)
            } catch {
                failure(error.localizedDescription)
            }
        }
        task.resume()
    }
    
}
