//
//  HelperClass.m
//  DWC eServices
//
//  Created by Mina Zaklama on 5/26/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import "HelperClass.h"

@implementation HelperClass

+ (UIImage*)maskImage:(UIImage*)image withMask:(UIImage*)maskImage {
	
	UIImage *resizedImage = [HelperClass imageWithImage:image scaledToSize:maskImage.size];
	
	CGImageRef maskRef = maskImage.CGImage;
	
	CGImageRef mask = CGImageMaskCreate(CGImageGetWidth(maskRef),
										CGImageGetHeight(maskRef),
										CGImageGetBitsPerComponent(maskRef),
										CGImageGetBitsPerPixel(maskRef),
										CGImageGetBytesPerRow(maskRef),
										CGImageGetDataProvider(maskRef), NULL, false);
	
	CGImageRef masked = CGImageCreateWithMask([resizedImage CGImage], mask);
	return [UIImage imageWithCGImage:masked];
	
}

+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize {
	UIGraphicsBeginImageContext( newSize );
	[image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return newImage;
}

+ (void)createRoundBorderedViewWithShadows:(UIView*)view {
	// border radius
	[view.layer setCornerRadius:10.0f];
	
	// border
	[view.layer setBorderColor:[UIColor lightGrayColor].CGColor];
	
	// drop shadow
	[view.layer setShadowColor:[UIColor darkGrayColor].CGColor];
	[view.layer setShadowOpacity:0.8];
	[view.layer setShadowRadius:0.5];
	[view.layer setShadowOffset:CGSizeMake(2.0, 2.0)];
}

+ (NSMutableAttributedString*)createUnderlinedWhiteColorString:(NSString*)text {
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
	
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [attributedString length])];
	
	UIColor* textColor = [UIColor whiteColor];
    [attributedString setAttributes:@{NSForegroundColorAttributeName:textColor,NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0,[attributedString length])];
	
	return attributedString;
}

+ (NSMutableAttributedString*)createUnderlinedString:(NSString*)text color:(UIColor*)textColor {
	NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:text];
	
    [attributedString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [attributedString length])];
	
    [attributedString setAttributes:@{NSForegroundColorAttributeName:textColor,NSUnderlineStyleAttributeName:[NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:NSMakeRange(0,[attributedString length])];
	
	return attributedString;
}

+ (NSDate*)initDateWithString:(NSString*)dateString dateFormat:(NSString*)dateFormat {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:dateFormat];
	return [formatter dateFromString:dateString];
}

@end
