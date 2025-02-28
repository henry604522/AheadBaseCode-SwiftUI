//
//  Deposit.swift
//  Ahead
//
//  Created by Henry MacLane on 10/10/24.
//

import SwiftUI
import MapKit
import Combine
import AVFoundation

struct Deposit: View {
    @State private var selectedTab: String = "Deposit"  // State to track the selected tab
    @State private var scrollViewProxy: ScrollViewProxy?  // Proxy to handle scroll actions
    @State private var isAtTop = true  // Track if user is at the top of the screen

    var body: some View {
        NavigationView {
            ScrollView {  // Ensure the entire view is scrollable
                ScrollViewReader { proxy in  // Enable scrolling and access to the scroll proxy
                    VStack(alignment: .leading) {
                        // Tabs Section
                        HStack {
                            // Deposit Tab
                            Button(action: {
                                withAnimation {
                                    selectedTab = "Deposit"
                                }
                            }) {
                                VStack {
                                    Text("Deposit")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                    if selectedTab == "Deposit" {
                                        Color.main.frame(height: 2)
                                            .padding(.top, 2)
                                    } else {
                                        Color.clear.frame(height: 2)
                                    }
                                }
                            }
                            Spacer()
                            
                            // Withdraw Tab
                            Button(action: {
                                withAnimation {
                                    selectedTab = "Withdraw"
                                    proxy.scrollTo("WithdrawSection", anchor: .top)  // Scroll to Withdraw section and anchor to top
                                }
                            }) {
                                VStack {
                                    Text("Withdraw")
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                    if selectedTab == "Withdraw" {
                                        Color.blue.frame(height: 2)
                                            .padding(.top, 2)
                                    } else {
                                        Color.clear.frame(height: 2)
                                    }
                                }
                            }
                            Spacer()
                            
                            // Pay Tab
                            Button(action: {
                                withAnimation {
                                    selectedTab = "Pay"  // Keep original behavior (no scrolling)
                                }
                            }) {
                                VStack {
                                    HStack(spacing: 4) {
                                        Text("Pay")
                                            .font(.subheadline)
                                            .foregroundColor(.white)
                                        Image(systemName: "qrcode")
                                            .foregroundColor(.white)
                                            .font(.caption)
                                    }
                                    if selectedTab == "Pay" {
                                        Color.blue.frame(height: 2)
                                            .padding(.top, 2)
                                    } else {
                                        Color.clear.frame(height: 2)
                                    }
                                }
                            }
                            .background(
                                NavigationLink(destination: QR().navigationBarTitle("QR Code", displayMode: .inline)) {
                                    EmptyView()
                                }
                                .opacity(0)
                            )
                        }
                        .padding(.horizontal)
                        .padding(.top, 100)  // Top padding for tabs section

                        Divider()  // Divider below the tabs

                        if selectedTab == "Deposit" {
                            // Deposit Section
                            VStack(spacing: 16) {
                                // ATM Button
                                NavigationLink(destination: AtmView()) {
                                    HStack(spacing: 16) {
                                        Image(systemName: "banknote")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.white)
                                            .background(Circle().fill(Color("MainColor")).frame(width: 40, height: 40))
                                        VStack(alignment: .leading) {
                                            Text("ATM")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text("Find an ATM near you")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .background(Color.clear)
                                }

                                // Deposit from Card Button
                                NavigationLink(destination: CardDepositView()) {
                                    HStack(spacing: 16) {
                                        Image(systemName: "creditcard")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.white)
                                            .background(Circle().fill(Color("MainColor")).frame(width: 40, height: 40))
                                        VStack(alignment: .leading) {
                                            Text("Deposit from card")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text("Deposit using another card")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .background(Color.clear)
                                }

                                // Bank Transfer Button (added back)
                                NavigationLink(destination: BankTransferView()) {
                                    HStack(spacing: 16) {
                                        Image(systemName: "arrow.left.arrow.right")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.white)
                                            .background(Circle().fill(Color("MainColor")).frame(width: 40, height: 40))
                                        VStack(alignment: .leading) {
                                            Text("Bank transfer")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text("Link your bank")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .background(Color.clear)
                                }

                                // E-Check Button (added back)
                                NavigationLink(destination: ECheckView()) {
                                    HStack(spacing: 16) {
                                        Image(systemName: "doc.text")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.white)
                                            .background(Circle().fill(Color("MainColor")).frame(width: 40, height: 40))
                                        VStack(alignment: .leading) {
                                            Text("E-Check")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text("Send e-check payments")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .background(Color.clear)
                                }
                            }
                            .padding(.horizontal)

                            // Divider below the Deposit section
                            Divider()
                                .padding(.top, 20)
                        } else if selectedTab == "Withdraw" {
                            // Withdraw Section (below the divider)
                            VStack(spacing: 16) {
                                // ATM Button for Withdraw
                                NavigationLink(destination: AtmView()) {
                                    HStack(spacing: 16) {
                                        Image(systemName: "banknote")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.white)
                                            .background(Circle().fill(Color("MainColor")).frame(width: 40, height: 40))
                                        VStack(alignment: .leading) {
                                            Text("ATM")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text("Find an ATM near you")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .background(Color.clear)
                                }

                                // Bank Transfer Button for Withdraw
                                NavigationLink(destination: BankTransferView()) {
                                    HStack(spacing: 16) {
                                        Image(systemName: "arrow.left.arrow.right")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 20, height: 20)
                                            .foregroundColor(.white)
                                            .background(Circle().fill(Color("MainColor")).frame(width: 40, height: 40))
                                        VStack(alignment: .leading) {
                                            Text("Bank transfer")
                                                .font(.headline)
                                                .foregroundColor(.white)
                                            Text("Link your bank")
                                                .font(.subheadline)
                                                .foregroundColor(.gray)
                                        }
                                        Spacer()
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.white)
                                    }
                                    .padding()
                                    .background(Color.clear)
                                }
                            }
                            .padding(.horizontal)
                            .padding(.bottom, 50)
                            .id("WithdrawSection")  // Add an ID for scrolling to this section
                        } else if selectedTab == "Pay" {
                            // Pay Section (QR Page)
                            ZStack {
                                Color.black
                                    .ignoresSafeArea()
                                QR()
                            }
                        }

                        // BottomInfoView (Added to the bottom with more padding)
                        BottomInfoView()
                            .padding(.top, 50)  // Increased padding at the top
                    }
                    .background(Color.black)  // Make the internal background black
                    .onAppear {
                        self.scrollViewProxy = proxy  // Capture the proxy
                    }
                }
            }
            .background(Color.black)  // Background for the entire scrollable view (ensures consistency at top and bottom)
            .ignoresSafeArea(.all)
            .navigationTitle("")
            .navigationBarHidden(true)  // Hide default navigation bar
        }
    }
}







struct AtmView: View {
    var body: some View {
        VStack {
            Text("Find an ATM near you")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.white)
                .padding()
            MapView()
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding()
        }
        .background(Color(.black))
    }
}

struct MapView: UIViewRepresentable {
    func makeUIView(context: Context) -> MKMapView {
        return MKMapView(frame: .zero)
    }
    
    func updateUIView(_ view: MKMapView, context: Context) {
        // Configure map view here
    }
}

struct CardDepositView: View {
    @State private var cardNumber = ""
    @State private var cardName = ""
    @State private var expirationDate = ""
    @State private var securityCode = ""
    @State private var selectedPaymentMethod = "Credit Card"
    let paymentMethods = ["Card", "Apple Pay", "PayPal"]

    var body: some View {
        VStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    Text("Deposit with Card")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
                    Text("All transactions are secure and encrypted. Funds will be available instantly")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    VStack(spacing: 20) {
                        HStack {
                            ForEach(paymentMethods, id: \.self) { method in
                                Button(action: {
                                    selectedPaymentMethod = method
                                }) {
                                    Text(method)
                                        .font(.headline)
                                        .foregroundColor(selectedPaymentMethod == method ? .black : .white)
                                        .lineLimit(1)
                                        .padding()
                                        .frame(maxWidth: .infinity)
                                        .background(selectedPaymentMethod == method ? Color("MainColor") : Color("BLACK2"))
                                        .cornerRadius(25)
                                }
                            }
                        }
                    }

                    
                    if selectedPaymentMethod == "Card" {
                        VStack(alignment: .leading) {
                            HStack {
                                Image(systemName: "creditcard.fill")
                                    .foregroundColor(.white)
                                Text("Credit/Debit Card")
                                    .font(.subheadline)
                                    .foregroundColor(.white)
                                Spacer()
                                Image(systemName: "lock.fill")
                                    .foregroundColor(.white)
                            }
                            .padding(.vertical)
                            
                            CustomTextField(placeholder: Text("Card number").foregroundStyle(Color.gray), text: $cardNumber)
                                .keyboardType(.numberPad)
                                .padding()
                                .background(Color("BLACK2"))
                                .cornerRadius(15)
                                .foregroundColor(.white)
                            
                            CustomTextField(placeholder: Text( "Name on card").foregroundStyle(Color.gray), text: $cardName)
                                .padding()
                                .background(Color("BLACK2"))
                                .cornerRadius(15)
                                .foregroundColor(.white)
                            
                            CustomTextField(placeholder: Text("Expiration date (MM / YY)").foregroundStyle(Color.gray) , text: $expirationDate)
                                .keyboardType(.numberPad)
                                .padding()
                                .background(Color("BLACK2"))
                                .cornerRadius(15)
                                .foregroundColor(.white)
                            
                            CustomTextField(placeholder: Text("CVV").foregroundStyle(Color.gray), text: $securityCode)
                                .keyboardType(.numberPad)
                                .padding()
                                .background(Color("BLACK2"))
                                .cornerRadius(15)
                                .foregroundColor(.white)
                        }
                    } else if selectedPaymentMethod == "PayPal" {
                        HStack {
                            Image("PayPal") // Paypal Logo
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150)
                            
                        }
                    } else if selectedPaymentMethod == "Apple Pay" {
                        HStack {
                            Image("ApplePay") // Apple Pay Logo
                                .resizable()
                                .scaledToFit()
                                .frame(width: 150)
                        }
                    }
                }
                .padding()
            }
            
