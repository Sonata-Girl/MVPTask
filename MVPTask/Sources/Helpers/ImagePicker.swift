// ImagePicker.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

/// Открытые камеры и галереи пользователя
final class ImagePicker: NSObject, UINavigationControllerDelegate {
    var imagePickerController: UIImagePickerController?
    var completionHandler: ((UIImage) -> ())?

    func showImagePicker(in viewController: UIViewController, completion: ((UIImage) -> ())?) {
        completionHandler = completion
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        guard let imagePickerController else { return }
        viewController.present(imagePickerController, animated: true)
    }
}

// MARK: - UIImagePickerControllerDelegate

/// ImagePicker + UIImagePickerControllerDelegate
extension ImagePicker: UIImagePickerControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]
    ) {
        if let image = info[.originalImage] as? UIImage {
            completionHandler?(image)
            picker.dismiss(animated: true)
        }
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
