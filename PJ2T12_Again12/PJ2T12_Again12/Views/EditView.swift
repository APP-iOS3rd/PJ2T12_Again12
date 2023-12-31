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
    @StateObject private var viewModel = EditViewModel()
    @ObservedObject var homeVM = HomeViewModel()

    @State private var image = UIImage()
    @State private var userText: String = ""
    @State private var checkSave = false
    @State private var showAlert = false
    @AppStorage("firstWantTodoIt") var firstWantTodoIt: Int = 0
    
    @FetchRequest(sortDescriptors: []) var selectedTodo: FetchedResults<Todo>
    @Environment(\.dismiss) var dismiss
    @Environment(\.managedObjectContext) var moc
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)], predicate: NSPredicate(format: "isTodo == true")) var todoList: FetchedResults<Todo>
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)], predicate: NSPredicate(format: "isTodo == false")) var wantTodoList: FetchedResults<Todo>

    init(todoId: UUID, homeVM: HomeViewModel) {
        print("Initalize")
        _selectedTodo = FetchRequest(sortDescriptors: [], predicate: NSPredicate(format: "id == %@", todoId as CVarArg))
        self.homeVM = homeVM
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.BackgroundYellow
                    .ignoresSafeArea()
                ScrollView {
                    VStack() {
                        HStack(alignment: .center, spacing: 20) {
                            Label(selectedTodo.first?.title ?? "Todori", systemImage: selectedTodo.first?.image ??  "airplane")
                                .font(.system(size: 25))
                                .bold()
                                .foregroundColor(homeVM.isTodo ? Color.TodoNoTextBrown : Color.WanttoNoTextBrown)
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
                                    if !checkSave {
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
                                        .font(.Hel15Bold)
                                        .foregroundColor(Color.TextDefaultGray)
                                        .opacity(userText.isEmpty ? 1 : 0)
                                )
                        } else {
                            Text(userText)
                                .font(.Hel15Bold)
                                .frame(maxWidth: 320, minHeight: 250)
                                .lineSpacing(8)
                                .foregroundColor(Color.TextDefaultGray)
                                .background(Color.white)
                                .minimumScaleFactor(0.5)

                        }
                        
                        Button(action: {
                            if let selectedTodo = selectedTodo.first {
                                selectedTodo.review = userText
                                selectedTodo.isSaved.toggle()
                                selectedTodo.status.toggle()
                                if let imageData = image.pngData() {
                                    selectedTodo.reviewImage = imageData
                                }
                            }
                            try? moc.save()
                            firstWantTodoIt += 1
                            print(firstWantTodoIt)
                            checkSave.toggle()
                            WidgetCenter.shared.reloadAllTimelines()
                        }) {
                            Text(checkSave ? "수정하기" : "작성완료")
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
                .onAppear {
                    if let selectedTodo = selectedTodo.first {
                        userText = selectedTodo.wrappedReview
                        checkSave = selectedTodo.isSaved
                        if let imageData = selectedTodo.reviewImage {
                            image = UIImage(data: imageData) ?? UIImage(systemName: "heart")!
                        }
                    }
                }
            }
            .toolbar {
                Button {
                    showAlert.toggle()
                } label: {
                    Image(systemName: "trash")
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(title: Text("삭제하시겠습니까?"),
                      message: nil,
                      primaryButton: .cancel(),
                      secondaryButton: .destructive(Text("삭제")) {
                    for todo in selectedTodo {
                        moc.delete(todo)
                        WidgetCenter.shared.reloadAllTimelines()
                    }
                    try? moc.save()
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

