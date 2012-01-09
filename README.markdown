# Description
This library brings the concept of "Pull to refresh" to UIGestureRecognizer. It uses recognizer instead of the UIScrollView delegate to manage itself.

# How to use
## Using the Framework as-is
Drag the PHRefreshGestureRecognizer.embeddedframework folder into XCode like any other file. Make sure you check the "Copy items into destination group's folder (if needed)". This folder includes the .framework folder that includes the public header and the resources (the arrows) as well.

To use the library, import the framework:
`#import <PHRefreshGestureRecognizer/PHRefreshGestureRecognizer.h>`

## Using source files
If you want to modify the code, you have to drag the .h and .m files that are located in PHRefreshGestureRecognizer.

# Todo
If you feel that this library is missing something, feel free to send a pull request my way or ask for it in the issues section. I will gladly add it if it's possible.

# Credits
[Pier-Olivier Thibault](https://www.twitter.com/pothibo) and it's [contributors](https://github.com/pothibo/PHRefreshTriggerView/contributors).

Also I would like to thank [Enormego](https://github.com/enormego/EGOTableViewPullRefresh) for creating its EGOTableViewPullRefresh. I have used one of his arrow in this project.

# License

Copyright (C) 2012 Pier-Olivier Thibault

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
