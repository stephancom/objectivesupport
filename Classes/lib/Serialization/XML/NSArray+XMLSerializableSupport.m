//
//  NSArray+XMLSerializableSupport.m
//  
//
//  Created by vickeryj on 9/29/08.
//  Copyright 2008 Joshua Vickery. All rights reserved.
//

#import "NSArray+XMLSerializableSupport.h"
#import "NSObject+XMLSerializableSupport.h"
#import "ORBinaryData.h"

@implementation NSArray (XMLSerializableSupport)

- (NSString *)toXMLValueWithAttachments:(NSMutableArray *)attachments {
	NSMutableString *result = [NSMutableString string];
	
	for (id element in self) {
		[result appendString:[element toXMLElementCaptureAttachments:attachments]];
	}
	
	return result;
}

- (NSString *)toXMLElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
						withTranslations:(NSDictionary *)keyTranslations captureAttachments:(NSMutableArray *)attachments{
	NSMutableString *elementValue = [NSMutableString string];
	for (id element in self) {
		[elementValue appendString:[element toXMLElementAs:[[element class] xmlElementName] excludingInArray:exclusions withTranslations:keyTranslations captureAttachments:attachments]];
	}
	return [[self class] buildXmlElementAs:rootName withInnerXml:elementValue andType:@"array"];
}


@end
