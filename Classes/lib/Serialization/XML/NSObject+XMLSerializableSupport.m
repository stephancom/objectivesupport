//
//  XMLSerializableSupport.m
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "NSObject+XMLSerializableSupport.h"
#import "NSDictionary+XMLSerializableSupport.h"
#import "CoreSupport.h"
#import "FromXMLElementDelegate.h"

@implementation NSObject (XMLSerializableSupport)

# pragma mark XML utility methods

/**
 * Get the appropriate xml type, if any, for the given value.
 * I.e. "integer" or "decimal" etc... for use in element attributes:
 *
 *   <element-name type="integer">1</element-name>
 */
+ (NSString *)xmlTypeFor:(NSObject *)value {
	
	// Can't do this with NSDictionary w/ Class keys.  Explore more elegant solutions.
	// TODO: Account for NSValue native types here?
	if ([value isKindOfClass:[NSDate class]]) {
		return @"datetime";
	} else if ([value isKindOfClass:[NSDecimalNumber class]]) {
		return @"decimal";
	} else if ([value isKindOfClass:[NSNumber class]]) {
		if (0 == strcmp("f",[(NSNumber *)value objCType]) ||
			0 == strcmp("d",[(NSNumber *)value objCType])) 
		{
			return @"decimal";
		}
		else {
			return @"integer";
		}
	} else if ([value isKindOfClass:[NSArray class]]) {
		return @"array";
	} else {
		return nil;
	}
}

+ (NSString *)buildXmlElementAs:(NSString *)rootName withInnerXml:(NSString *)value andType:(NSString *)xmlType{
	NSString *dashedName = [rootName dasherize];
	
	if (xmlType != nil) {
		return [NSString stringWithFormat:@"<%@ type=\"%@\">%@</%@>", dashedName, xmlType, value, dashedName];
	} else {
		return [NSString stringWithFormat:@"<%@>%@</%@>", dashedName, value, dashedName];
	}	
}

+ (NSString *)buildXmlElementAs:(NSString *)rootName withInnerXml:(NSString *)value {
	return [[self class] buildXmlElementAs:rootName withInnerXml:value andType:nil];
}

+ (NSString *)buildXMLElementAs:(NSString *)rootName withValue:(NSObject *)value captureAttachments:(NSMutableArray *)attachments{
	return [[self class] buildXmlElementAs:rootName withInnerXml:[value toXMLValueWithAttachments:attachments] andType:[self xmlTypeFor:value]];
}

+ (NSString *)xmlElementName {
	NSString *className = NSStringFromClass(self);
	return [[className stringByReplacingCharactersInRange:NSMakeRange(0, 1) withString:[[className substringToIndex:1] lowercaseString]] dasherize];
}

# pragma mark XMLSerializable implementation methods

- (NSString *)toXMLElementCaptureAttachments: (NSMutableArray *)attachments {
	return [self toXMLElementAs:[[self class] xmlElementName] excludingInArray:[NSArray array] withTranslations:[NSDictionary dictionary] captureAttachments:attachments];
}

- (NSString *)toXMLElementExcluding:(NSArray *)exclusions captureAttachments:(NSMutableArray *)attachments {
	return [self toXMLElementAs:[[self class] xmlElementName] excludingInArray:exclusions withTranslations:[NSDictionary dictionary] captureAttachments:attachments];  
}

- (NSString *)toXMLElementAs:(NSString *)rootName captureAttachments:(NSMutableArray *)attachments{
	return [self toXMLElementAs:rootName excludingInArray:[NSArray array] withTranslations:[NSDictionary dictionary] captureAttachments:attachments];
}

- (NSString *)toXMLElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions captureAttachments:(NSMutableArray *) attachments{
	return [self toXMLElementAs:rootName excludingInArray:exclusions withTranslations:[NSDictionary dictionary] captureAttachments:attachments];
}

- (NSString *)toXMLElementAs:(NSString *)rootName withTranslations:(NSDictionary *)keyTranslations captureAttachments:(NSMutableArray *) attachments{
	return [self toXMLElementAs:rootName excludingInArray:[NSArray array] withTranslations:keyTranslations captureAttachments:[NSMutableArray array]];
}

/**
 * Override in complex objects to account for nested properties
 **/
- (NSString *)toXMLElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
			withTranslations:(NSDictionary *)keyTranslations captureAttachments: (NSMutableArray *) attachments{
	return [[self properties] toXMLElementAs:rootName excludingInArray:exclusions withTranslations:keyTranslations andType:[[self class] xmlTypeFor:self] captureAttachments: attachments];
}

# pragma mark XML Serialization convenience methods
	
/**
 * Override in objects that need special formatting before being printed to XML
 **/
- (NSString *)toXMLValueWithAttachments:(NSMutableArray *)attachments {
	return [NSString stringWithFormat:@"%@", self];
}

# pragma mark XML Serialization input methods

+ (id)fromXMLData:(NSData *)data {
	
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
	FromXMLElementDelegate *delegate = [FromXMLElementDelegate delegateForClass:self];
    [parser setDelegate:delegate];
	
    // Turn off all those XML nits
    [parser setShouldProcessNamespaces:NO];
    [parser setShouldReportNamespacePrefixes:NO];
    [parser setShouldResolveExternalEntities:NO];
    
	// Let'er rip
    [parser parse];
    [parser release];
	return delegate.parsedObject;
}

+ (NSArray *)allFromXMLData:(NSData *)data {
	return [self fromXMLData:data];
}
@end
