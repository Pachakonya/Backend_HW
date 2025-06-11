import Foundation

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []
    
    let baseURL = "http://127.0.0.1:8000/posts/"  
    
    func fetchPosts() {
        guard let url = URL(string: baseURL) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                if let decoded = try? JSONDecoder().decode([Post].self, from: data) {
                    DispatchQueue.main.async {
                        self.posts = decoded
                    }
                }
            } else {
                print("Fetch error:", error ?? "Unknown")
            }
        }.resume()
    }

    func createPost(title: String, content: String) {
        guard let url = URL(string: baseURL) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let newPost = Post(id: nil, title: title, content: content)
        guard let jsonData = try? JSONEncoder().encode(newPost) else { return }
        request.httpBody = jsonData
        
        URLSession.shared.dataTask(with: request) { _, _, error in
            if error == nil {
                DispatchQueue.main.async {
                    self.fetchPosts()
                }
            } else {
                print("Post error:", error ?? "Unknown")
            }
        }.resume()
    }
}
