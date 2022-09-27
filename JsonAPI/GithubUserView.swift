//
//  GithubUserView.swift
//  JsonAPI
//
//  Created by N N on 27/09/2022.
//

import SwiftUI

struct User: Identifiable, Decodable {
    let login: String
    let id: Int
    let repositories: Int
    let avatarURL: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case id
        case repositories = "public_repos"
        case avatarURL = "avatar_url"
    }
}

//Async Await method
func getUser(username: String) async throws -> User {
    guard let url = URL(string: "https://api.github.com/users/\(username)")
    else {
        fatalError("Missing URL")
    }
    var urlRequest = URLRequest(url: url)
    urlRequest.httpMethod = "GET"
    let (data, response) = try await URLSession.shared.data(for: urlRequest)
    guard (response as? HTTPURLResponse)?.statusCode == 200
    else {
        fatalError("Error while fetching data")
    }
    let decoded = try JSONDecoder().decode(User.self, from: data)
   return decoded
}


struct GithubUserView: View {
    
    @State var user = User(login: "", id: 0, repositories: 0, avatarURL: "")
    
    @State private var usernameToSearch = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Button {
                    Task {
                        user = try await getUser(username: usernameToSearch)
                    }
                    
                } label: {
                    Text("Search user")
                }
                .searchable(text: $usernameToSearch, placement:.navigationBarDrawer(displayMode: .always))
                .foregroundColor(.accentColor)
                Spacer()
//                Text("Helen")
                Text(user.login)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
//                Text(" public repositories")
                Text("\(user.repositories) public repositories")
//                Image("Helen")
                AsyncImage(url: URL(string: "\(user.avatarURL)"))
//                    .scaledToFit()
                    .padding()
                Spacer()
            }
            .navigationTitle("GitHub Users")
            //            .font(.title3)
            //            .foregroundColor(.gray)
            //            .fontWeight(.bold)
            //            .padding()
            //                    .cornerRadius(30)
            //                    .border(.gray)
        }
    }
}



struct GithubUserView_Previews: PreviewProvider {
    static var previews: some View {
        GithubUserView()
    }
}
