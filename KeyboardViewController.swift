//
//  KeyboardViewController.swift
//  GIFKeyboard
//
//  Created by Sudhakar Tharigoppula on 06/07/17.
//  Copyright © 2017 Sudhakar Tharigoppula. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController, UIScrollViewDelegate {


    var keyboard:Keyboard!
    var containerView: UIView!
    var arrayOfURLStrings:[String] = []
    var arrayOfImages:[UIImage] = []
    var arrayofFLAnimatedImages:[FLAnimatedImage] = []
    var firstNavButton: UIButton!
    var secondNavButton: UIButton!

    @IBOutlet var nextKeyboardButton: UIButton!

    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        // Add custom view sizing constraints here
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.keyboard =  Bundle.main.loadNibNamed("Keyboard", owner: nil, options: nil)?[0] as! Keyboard
        self.view .addSubview(self.keyboard)
              
        self.addNextKeyboardButton()
        addFirstNavButton(55.0)
        addSecondNavButton(95)
        self.addDeleteButton()
        self.addGifAnimatedImages()
        self.addPngImages()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated
    }
    
    func addNextKeyboardButton() {
        nextKeyboardButton = UIButton(type: .custom)
        nextKeyboardButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        nextKeyboardButton.setBackgroundImage(UIImage.init(named: "grid-world.png"), for: UIControlState.normal)
        nextKeyboardButton.contentMode = UIViewContentMode.scaleToFill
        nextKeyboardButton.sizeToFit()
        nextKeyboardButton.translatesAutoresizingMaskIntoConstraints = false
        nextKeyboardButton.titleLabel?.font = UIFont(name: "Arial", size: 15)
        nextKeyboardButton.addTarget(self, action: #selector(UIInputViewController.advanceToNextInputMode), for: .touchUpInside)
        self.view.addSubview(self.nextKeyboardButton)
        
        let nextKeyboardButtonLeftSideConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: +10.0)
        let nextKeyboardButtonBottomConstraint = NSLayoutConstraint(item: self.nextKeyboardButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([nextKeyboardButtonLeftSideConstraint, nextKeyboardButtonBottomConstraint])
    }
    
    func addFirstNavButton(_ xValue: CGFloat) {
        
        firstNavButton = UIButton(type: .custom) as UIButton
        firstNavButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        firstNavButton.setBackgroundImage(UIImage.init(named: "gifImage.png"), for: UIControlState.normal)
        firstNavButton.sizeToFit()
        firstNavButton.translatesAutoresizingMaskIntoConstraints = false
        firstNavButton.titleLabel?.font = UIFont(name: "Arial", size: 20)
        firstNavButton.addTarget(self, action: #selector(KeyboardViewController.didTapGif), for: .touchUpInside)
        self.view.addSubview(firstNavButton)
        let deleteButtonRightSideConstraint = NSLayoutConstraint(item: firstNavButton, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: xValue)
        let deleteButtonBottomConstraint = NSLayoutConstraint(item: firstNavButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([deleteButtonRightSideConstraint, deleteButtonBottomConstraint])
    }
    
    func addSecondNavButton(_ xValue: CGFloat) {
        secondNavButton = UIButton(type: .custom) as UIButton
        secondNavButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        secondNavButton.setBackgroundImage(UIImage.init(named: "pngImage.png"), for: UIControlState.normal)
        secondNavButton.sizeToFit()
        secondNavButton.translatesAutoresizingMaskIntoConstraints = false
        secondNavButton.addTarget(self, action: #selector(KeyboardViewController.didTapPng), for: .touchUpInside)
        self.view.addSubview(secondNavButton)
        let deleteButtonRightSideConstraint = NSLayoutConstraint(item: secondNavButton, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: xValue)
        let deleteButtonBottomConstraint = NSLayoutConstraint(item: secondNavButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([deleteButtonRightSideConstraint, deleteButtonBottomConstraint])
    }

    
    func addDeleteButton() {
        let deleteButton = UIButton(type: .system) as UIButton
        deleteButton.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        deleteButton.setBackgroundImage(UIImage.init(named: "deletePng.png"), for: UIControlState.normal)
        deleteButton.sizeToFit()
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        deleteButton.addTarget(self, action: #selector(KeyboardViewController.didTapDelete), for: .touchUpInside)
        self.view.addSubview(deleteButton)
        let deleteButtonRightSideConstraint = NSLayoutConstraint(item: deleteButton, attribute: .right, relatedBy: .equal, toItem: self.view, attribute: .right, multiplier: 1.0, constant: -10.0)
        let deleteButtonBottomConstraint = NSLayoutConstraint(item: deleteButton, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: -5.0)
        self.view.addConstraints([deleteButtonRightSideConstraint, deleteButtonBottomConstraint])
    }
    
    func didTapDelete() {
        let proxy = textDocumentProxy as UITextDocumentProxy
        proxy.deleteBackward()
    }


    func addGifAnimatedImages()  {
        DispatchQueue.main.async {
            let resourcePath = Bundle.main.resourcePath! + "/" + "Gifs"
            let array = try? FileManager.default.contentsOfDirectory(atPath: resourcePath)

            for str in array! {
                let fileFullPath = resourcePath + "/" + str
                let url = URL(fileURLWithPath: fileFullPath)
                let flaImage:FLAnimatedImage = FLAnimatedImage(animatedGIFData: try? Data (contentsOf:url))
                self.arrayofFLAnimatedImages.append(flaImage)
                
            }
            
            var xPos:CGFloat = 0
            var yPos:CGFloat = 10
            let xOffset:CGFloat = 10
            let yOffset:CGFloat = 10
            let imageWidth:CGFloat = 75.0
        
            for (index,flaImage) in self.arrayofFLAnimatedImages.enumerated() {
                
                let flaImageView:FLAnimatedImageView = FLAnimatedImageView()
                flaImageView.animatedImage = flaImage
                flaImageView.frame = CGRect(x: xPos, y: yPos, width: imageWidth , height: imageWidth)
                flaImageView.tag = index+1
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(KeyboardViewController.tappedGifImage(tapGestureRecognizer:)))
                flaImageView.isUserInteractionEnabled = true
                flaImageView.addGestureRecognizer(tapGesture)

                self.keyboard.scrollView.addSubview(flaImageView)
                xPos += imageWidth
                xPos += xOffset
                if (index+1)%9 == 0 {
                  yPos += imageWidth
                  yPos += yOffset
                  xPos = 0
                }
            }
            var contentSize :CGFloat =  CGFloat(self.arrayofFLAnimatedImages.count*(75+10))
            if self.arrayofFLAnimatedImages.count > 10 {
                contentSize = CGFloat(13*(imageWidth+xOffset))
            }
             self.keyboard.scrollView.contentSize = CGSize(width: contentSize, height: self.keyboard.scrollView.contentSize.height)
           }
    }
    
    func addPngImages() {
      
        var xPos :CGFloat = 9*(75.0+10)
        var yPos:CGFloat = 10
        let xOffset:CGFloat = 10
        let yOffset:CGFloat = 10
        let imageWidth:CGFloat = 29.0
        DispatchQueue.main.async {
            let resourcePath = Bundle.main.resourcePath! + "/" + "pngs"
            let array = try? FileManager.default.contentsOfDirectory(atPath: resourcePath)
            
            for (index,str) in array!.enumerated() {
                let fileFullPath = resourcePath + "/" + str

                let image = UIImage.init(named: fileFullPath)
                let pngImageView = UIImageView.init(frame: CGRect(x: xPos, y: yPos, width: (image?.size.width)!, height: (image?.size.height)!))
                pngImageView.image = image
                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(KeyboardViewController.tappedPngImage(tapGestureRecognizer:)))
                pngImageView.isUserInteractionEnabled = true
                pngImageView.addGestureRecognizer(tapGesture)
                self.keyboard.scrollView.addSubview(pngImageView)
                
                xPos += imageWidth
                xPos += xOffset
                
                if (index+1)%10 == 0 {
                    yPos += imageWidth
                    yPos += yOffset
                    xPos = 9*(75.0+10)
                }
            }
            let gifsContentSize:CGFloat = 10*(75.0+10)+650
            self.keyboard.scrollView.contentSize = CGSize(width:CGFloat(gifsContentSize), height: self.keyboard.scrollView.contentSize.height)
        }

    }
    
    func didTapGif() {
        self.keyboard.scrollView.setContentOffset(CGPoint.zero, animated: true)
    }
    
    func didTapPng() {
        self.keyboard.scrollView.setContentOffset(CGPoint.init(x: 9*(75.0+10), y: 0), animated: true)
    }

    func tappedGifImage(tapGestureRecognizer: UITapGestureRecognizer) {
        
        if let view = tapGestureRecognizer.view as? FLAnimatedImageView {
            
            let data = view.animatedImage.data
            let pb = UIPasteboard.general
            let pngType = UIPasteboardTypeListImage[0] as! String
            pb.image = view.animatedImage.posterImage
            pb.setData(data!, forPasteboardType: pngType)
        }
    }
    
    func tappedPngImage(tapGestureRecognizer: UITapGestureRecognizer) {
        
        if let imageView = tapGestureRecognizer.view as? UIImageView {
            let pb = UIPasteboard.general
            let pngType = UIPasteboardTypeListImage[0] as! String
            pb.image = imageView.image
            pb.setData(UIImagePNGRepresentation(imageView.image!)!, forPasteboardType: pngType)
        }
    }
    
    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }
    
    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
        
        var textColor: UIColor
        let proxy = self.textDocumentProxy
        if proxy.keyboardAppearance == UIKeyboardAppearance.dark {
            textColor = UIColor.white
        } else {
            textColor = UIColor.black
        }
    }
    
    

}
