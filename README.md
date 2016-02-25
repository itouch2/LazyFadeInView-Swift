# LazyFadeInView-Swift

LazyFadeInView is a cool way to animate the appearance of a label. This effect is a clone of [Secret app](https://itunes.apple.com/us/app/secret-speak-freely/id775307543?mt=8). 
You can find Objective-C version in [here](https://github.com/itouch2/LazyFadeInView)

## Usage
To use LazyFadeInView, create a `LazyFadeInView` and add it to your view. It will animate to show up once it's text is set.

An example of making a lazy fade in view:

```swift
var lazyFadeInView: LazyFadeInView = LazyFadeInView.init(frame: CGRectMake(20, 100, UIScreen.mainScreen().bounds.size.width - 40, 200))
lazyFadeInView?.textColor = UIColor.blackColor()
lazyFadeInView?.text = strayBirds
self.view.addSubview(lazyFadeInView!)
```

## A Quick Peek
![screenshots](https://cloud.githubusercontent.com/assets/4316898/2808172/95280184-cd14-11e3-876b-ac00ba78fbc9.gif)

## License

LazyFadeInView is available under the MIT license, see the LICENSE file for more information.     