            Button(action: {
                // Handle button action
            }) {
                Text(selectedPaymentMethod == "Card" ? "Deposit" : "Continue")
                    .font(.headline)
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color("MainColor"))
                    .cornerRadius(25)
                    .padding(.horizontal)
            }
            .padding(.bottom, 20)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

struct CustomTextFieldDeposit: View {
    var placeholder: Text
    @Binding var text: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                placeholder
                    .padding(.leading, 8)
            }
            TextField("", text: $text)
                .foregroundColor(.white)
                .padding(10)
        }
    }
}

struct ECheckView: View {
    @StateObject private var cameraViewModel = CameraViewModel()
    
    var body: some View {
        ZStack {
            CameraViewECheck(cameraViewModel: cameraViewModel)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                
                HStack {
                    Spacer()
                    
                    // Undo button
                    Button(action: {
                        cameraViewModel.unfreeze()
                    }) {
                        Image(systemName: "arrow.uturn.left.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.red)
                    }
                    .padding()
                }
                
                HStack {
                    Spacer()
                    
                    // Camera button
                    Button(action: {
                        cameraViewModel.freeze()
                    }) {
                        Image(systemName: "camera.circle.fill")
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                            .background(Color.white)
                            .clipShape(Circle())
                    }
                    .padding()
                }
            }
        }
        .onAppear {
            cameraViewModel.checkPermissions()
        }
    }
}

