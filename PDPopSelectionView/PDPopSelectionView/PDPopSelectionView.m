//
//  PDPopSelectionView.m
//  LabaAssignment
//
//  Created by Jack on 16/4/8.
//  Copyright © 2016年 com.yiyu.co.Ltd. All rights reserved.
//

#define KeyWindow [[UIApplication sharedApplication]keyWindow]
#define SelectionViewWidth ([[UIApplication sharedApplication]keyWindow].frame.size.width - 120)
#define CellHeight 50

#import "PDPopSelectionView.h"
@interface PDPopSelectionView ()<UITableViewDataSource,UITableViewDelegate>
{
    UIView *_bg;
    UILabel *_titleLabel;
    UITableView *_tableview;
    UIButton *_cancelButtion;
    UIButton *_confirmationButton;
    NSInteger _selectedIndex;
}

@end

@implementation PDPopSelectionView

- (id)initWithTitle:(NSString *)title selections:(NSArray *)selections
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        _selectedIndex = NSNotFound;
        _title = title;
        _selections = selections;
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, SelectionViewWidth, 40)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [_titleLabel setBackgroundColor:[UIColor whiteColor]];
        _titleLabel.text = _title;
        NSInteger count = _selections.count;
        CGFloat height = _selections.count < 5 ? CellHeight*count : CellHeight*5;
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 40,SelectionViewWidth,height)];
        _tableview.dataSource = self;
        _tableview.delegate = self;
        if ([_tableview respondsToSelector:@selector(setSeparatorInset:)]) {
            [_tableview setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        if ([_tableview respondsToSelector:@selector(setLayoutMargins:)]) {
            [_tableview setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 0)];
        }
        _tableview.separatorInset = UIEdgeInsetsZero;
        _cancelButtion = [[UIButton alloc]initWithFrame:CGRectMake(0, height+40, SelectionViewWidth/2, 40)];
        [_cancelButtion setTitle:@"取消" forState:UIControlStateNormal];
        [_cancelButtion setBackgroundColor:[UIColor whiteColor]];
        [_cancelButtion setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelButtion addTarget:self action:@selector(cancel:) forControlEvents:UIControlEventTouchDown];
        _confirmationButton = [[UIButton alloc]initWithFrame:CGRectMake(SelectionViewWidth/2, height+40, SelectionViewWidth/2, 40)];
        [_confirmationButton setTitle:@"确认" forState:UIControlStateNormal];
        [_confirmationButton setBackgroundColor:[UIColor whiteColor]];
        [_confirmationButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_confirmationButton addTarget:self action:@selector(confirmation:) forControlEvents:UIControlEventTouchDown];
        
        _bg = [[UIView alloc]initWithFrame:KeyWindow.bounds];
        [_bg setBackgroundColor:[UIColor blackColor]];
        _bg.alpha = 0.3;
        
        self.frame = CGRectMake(0, 0, SelectionViewWidth, height+80);
        [self addSubview:_titleLabel];
        [self addSubview:_tableview];
        [self addSubview:_cancelButtion];
        [self addSubview:_confirmationButton];
        self.center = KeyWindow.center;
    }
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    _titleLabel.text = title;
}

- (void)setSelections:(NSArray *)selections
{
    _selections = selections;
    [_tableview reloadData];
}

- (void)show
{
    [KeyWindow addSubview:_bg];
    [KeyWindow addSubview:self];
    
    CAKeyframeAnimation *transform = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.95, 0.95, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.05, 1.05, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    transform.values = values;
    
    CABasicAnimation *opacity = [CABasicAnimation animationWithKeyPath:@"opacity"];
    [opacity setFromValue:@0.0];
    [opacity setToValue:@1.0];
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 0.2;
    group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [group setAnimations:@[transform, opacity]];

    [CATransaction begin];
    [CATransaction setCompletionBlock:^{
    }];
    [self.layer addAnimation:group forKey:nil];
    [CATransaction commit];
}

- (void)cancel:(UIButton *)buttion
{
    [_bg removeFromSuperview];
    [self removeFromSuperview];
}

- (void)confirmation:(UIButton *)buttion
{
    if (_selectionHandle && _selectedIndex !=NSNotFound) {
        _selectionHandle(_selectedIndex);
    }
    [_bg removeFromSuperview];
    [self removeFromSuperview];
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_selections count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (!cell) {
        cell = [UITableViewCell new];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = _selections[indexPath.row];
    }
    
    if (indexPath.row == _selectedIndex) {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkbox_checked"]];
    } else {
        cell.accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkbox_unchecked"]];
    }
    
    return cell;
}

#pragma mark -

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _selectedIndex = indexPath.row;
    [_tableview reloadData];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark -


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
