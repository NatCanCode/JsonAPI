//
//  JokeView.swift
//  JsonAPI
//
//  Created by N N on 27/09/2022.
//

import SwiftUI

struct Joke: Decodable {
    let value: String
}

//Async Await method
func getRandomJoke() async throws -> String {
    guard let url = URL(string: "https://api.chucknorris.io/jokes/random")
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
    let decoded = try JSONDecoder().decode(Joke.self, from: data)
    let joke = decoded.value
    print("\(joke)")
    return joke }


struct JokeView: View {
    
    @State private var joke: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Spacer()
                Button {
                    Task {
                        joke = try await getRandomJoke()
                    }
                } label: {
                    HStack {
                        Text("Ready for a random joke?")
                        Image(systemName: "shuffle")
                    }
                    .foregroundColor(.white)
                    .font(.title3)
                    .padding()
                    .cornerRadius(30)
                    .overlay(RoundedRectangle(cornerRadius: 30))
                }
                .padding()
                Spacer()
                Text(joke)
                    .font(.title3)
                    .padding()
                Spacer()
            }
            .navigationTitle("Chuck Norris Jokes")
        }
    }
}

struct JokeView_Previews: PreviewProvider {
    static var previews: some View {
        JokeView()
    }
}
