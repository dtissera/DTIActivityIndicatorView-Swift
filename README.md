DTIActivityIndicatorView
========================

Animated custom ActivityIndicator inspired from css library SpinKit and much more... 
Written in Swift.

<img src="Shots/rotatingplane.gif"/> &nbsp; 
<img src="Shots/doublebounce.gif"/> &nbsp;
<img src="Shots/wave.gif"/> &nbsp;
<img src="Shots/pulse.gif"/> &nbsp;
<img src="Shots/chasingdots.gif"/> &nbsp;
<img src="Shots/spotify.gif"/> &nbsp;
<img src="Shots/wp8.gif"/> &nbsp;

### Installation
Support for swift project is not yet supported by cocoapod.
I will create a podspec file later.
DTIActivityIndicatorView will be available through [CocoaPods](http://cocoapods.org).
For instance, you will have to manually copy Classes/* in your project.

You can see work progress here:
https://github.com/CocoaPods/CocoaPods/issues/2272

This component require **Xcode6-Beta6** to compile.

### Usage
DTIActivityIndicatorView is subclass of UIView. So you can add the instance to some view.
DTIActivityIndicatorView support storyBoards and new IBDesignable attributes

*swift*
```swift
let myActivityIndicatorView: DTIActivityIndicatorView = DTIActivityIndicatorView(frame: CGRect(x:0.0, y:0.0, width:80.0, height:80.0))
self.view.addSubview(myActivityIndicatorView)
myActivityIndicatorView.indicatorColor = UIColor.redColor()
myActivityIndicatorView.indicatorStyle = DTIIndicatorStyle.convInv(.chasingDots) 
myActivityIndicatorView.startActivity()
```

*objc*
```objc
DTIActivityIndicatorView *myActivityIndicatorView = [[DTIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0, 0.0, 80.0, 80.0)];
[self.view addSubview:myActivityIndicatorView];
myActivityIndicatorView.indicatorColor = [UIColor redColor];
myActivityIndicatorView.indicatorStyle = @"chasingDots";
[myActivityIndicatorView startActivity];
```

