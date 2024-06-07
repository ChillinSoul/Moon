//
//  EditClientView.swift
//  Moon
//
//  Created by Axel Bergiers on 07/06/2024.
//

import SwiftUI

struct EditClientView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var showImagePicker = false
    @State private var inputImage: UIImage?
    @State private var selectedSourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var client: Client
    var onSave: (Client) -> Void

    init(client: Client, onSave: @escaping (Client) -> Void) {
        self.onSave = onSave
        _client = State(initialValue: client)
    }

    var body: some View {
        Form {
            Section(header: Text("Client Information")) {
                TextField("Name", text: $client.name)
                TextField("First Name", text: Binding($client.firstName)!)
                TextField("Last Name", text: Binding($client.lastName)!)
                TextField("Email", text: Binding($client.email)!)
                TextField("Telephone", text: Binding($client.telephone)!)
                TextField("Zip Code", text: Binding($client.zipCode)!)
                TextField("Comments", text: Binding($client.comments)!)
            }

            Section {
                if let uiImage = inputImage {
                    Image(uiImage: uiImage)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                } else if let image = loadImage(fileName: client.imageFileName) {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(height: 200)
                } else {
                    Text("No image selected")
                }
                
                Button("Choose Photo") {
                    selectedSourceType = .photoLibrary
                    showImagePicker = true
                }
                .padding()
                
                Button("Take Photo") {
                    selectedSourceType = .camera
                    showImagePicker = true
                }
                .padding()
            }

            Section {
                Button("Save") {
                    if let uiImage = inputImage {
                        _ = saveImage(image: uiImage, fileName: client.imageFileName)
                    }
                    onSave(client)
                    presentationMode.wrappedValue.dismiss()
                }
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $inputImage, sourceType: selectedSourceType)
        }
    }
}
