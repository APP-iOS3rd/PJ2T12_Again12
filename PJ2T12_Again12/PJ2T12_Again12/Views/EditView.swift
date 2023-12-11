//
//  EditView.swift
//  PJ2T12_Again12
//
//  Created by kwon ji won on 12/8/23.
//

import SwiftUI
import Foundation
import Photos

struct EditView: View {
    @StateObject private var viewModel = EditViewModel()
    @State private var openPhoto = false
    @State private var image = UIImage()
    @State private var userText: String = ""
    @State private var checkSave = false
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HStack(spacing: 20) {
                        Image(systemName: "airplane")
                            .font(.title2)
                        Text("아침 일찍 일어나기")
                            .font(.system(size: 25))
                            .bold()
                    }
                    .frame(width: 340, height: 60)
                    HStack {
                        Button(action: {
                            viewModel.checkAlbumPermission()
                            if viewModel.albumPermissionGranted {
                                self.openPhoto = true  
                            }
                        }) {
                            ZStack {
                                RoundedRectangle(cornerRadius: 12)
                                    .frame(width: 90, height: 90)
                                    .foregroundColor(Color(red: 0xD9 / 255.0, green: 0xD9 / 255.0, blue: 0xD9 / 255.0))
                                Image(systemName: "camera.circle")
                                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                    .foregroundColor(.white)
                            }
                            .padding()
                        }
                        .sheet(isPresented: $openPhoto) {
                            ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                        }
                        Spacer()
                    }
                    .padding()
                    
                    if image.size != CGSize.zero {
                        Image(uiImage: image)
                            .resizable()
                            .frame(width: 320, height: 320)
                            .scaledToFit()
                    }
                    
                    TextEditor(text: $userText)
                        .frame(width: 320, height: 250)
                        .lineSpacing(8)
                        .keyboardType(.default)
                        .border(Color.gray)
                        .onTapGesture {
                        }
                        .overlay(
                            Text("할 일을 마치며 느낀점을 적어주세요")
                                .foregroundColor(.gray)
                                .padding(EdgeInsets(top: 8, leading: 4, bottom: 0, trailing: 4))
                                .opacity(userText.isEmpty ? 1 : 0)
                        )
                    Spacer()
                    
                    Button(action: {
                     checkSave = true
                    }) {
                        Text("달성 완료")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 170, height: 50)
                            .background(Color.blue)
                            .cornerRadius(10)
                    }
                }
                .padding()
                }
            .onTapGesture {
                hideKeyboard()
            }
        }
        
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    
    var sourceType: UIImagePickerController.SourceType = .photoLibrary
    
    @Binding var selectedImage: UIImage
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = false
        imagePicker.sourceType = sourceType
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        var parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}


#Preview {
    EditView()
}


