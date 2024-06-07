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
                TextField("First Name", text: Binding(
                    get: { client.firstName ?? "" },
                    set: { client.firstName = $0.isEmpty ? nil : $0 }
                ))
                TextField("Last Name", text: Binding(
                    get: { client.lastName ?? "" },
                    set: { client.lastName = $0.isEmpty ? nil : $0 }
                ))
                TextField("Email", text: Binding(
                    get: { client.email ?? "" },
                    set: { client.email = $0.isEmpty ? nil : $0 }
                ))
                TextField("Telephone", text: Binding(
                    get: { client.telephone ?? "" },
                    set: { client.telephone = $0.isEmpty ? nil : $0 }
                ))
                TextField("Street", text: Binding(
                    get: { client.street ?? "" },
                    set: { client.street = $0.isEmpty ? nil : $0 }
                ))
                TextField("Zip Code", text: Binding(
                    get: { client.zipCode ?? "" },
                    set: { client.zipCode = $0.isEmpty ? nil : $0 }
                ))
                TextField("Country", text: Binding(
                    get: { client.country ?? "" },
                    set: { client.country = $0.isEmpty ? nil : $0 }
                ))
                TextField("Comments", text: Binding(
                    get: { client.comments ?? "" },
                    set: { client.comments = $0.isEmpty ? nil : $0 }
                ))
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

#Preview {
    NavigationView {
        EditClientView(client: DummyClients[0], onSave: { _ in })
    }
}
