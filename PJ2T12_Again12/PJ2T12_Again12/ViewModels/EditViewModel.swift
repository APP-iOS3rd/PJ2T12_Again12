//
//  EditViewModel.swift
//  PJ2T12_Again12
//
//  Created by kwon ji won on 12/11/23.
//

import Foundation
import Photos

class EditViewModel: ObservableObject {
    //앨범 권한을 물어보는데 기본값은 false
    @Published var albumPermissionGranted = false
    var authorizationCallback: (() -> Void)?

    //앨범 권한을 요청 
    func checkAlbumPermission() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            switch status {
            case .authorized:
                //Publishing changes from background threads is not allowed; make sure to publish values from the main thread (via operators like receive(on:)) on model updates.
                //UI관련 변수를 업데이트할 때에는 main 쓰레드에서 업데이트 될 수 있도록, await MainActor.run {}블록으로 감싸줘야한다.
                //-> DispatchQueue.main 을 대체하는 방식
                DispatchQueue.main.async {
                    self?.albumPermissionGranted = true
                    self?.authorizationCallback?()
                    
                }
                print("Album: 권한 허용")
            case .denied:
                print("Album: 권한 거부")
            case .restricted, .notDetermined:
                print("Album: 선택하지 않음")
            default:
                break
            }
        }
    }
}
