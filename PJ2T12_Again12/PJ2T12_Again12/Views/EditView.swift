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
    @State private var showAlert = false
    @State private var goToHome = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(hex: 0xFFFAE1)
                    .ignoresSafeArea()
                ScrollView {
                    VStack() {
                        HStack(alignment: .center, spacing: 20) {
                            Spacer()
                            Spacer()
                            Image(systemName: "airplane")
                                .font(.title2)
                            Text("아침 일찍 일어나기")
                                .font(.system(size: 25))
                                .bold()
                                .lineLimit(1)
                                .minimumScaleFactor(0.5)
                                .foregroundColor(Color(hex: 0xB76300))
                            Spacer()
                            Button(action: {
                                showAlert.toggle()
                            }) {
                                Image(systemName: "trash")
                                    .font(.title2)
                                    .opacity(checkSave ? 1.0 : 0 )
                            }
                            .alert(isPresented: $showAlert) {
                                Alert(title: Text("삭제하시겠습니까?"),
                                      message: nil,
                                      primaryButton: .cancel(),
                                      secondaryButton: .destructive(Text("삭제")) {
                                    //삭제하기 버튼이 눌렸을 때 할 동작추가
                                    //홈뷰에 status를 없앨껀지, 그 항목 자체를 삭제할껀지
                                    goToHome.toggle()
                                }
                                )
                            }
                            .background(NavigationLink("", destination: HomeView(), isActive: $goToHome))
                            Spacer()
                        }
                        .padding(.bottom, 20)
                        
                        HStack {
                            Button(action: {
                                viewModel.checkAlbumPermission()
                                if viewModel.albumPermissionGranted {
                                    self.openPhoto = true
                                }
                            }) {
                                ZStack {
                                    if !checkSave {
                                        RoundedRectangle(cornerRadius: 12)
                                            .frame(width: 90, height: 90)
                                            .foregroundColor(Color(red: 0xD9 / 255.0, green: 0xD9 / 255.0, blue: 0xD9 / 255.0))
                                        Image(systemName: "camera.circle")
                                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(.white)
                                    }
                                }
                            }
                            .sheet(isPresented: $openPhoto) {
                                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$image)
                            }
                            .padding()
                            Spacer()
                                
                        }
                        if image.size != CGSize.zero {
                            Image(uiImage: image)
                                .resizable()
                                .frame(width: 310, height: 310)
                                .scaledToFit()
                                .padding(.top,10)
                                .padding(.bottom, 20)
                        }
                        
                        if !checkSave {
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
                                        .opacity(userText.isEmpty ? 1 : 0)
                                )
                        } else {
                            Text(userText)
                                .frame(width: 320, height: 250)
                                .lineSpacing(8)
                                .background(Color.white)

                        }
                        
                        Button(action: {
                            checkSave.toggle()
                        }) {
                            Text(checkSave ? "수정하기" : "작성완료")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 170, height: 50)
                                .background(Color.blue)
                                .cornerRadius(10)
                        }
                        .padding(.top, 60)
                    }
                    .padding()
                }
                .onTapGesture {
                    hideKeyboard()
                }
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


