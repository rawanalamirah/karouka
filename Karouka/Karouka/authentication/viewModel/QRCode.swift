////
////  QRCode.swift
////  Karouka
////
////  Created by Rawan Alamirah on 09/12/2023.
////
//
//import SwiftUI
//import AVFoundation
//
//struct QRCodeScannerView: View {
//    @State private var isCameraAuthorized = false
//    @State private var scannedCode: String?
//
//    var body: some View {
//        ZStack {
//            if isCameraAuthorized {
//                if scannedCode == nil {
//                    ScannerView(onCodeScanned: { code in
//                        self.scannedCode = code
//                    })
//                } else {
//                    ScannedResultView(scannedCode: $scannedCode) {
//                        self.scannedCode = nil
//                    }
//                }
//            } else {
//                CameraPermissionView(isAuthorized: $isCameraAuthorized)
//            }
//        }
//    }
//}
//
//struct ScannerView: View {
//    var onCodeScanned: (String) -> Void
//
//    var body: some View {
//        VStack {
//            Text("Scan QR Code")
//                .font(.title)
//                .padding()
//            
//            Button("Start Scanning") {
//                onCodeScanned("Sample QR Code Data") // Simulated code scanning
//            }
//            .padding()
//        }
//    }
//}
//
//struct ScannedResultView: View {
//    @Binding var scannedCode: String?
//    var resumeScanning: () -> Void
//
//    var body: some View {
//        VStack {
//            Text("QR Code Scanned")
//                .font(.title)
//                .padding()
//
//            if let code = scannedCode {
//                Text(code)
//                    .font(.headline)
//                    .padding()
//            }
//
//            Button("Scan Again") {
//                self.scannedCode = nil
//                self.resumeScanning()
//            }
//            .padding()
//        }
//    }
//}
//
//struct CameraPermissionView: View {
//    @Binding var isAuthorized: Bool
//
//    var body: some View {
//        VStack {
//            Text("Camera Access Required")
//                .font(.title)
//                .padding()
//
//            Button("Allow Camera Access") {
//                AVCaptureDevice.requestAccess(for: .video) { granted in
//                    self.isAuthorized = granted
//                }
//            }
//            .padding()
//        }
//    }
//}
//
//@main
//struct QRCodeScannerApp: App {
//    var body: some Scene {
//        WindowGroup {
//            QRCodeScannerView()
//        }
//    }
//}
