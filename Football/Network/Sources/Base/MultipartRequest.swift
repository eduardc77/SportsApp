
import Foundation

public struct MultipartRequest {

    private var data =  NSMutableData()

    private let boundary: String = UUID().uuidString
    private let separator: String = "\r\n"

    private var topBoundary: String {
        return "--\(boundary)"
    }

    private var endBoundary: String {
        return "--\(boundary)--"
    }

    private func contentDisposition(_ name: String, fileName: String?) -> String {
        var disposition = "form-data; name=\"\(name)\""
        if let fileName = fileName { disposition += "; filename=\"\(fileName)\"" }
        return "Content-Disposition: " + disposition
    }

    public var headerValue: String {
        "multipart/form-data; boundary=\(boundary)"
    }

    public var httpBody: Data {
        let bodyData = data
        bodyData.append("--\(boundary)--")
        return bodyData as Data
    }

    public var length: UInt64 {
        return UInt64(httpBody.count)
    }

    public func append(fileString: String, withName name: String) {
        data.append(topBoundary)
        data.append(separator)
        data.append(contentDisposition(name, fileName: nil))
        data.append(separator)
        data.append(separator)
        data.append(fileString)
        data.append(separator)
    }

    public func append(fileData: Data, withName name: String, fileName: String?, mimeType: FileType?) {
        data.append(topBoundary)
        data.append(separator)
        data.append(contentDisposition(name, fileName: fileName))
        data.append(separator)
        if let mimeType = mimeType {
            data.append("Content-Type: \(mimeType.rawValue)" + separator)
        }
        data.append(separator)
        data.append(fileData)
        data.append(separator)
    }

    public func append(fileURL: URL, withName name: String) {
        guard let fileData = try? Data(contentsOf: fileURL) else {
            return
        }
        let fileName = fileURL.lastPathComponent
        let pathExtension = fileURL.pathExtension
        let mimeType = mimeType(for: pathExtension)
        
        data.append(topBoundary)
        data.append(separator)
        data.append(contentDisposition(name, fileName: fileName))
        data.append(separator)
        data.append("Content-Type: \(mimeType)" + separator)
        data.append(separator)
        data.append(fileData)
        data.append(separator)
    }

}

import UniformTypeIdentifiers
import MobileCoreServices

extension MultipartRequest {

    private func mimeType(for pathExtension: String) -> String {
        if #available(iOS 14, macOS 11, tvOS 14, watchOS 7, *) {
            return UTType(filenameExtension: pathExtension)?.preferredMIMEType ?? "application/octet-stream"
        } else {
            if
                let id = UTTypeCreatePreferredIdentifierForTag(
                    kUTTagClassFilenameExtension,
                    pathExtension as CFString,
                    nil
                )?.takeRetainedValue(),
                let contentType = UTTypeCopyPreferredTagWithClass(id, kUTTagClassMIMEType)?.takeRetainedValue() {
                return contentType as String
            }

            return "application/octet-stream"
        }
    }
}

public extension NSMutableData {
    func append(_ string: String, encoding: String.Encoding = .utf8) {
        if let data = string.data(using: encoding) {
            self.append(data)
        }
    }
}

public enum FileType: String {
    /// image/webm, audio/ogg, audio/mpeg, audio/mp4, video/mpeg, video/quicktime, video/webm
    /// application/msword, application/excel, application/powerpoint, application/x-zip
    case jpeg = "image/jpeg"
    case png = "image/png"
    case gif = "image/gif"
    case tiff = "image/tiff"
    case bmp = "image/bmp"
    case quickTime = "video/quicktime"
    case mov = "video/mov"
    case mp4 = "video/mp4"
    case pdf = "application/pdf"
    case vnd = "application/vnd"
    case plainText = "text/plain"
    case anyBinary = "application/octet-stream"
}
