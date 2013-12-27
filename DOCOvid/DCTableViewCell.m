//
//  DCTableViewCell.m
//  DOCOVedio
//
//  Created by amor on 13-11-15.
//  Copyright (c) 2013年 amor. All rights reserved.
//

#import "DCTableViewCell.h"
@interface DCTableViewCell()
{
    UIImageView *_bgImge;
    UIImageView *_seperatorImg;
    BOOL _ishidden;
}
@end
@implementation DCTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
//    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DCTableViewCell" owner:self options:nil];
//    for (id obj in nib) {
//        if ([obj  isMemberOfClass:[DCTableViewCell class]]) {
//            ((DCTableViewCell*)obj).backgroundColor = [UIColor clearColor];
//            return obj;
//        }
//    }
//    return nil;
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    self.backgroundColor = [UIColor clearColor];
    return self;
}

- (void)setHiddenBgImge:(BOOL)hiddenBgImge
{
    _ishidden = hiddenBgImge;
}

- (void)awakeFromNib
{
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_6_0
    self.titlelal.textAlignment = UITextAlignmentCenter;
#else
    self.titlelal.textAlignment = NSTextAlignmentCenter;
#endif
    self.titlelal.font = EuphBold_font(16);
    self.titlelal.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sepeorcolor"]];
    
    self.deslal.textColor = Default_bgc;
    self.deslal.numberOfLines = 0;
    self.deslal.font = Euph_font(14);
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_6_0
    self.lengthlal.textAlignment = UITextAlignmentCenter;
#else
    self.lengthlal.textAlignment = NSTextAlignmentCenter;
#endif
    self.lengthlal.font = EuphBold_font(14);
    self.lengthlal.textColor = [UIColor whiteColor];
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    [self setImage:nil];
}

-(void)setImage:(UIImage *)image
{
    self.imageView.image = image;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)layoutSubviews
{
    if (!_bgImge) {
        _bgImge = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"clip_boders"]] DD_AUTORELEASE];
        _bgImge.origin = CGPointMake(44, -14);
        [self addSubview:_bgImge];
    }
    
    if (!_seperatorImg) {
        _seperatorImg = [[[UIImageView alloc] initWithFrame:CGRectMake(0, self.height-1, self.width, 1)] DD_AUTORELEASE];
        _seperatorImg.image = [UIImage imageNamed:@"sepeorcolor"];
        [self addSubview:_seperatorImg];
    }
    
    if (!self.imageView) {
        self.imageView = [[[UIImageView alloc] initWithFrame:CGRectMake(71, 20, 194, 130)] DD_AUTORELEASE];
        self.imageView.image = [UIImage imageNamed:@"placehold_hs_bg"];
        [self addSubview:self.imageView];
    }else{
        self.imageView.frame = CGRectMake(71, 20, 194, 130);
    }
    
    if (!self.delete_tag) {
        self.delete_tag = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"select_icon"]] DD_AUTORELEASE];
        self.delete_tag.origin = CGPointMake(239, 120);
        self.delete_tag.alpha = cellAHidden;
        [self addSubview:self.delete_tag];
    }
    
    if (!self.titlelal) {
        self.titlelal = [[[UILabel alloc] initWithFrame:CGRectMake(357, 15, self.width-380, 21)] DD_AUTORELEASE];
        self.titlelal.textColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"sepeorcolor"]];
        self.titlelal.font = Euph_font(16);
        self.titlelal.backgroundColor = [UIColor clearColor];
        [self addSubview: self.titlelal];
    }
    
    if (!self.timelal) {
        self.timelal = [[[UILabel alloc] initWithFrame:CGRectMake(357, 44, 180, 21)] DD_AUTORELEASE];
        self.timelal.textColor = [UIColor lightTextColor];
        self.timelal.font = Euph_font(14);
        self.timelal.backgroundColor = [UIColor clearColor];
        [self addSubview:self.timelal];
    }
    if (!self.cellectlal) {
        self.cellectlal = [[[UILabel alloc] initWithFrame:CGRectMake(365+180, 44, 280, 21)] DD_AUTORELEASE];
        self.cellectlal.textColor = [UIColor lightTextColor];
        self.cellectlal.font = Euph_font(14);
        self.cellectlal.backgroundColor = [UIColor clearColor];
        [self addSubview:self.cellectlal];
    }
    
    if (!self.deslal) {
        self.deslal = [[[UILabel alloc] initWithFrame:CGRectMake(357, 60, self.width-380, 100)] DD_AUTORELEASE];
        self.deslal.textColor = [UIColor blackColor];
        self.deslal.numberOfLines = 0;
        self.deslal.font = Euph_font(16);
        self.deslal.backgroundColor = [UIColor clearColor];
        self.deslal.textColor = [UIColor darkGrayColor];
        [self addSubview: self.deslal];
    }
    
    if (!self.statuslal) {
        self.statuslal = [[[UILabel alloc] initWithFrame:CGRectMake(357, self.height-31, self.width-380, 21)] DD_AUTORELEASE];
        self.statuslal.textColor = [UIColor lightTextColor];
        self.statuslal.font = Euph_font(14);
        self.statuslal.backgroundColor = [UIColor clearColor];
        [self addSubview:self.statuslal];
    }
    
    if (!self.lengthlal) {
        self.lengthlal = [[[UILabel alloc] initWithFrame:CGRectMake(74, 164, 194, 21)] DD_AUTORELEASE];
        self.lengthlal.font = Euph_font(14);
#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_6_0
        self.lengthlal.textAlignment = UITextAlignmentCenter;
#else
        self.lengthlal.textAlignment = NSTextAlignmentCenter;
#endif
        self.lengthlal.backgroundColor = [UIColor clearColor];
        self.lengthlal.textColor = [UIColor whiteColor];
        [self addSubview:self.lengthlal];
    }
    
    //default value
    _bgImge.hidden = _ishidden;
    self.titlelal.text = @"测试影片";
    self.timelal.text = @"片长：10小时45分23秒";
    self.cellectlal.text = @"收藏时间：2013-13-11";
    self.deslal.text = @"     继《行星地球》之后，BBC又推出了新的纪录片《生命》。在这部延续了BBC一贯制作水准的优秀纪录片中，许多镜头看起来就像是凭空构造出来的，他们逃过完美，太过离奇，以至于让人无法相信这不是利用电脑制作出来的，但事实上，这些镜头的确是真实的。太过离奇，以至于让人无法相信这不是利用电脑制作出来的，但事实上，这些镜头的确是真实的。太过离奇，以至于让人无法相信这不是利用电脑制作出来的，但事实上，这些镜头的确是真实的。";
    self.statuslal.text = @"已经缓存可以离线播放";
    self.lengthlal.text = @"大小：180M";
    //resiaze
//#if __IPHONE_OS_VERSION_MAX_ALLOWED <= __IPHONE_6_0
//        CGSize size = [self.deslal.text sizeWithFont:Euph_font(14) forWidth:self.deslal.width lineBreakMode:NSLineBreakByCharWrapping];
//        self.deslal.height = size.height;
//#else
//        NSAttributedString *attrStr = [[[NSAttributedString alloc] initWithString:self.deslal.text] DD_AUTORELEASE];
//        NSRange range = NSMakeRange(0, attrStr.length);
//        NSDictionary *dic = [attrStr attributesAtIndex:0 effectiveRange:&range];
//        CGRect frmae = [self.deslal.text boundingRectWithSize:CGSizeMake(self.deslal.width, 1000) options:NSStringDrawingUsesFontLeading attributes:dic context:NULL];
//        self.deslal.height = frmae.size.height;
//#endif

    
}
@end
