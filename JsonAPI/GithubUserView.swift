//
//  GithubUserView.swift
//  JsonAPI
//
//  Created by N N on 27/09/2022.
//

import SwiftUI

struct User: Decodable {
    let value: String
}

//Async Await method
func getRandomUser() async throws -> String {
    guard let url = URL(string: "https://api.github.com/user")
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
    let user = decoded.value
    print("\(user)")
    return user }


struct GithubUserView: View {
    
    @State var user: String = ""
    //    @State var name: String = ""
    //    //    @State var repositories: Int
    //    @State var image: String = ""
    
    //    @Binding var user: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Form {
//                    Task {
//                        user = try await getRandomUser()
//                    }
                    TextField("", text: $user, prompt: Text("Type a username"))
                }
                .foregroundColor(.accentColor)
                //                    Spacer()
                Text("Helen")
                //                Text(userName)
                    .font(.title)
                    .fontWeight(.semibold)
                    .padding()
                Text(" public repositories")
                //                Text("\(repositories) public repositories")
                Image("Helen")
                    .resizable()
                    .scaledToFit()
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
