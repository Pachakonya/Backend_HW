import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = PostViewModel()
    @State private var title = ""
    @State private var content = ""

    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("New Post")) {
                        TextField("Title", text: $title)
                        TextField("Content", text: $content)
                        Button("Submit") {
                            viewModel.createPost(title: title, content: content)
                            title = ""
                            content = ""
                        }
                    }
                }
                List(viewModel.posts) { post in
                    VStack(alignment: .leading) {
                        Text(post.title).font(.headline)
                        Text(post.content).font(.subheadline)
                    }
                }
            }
            .navigationTitle("FastAPI Posts")
            .onAppear {
                viewModel.fetchPosts()
            }
        }
    }
}
