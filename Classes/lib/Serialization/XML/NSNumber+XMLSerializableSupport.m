//
//  NSNumber+XMLSerializableSupport.m
//  objective_support
//
//  Created by James Burka on 2/17/09.
//  Copyright 2009 Burkaprojects. All rights reserved.
//

#import "NSObject+XMLSerializableSupport.h"
#import "NSNumber+XMLSerializableSupport.h"


@implementation NSNumber(XMLSerializableSupport)

- (NSString *)toXMLValueWithAttachments:(NSMutableArray *)attachments {
	return [self stringValue];
}

- (NSString *)toXMLElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
						withTranslations:(NSDictionary *)keyTranslations captureAttachments:(NSMutableArray *)attachments{
	return [[self class] buildXmlElementAs:rootName withInnerXml:[self toXMLValueWithAttachments:attachments] andType:[[self class] xmlTypeFor:self]];
}


@end
