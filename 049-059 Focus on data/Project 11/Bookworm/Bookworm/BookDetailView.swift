//
//  BookDetailView.swift
//  Bookworm
//
//  Created by Michael Brünen on 25.06.20.
//  Copyright © 2020 Michael Brünen. All rights reserved.
//

import SwiftUI
import CoreData

struct BookDetailView: View {
    @Environment(\.managedObjectContext) var moc
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    // Wrap up - Challenge 3 - Add a date to the book entity
    var dateString: String {
        if let date = book.date {
            return date.formatted(date: .abbreviated, time: .omitted)
        } else {
            return "Unknown"
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                ZStack(alignment: .bottomTrailing) {
                    Image(self.book.genre ?? "Fantasy")
                        .frame(maxWidth: geometry.size.width)
                    
                    Text(self.book.genre?.uppercased() ?? "FANTASY")
                        .font(.caption)
                        .fontWeight(.black)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.black.opacity(0.75))
                        .clipShape(Capsule())
                        .offset(x: -5, y: -5)
                }
                
                Text(self.book.author ?? "Unknown Author")
                    .font(.title)
                    .foregroundColor(.secondary)
                
                // Wrap up - Challenge 3 - Add a date to the book entity
                Text("Reviewed on \(self.dateString)")
                    .font(.footnote)
                
                Text(self.book.review ?? "No review")
                    .padding()
                
                // using .constant so the rating can't be changed in the detailView
                RatingView(rating: .constant(Int(self.book.rating)))
                    .font(.largeTitle)
                
                Spacer()
            }
        }
        .navigationBarTitle(Text(book.title ?? "Unknown Book"), displayMode: .inline)
        .navigationBarItems(trailing: Button(action: {
            self.showingDeleteAlert = true
        }) {
            Image(systemName: "trash")
        })
        .alert(isPresented: $showingDeleteAlert) {
            Alert(title: Text("Delete book"),
                  message: Text("Are you sure you want to delete this book?"),
                  primaryButton: .destructive(Text("Delete")) {
                    self.deleteBook()
                },
                  secondaryButton: .cancel()
            )
        }
    }
    
    func deleteBook() {
        moc.delete(book)
        try? self.moc.save()
        presentationMode.wrappedValue.dismiss()
    }
}

struct BookDetailView_Previews: PreviewProvider {
    static let moc = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
    
    static var previews: some View {
        let book = Book(context: moc)
        book.title = "Test book"
        book.author = "Test author"
        book.genre = "Fantasy"
        book.rating = 4
        book.review = "This was a great book; I really enjoyed it."
        
        return NavigationView {
            BookDetailView(book: book)
        }
    }
}