// Camera View
struct CameraViewECheck: UIViewControllerRepresentable {
    @ObservedObject var cameraViewModel: CameraViewModel
    
    func makeUIViewController(context: Context) -> UIViewController {
        let controller = CameraViewController()
        controller.cameraViewModel = cameraViewModel
        return controller
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
    }
}

// Camera View Controller
class CameraViewController: UIViewController {
    var cameraViewModel: CameraViewModel?
    private var captureSession: AVCaptureSession?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var videoOutput: AVCaptureVideoDataOutput?
    private var capturedImage: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCamera()
    }
    
    private func setupCamera() {
        captureSession = AVCaptureSession()
        captureSession?.sessionPreset = .photo
        
        guard let captureSession = captureSession else { return }
        
        guard let videoCaptureDevice = AVCaptureDevice.default(for: .video) else { return }
        let videoInput: AVCaptureDeviceInput
        
        do {
            videoInput = try AVCaptureDeviceInput(device: videoCaptureDevice)
        } catch {
            return
        }
        
        if (captureSession.canAddInput(videoInput)) {
            captureSession.addInput(videoInput)
        } else {
            return
        }
        
        previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        previewLayer?.frame = view.layer.bounds
        previewLayer?.videoGravity = .resizeAspectFill
        view.layer.addSublayer(previewLayer!)
        
        videoOutput = AVCaptureVideoDataOutput()
        if (captureSession.canAddOutput(videoOutput!)) {
            captureSession.addOutput(videoOutput!)
            videoOutput?.setSampleBufferDelegate(self, queue: DispatchQueue(label: "videoQueue"))
        }
        
        captureSession.startRunning()
    }
}

extension CameraViewController: AVCaptureVideoDataOutputSampleBufferDelegate {
    func captureOutput(_ output: AVCaptureOutput, didOutput sampleBuffer: CMSampleBuffer, from connection: AVCaptureConnection) {
        if cameraViewModel?.isFrozen == true {
            return
        }
        
        guard let pixelBuffer = CMSampleBufferGetImageBuffer(sampleBuffer) else { return }
        let ciImage = CIImage(cvPixelBuffer: pixelBuffer)
        let image = UIImage(ciImage: ciImage)
        
        DispatchQueue.main.async {
            self.cameraViewModel?.capturedImage = image
        }
    }
}

// Camera ViewModel
class CameraViewModel: ObservableObject {
    @Published var isFrozen = false
    @Published var capturedImage: UIImage?
    
    func checkPermissions() {
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            break
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if !granted {
                    // Handle the case where permission is not granted
                }
            }
        default:
            // Handle the case where permission is denied
            break
        }
    }
    
    func freeze() {
        isFrozen = true
    }
    
    func unfreeze() {
        isFrozen = false
        capturedImage = nil
    }
}


struct BankTransferView: View {
    var body: some View {
        ZStack {
        Color.black.ignoresSafeArea()
            
            VStack {
                Text("Bank Transfer")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.white)
                    .padding()
                Button(action: {
                    // Link bank action
                }) {
                    Text("Link Bank")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("MainColor"))
                        .foregroundColor(.white)
                        .cornerRadius(25)
                }
                .padding()
            }
            .background(Color(.black)).ignoresSafeArea() // Sets background to systemGray6
            .edgesIgnoringSafeArea(.all) // Optional, if you want the background to extend to safe areas
        }
    }
}

#Preview {
    Deposit()
}


