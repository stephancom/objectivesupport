//
//  NSDate+XMLSerializableSupport.h
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

@interface NSDate (XMLSerializableSupport)
- (NSString *)toXMLValueWithAttachments:(NSMutableArray *)attachments;
+ (NSDate *)fromXMLDateTimeString:(NSString *)xmlString;
+ (NSDate *)fromXMLDateString:(NSString *)xmlString;
@end
