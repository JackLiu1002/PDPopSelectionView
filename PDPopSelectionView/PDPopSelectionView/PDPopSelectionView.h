//
//  PDPopSelectionView.h
//  LabaAssignment
//
//  Created by Jack on 16/4/8.
//  Copyright © 2016年 com.yiyu.co.Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^SelectionHandle) (NSInteger selectedIndex);

@interface PDPopSelectionView : UIView
@property (nonatomic, strong) NSArray *selections;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, copy) SelectionHandle selectionHandle;

- (id)initWithTitle:(NSString *)title selections:(NSArray *)selections;
- (void)show;

@end
