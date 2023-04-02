

// The fetchData function retrieves cart data for a given user and passes it to a completion handler.
static func fetchData(userId: Int, completion: @escaping (Cart?) -> Void) {
    // Create a URL string based on the user's ID
    let urlString = "https://fakestoreapi.com/carts/\(userId)"

    // Check if the URL string is valid and convert it into a URL object
    guard let url = URL(string: urlString) else {
        print("Invalid URL")
        completion(nil)
        return
    }

    // Create a URLSession data task with the URL
    URLSession.shared.dataTask(with: url) { data, response, error in
        // Check if there's any data returned from the URLSession data task
        if let data = data {
            // Create a JSON decoder
            let decoder = JSONDecoder()
            do {
                // Try to decode the data into a Cart object
                let fetchedData = try decoder.decode(Cart.self, from: data)
                print("Fetched cart data: \(fetchedData)")
                // Pass the decoded data to the completion handler
                completion(fetchedData)
            } catch {
                // If there's an error decoding the data, print the error and pass nil to the completion handler
                print("Error decoding data: \(error)")
                completion(nil)
            }
        } else {
            // If there's an error fetching the data or if there's no data, print the error and pass nil to the completion handler
            print("Error fetching data: \(error?.localizedDescription ?? "Unknown error")")
            completion(nil)
        }
    }.resume() // Start the URLSession data task
}
