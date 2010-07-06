//
//  XMLSerializableSupport.h
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

#import "XMLSerializable.h"

@interface NSObject (XMLSerializableSupport) <XMLSerializable>

+ (NSString *)xmlTypeFor:(NSObject *)value;
+ (NSString *)buildXmlElementAs:(NSString *)rootName withInnerXml:(NSString *)value andType:(NSString *)xmlType;

/**
 * Construct a string representation of the given value object, assuming
 * the given root element name , the NSObjects's toXmlValue is called.
 */
+ (NSString *)buildXMLElementAs:(NSString *)rootName withValue:(NSObject *)value captureAttachments:(NSMutableArray *)attachments;

/**
 *
 * Constructs the actual xml node as a string
 *
 */
+ (NSString *)buildXmlElementAs:(NSString *)rootName withInnerXml:(NSString *)value;

/**
 * What is the element name for this object when serialized to XML.
 * Defaults to lower case and dasherized form of class name.
 * I.e. [[Person class] xmlElementName] //> @"person"
 */
+ (NSString *)xmlElementName;

/**
 * Construct the XML string representation of this particular object.
 * Use the passed in mutable array to capture any file attachments.
 * Only construct the markup for the value of this object, don't assume
 * any naming.  For instance:
 *
 *   [myObject toXMLValueWithAttachments:[NSMutableArray array]] //> @"xmlSerializedValue"
 *
 * and not
 *
 *   [myObject toXMLValueWithAttachments:[NSMutableArray array]] //> @"<value>xmlSerializedValue</value>"
 *
 * For simple objects like strings, numbers etc this will be the text value of
 * the corresponding element.  For complex objects this can include further markup:
 *
 *   [myPersonObject toXMLValueWithAttachments:[NSMutableArray array]] //> @"<first-name>Ryan</first-name><last-name>Daigle</last-name>"
 *   
 * If the model contain binary data, such as images, use the passed in mutable array to capture the file for uploading
 *
 *   [attachments addObject: self]
 *   return (@"cid:%@", [self contentId]); // the ORBinaryData class adds the content id property specifically for this purpose
 *
 */
- (NSString *)toXMLValueWithAttachments:(NSMutableArray *)attachments;

@end
