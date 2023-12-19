//
//  EditView.swift
//  PJ2T12_Again12
//
//  Created by kwon ji won on 12/8/23.
//

import SwiftUI
import Foundation
import Photos
import WidgetKit

struct EditView: View {
//    @StateObject private var viewModel = EditViewModel()
    @ObservedObject var viewModel: EditViewModel
    @AppStorage("firstWantTodoIt") var firstWantTodoIt: Int = 0
    @Environment(\.dismiss) var dismiss

    init(todo: Todo?) {
        print("Initalize")
        viewModel = EditViewModel(todo: todo)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.BackgroundYellow
                    .ignoresSafeArea()
                ScrollView {
                    VStack() {
                        HStack(alignment: .center, spacing: 20) {
                            Label(viewModel.todo?.title ?? "Todori", systemImage: viewModel.todo?.image ??  "airplane")
                                .font(.system(size: 25))
                                .bold()
                                .foregroundColor(
                                    (viewModel.todo?.isTodo ?? false) ? Color.TodoNoTextBrown : Color.WanttoNoTextBrown)
                        }
                        .padding(.bottom, 20)
                        
                        HStack {
                            Button(action: {
                                viewModel.checkAlbumPermission()
                                if viewModel.albumPermissionGranted {
                                    viewModel.authorizationCallback = {
                                    }
                                }
                            }) {
                                ZStack {
                                    if !viewModel.checkSave {
                                        RoundedRectangle(cornerRadius: 12)
                                            .strokeBorder(Color.DefaultBlack, lineWidth: 1)
                                            .frame(width: 90, height: 90)

                                        Image(systemName: "camera.circle")
                                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(Color.CameraGray)
                                    }
                                }
                            }
                            .sheet(isPresented: $viewModel.albumPermissionGranted) {
                                ImagePicker(sourceType: .photoLibrary, selectedImage: self.$viewModel.image)
                            }
                            .padding()
                            Spacer()
                                
                        }
                        if viewModel.image.size != CGSize.zero {
                            Image(uiImage: viewModel.image)
                                .resizable()
                                .frame(width: 310, height: 310)
                                .scaledToFit()
                                .padding(.top,10)
                                .padding(.bottom, 20)
                        }
                        
                        if !viewModel.checkSave {
                            TextEditor(text: $viewModel.userText)
                                .frame(width: 320, height: 250)
                                .lineSpacing(8)
                                .keyboardType(.default)
                                .border(Color.gray)
                                .onTapGesture {
                                }
                                .overlay(
                                    Text("할 일을 마치며 느낀점을 적어주세요")
                                        .font(.Hel15Bold)
                                        .foregroundColor(Color.TextDefaultGray)
                                        .opacity(viewModel.userText.isEmpty ? 1 : 0)
                                )
                        } else {
                            Text(viewModel.userText)
                                .font(.Hel15Bold)
                                .frame(maxWidth: 320, minHeight: 250)
                                .lineSpacing(8)
                                .foregroundColor(Color.TextDefaultGray)
                                .background(Color.white)
                                .minimumScaleFactor(0.5)

                        }
                        
                        Button(action: {
                            viewModel.updateTodo()
                            firstWantTodoIt += 1
                            WidgetCenter.shared.reloadAllTimelines()
                        }) {
                            Text(viewModel.checkSave ? "수정하기" : "작성완료")
                                .font(.Hel17Bold)
                                .foregroundColor(.white)
                                .padding()
                                .frame(width: 170, height: 50)
                                .background(Color.TodoButtonBrown)
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
            .toolbar {
                Button {
                    viewModel.showAlert.toggle()
                } label: {
                    Image(systemName: "trash")
                }
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(title: Text("삭제하시겠습니까?"),
                      message: nil,
                      primaryButton: .cancel(),
                      secondaryButton: .destructive(Text("삭제")) {
                    viewModel.deleteTodo()
                    WidgetCenter.shared.reloadAllTimelines()
                    dismiss()
                }
                )
            }
        }
        .accentColor(Color.DefaultBlack)
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


//#Preview {
//    NavigationView {
//        EditView(todoId: UUID())
//    }
//}
//

