//
//  HelperClass.h
//  DWC eServices
//
//  Created by Mina Zaklama on 5/26/14.
//  Copyright (c) 2014 Zapp Island. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HelperClass : NSObject

+ (UIImage*)maskImage:(UIImage*)image withMask:(UIImage*)maskImage;
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
+ (void)createRoundBorderedViewWithShadows:(UIView*)view;
+ (NSMutableAttributedString*)createUnderlinedWhiteColorString:(NSString*)text;
+ (NSMutableAttributedString*)createUnderlinedString:(NSString*)text color:(UIColor*)textColor;
+ (NSDate*)initDateWithString:(NSString*)dateString dateFormat:(NSString*)dateFormat;
@end
