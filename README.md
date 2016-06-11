
## Overview

![snapshot](https://github.com/JackLiu1002/PDPopSelectionView/blob/master/PDPopSelectionView/snapshot.gif)

# Usage

``` objc
    NSArray *dataSource = @[@"北京",@"上海",@"广州",@"深圳"];
    PDPopSelectionView *selectView = [[PDPopSelectionView alloc]initWithTitle:@"选择" selections:dataSource];
    selectView.selectionHandle = ^(NSInteger selectedIndex) {
        NSLog(@"selectedIndex:%li",selectedIndex);
    };
    [selectView show];
```

## Installation

Use cocoapods  

``` ruby
pod 'PDPopSelectionView', '1.0.1'
```

## License

PDPopSelectionView is released under the MIT license. See LICENSE for details.
