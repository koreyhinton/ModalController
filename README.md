# ModalController
Modal for iOS 8

#### Simplest Usage
```Swift
let modal = ModalController()
modal.contentMake(wid: 300.0, hgt: 300.0, bgColor: UIColor.blackColor(), cornerRad: 15)
presentViewController(modal, animated: true, completion: nil)
```

##### Custom View

You can alternatively assign a custom content view instead of using the convenient contentMake function
```Swift
...
let modal = ModalController()
modal.content = myCustomView
presentViewController(modal, animated: true, completion: nil)
```

#### Customize Content View
```Swift
let modal = ModalController()
modal.contentMake(wid: 300.0, hgt: 300.0, bgColor: UIColor.whiteColor(), cornerRad: 15)
/* Start Customizations */
let label = UILabel(frame: modal.content.bounds)
label.text = "Hello World"
modal.content.addSubview(label)
/* End Customizations */
presentViewController(modal, animated: true, completion: nil)
```

#### Customize Tap To Close
```Swift
let modal = ModalController()
modal.contentMake(wid: 300.0, hgt: 300.0, bgColor: UIColor.blackColor(), cornerRad: 15)
/* Start Customizations */
modal.closeOnContentTap = true
modal.closeOnBGTap = false
/* End Customizations */
presentViewController(modal, animated: true, completion: nil)
```
#### Customize transparent dark background
```Swift
modal.backgroundDarkness = 0.4
```

#### Fine-grain control
```Swift
modal.onClose = { ()->Void in
    // perform close logic before modal gets dismissed
}

modal.onCloseCompletion = { ()->Void in
    // perform close logic after modal gets dismissed
}

modal.onViewDidLayoutSubviews = { (modalBGView,contentView)->Void in
    contentView.frame = CGRect(x: 0, y: 0, width: modalBGView.frame.size.width, height: modalBGView.frame.size.height/2)
}
```

#### Use storyboard

Assign the @IBOutlet in ModalController.swift:

```Swift
@IBOutlet var content: UIView!
```
