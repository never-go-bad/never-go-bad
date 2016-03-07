//
//  BarcodeDetectorViewController.swift
//  APItests
//
//  Created by Andre Oriani on 3/5/16.
//  Copyright © 2016 Orion. All rights reserved.
//

import UIKit
import AVFoundation


protocol BarcodeDelegate {
    func barcodeController(onBarcodeDetected: String)
}

class BarcodeDetectorViewController: UIViewController,  AVCaptureMetadataOutputObjectsDelegate {
    
    static let storyBoardId = "barcodeViewController"
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var toolbar: UIToolbar!
    private var captureSession: AVCaptureSession?
    private var previewLayer: AVCaptureVideoPreviewLayer?
    private var detectionFrame: UIView!
    
    var delegate: BarcodeDelegate?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let captureDevice  = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do {
            
            try captureDevice.lockForConfiguration()
            captureDevice.focusMode = .ContinuousAutoFocus
            captureDevice.exposureMode = .ContinuousAutoExposure
            captureDevice.unlockForConfiguration()
            
            let input = try AVCaptureDeviceInput(device: captureDevice)
            captureSession = AVCaptureSession()
            captureSession?.addInput(input)
            let captureMetadata = AVCaptureMetadataOutput()
            captureSession?.addOutput(captureMetadata)
            captureMetadata.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
            captureMetadata.metadataObjectTypes = [AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeUPCECode, AVMetadataObjectTypeQRCode]
            
            previewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
            previewLayer?.videoGravity = AVLayerVideoGravityResizeAspectFill
            previewLayer?.frame = view.layer.bounds
            view.layer.addSublayer(previewLayer!)
            captureSession?.startRunning()
            
            view.bringSubviewToFront(toolbar)
            
            detectionFrame = UIView()
            detectionFrame.layer.borderColor = UIColor.greenColor().CGColor
            detectionFrame.layer.borderWidth = 2
            view.addSubview(detectionFrame)
            view.bringSubviewToFront(detectionFrame)
        } catch {
            print ("Some error occured while setting the preview")
        }
    }
    
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!) {
        
        if metadataObjects == nil || metadataObjects.count == 0 {
            detectionFrame.frame = CGRectZero
            return
        }
        
        AudioServicesPlaySystemSound(1052)
        
        let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
        
        let barcodeObject = previewLayer?.transformedMetadataObjectForMetadataObject(metadataObject)
        detectionFrame.frame = (barcodeObject?.bounds)!
        
        captureSession?.stopRunning()
        dismissViewControllerAnimated(true, completion: nil)
        let barcode = String(metadataObject.stringValue.characters.dropFirst())
        delegate?.barcodeController(barcode)
    }
    
}
