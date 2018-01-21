//
//  HTAcountAddHeaderCell.m
//  XuanYuan
//
//  Created by niesiyang-worker on 2018/1/21.
//  Copyright © 2018年 聂嗣洋. All rights reserved.
//

#import "HTAcountAddHeaderCell.h"

@interface HTAcountAddHeaderCell()
@property (weak, nonatomic) IBOutlet UIView *inputBgView;
@property (weak, nonatomic) IBOutlet UITextField *inputTextField;

@end

@implementation HTAcountAddHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.inputBgView ht_bottomLineShow];
    [self.iconImage ht_setBorderWidth:0.5 Color:RGBHex(0xe1e1e1)];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
