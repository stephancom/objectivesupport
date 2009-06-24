//
//  XMLSerializable.h
//  
//
//  Created by Ryan Daigle on 7/31/08.
//  Copyright 2008 yFactorial, LLC. All rights reserved.
//

@protocol XMLSerializable

/**
 * Instantiate a single instance of this class from the given XML data.
 */
+ (id)fromXMLData:(NSData *)data;

/**
 * Instantiate a collectionof instances of this class from the given XML data.
 */
+ (NSArray *)allFromXMLData:(NSData *)data;

/**
 * Get the full XML representation of this object (minus the xml directive)
 * using the default element name.  Pass in an empty mutable array to capture any
 * ORBinaryData files that need to be uploaded separately.
 *
 *   [myPerson toXMLElementCaptureAttachments: [NSMutableArray array]] //> @"<person><first_name>Ryan</first_name>...</person>"
 */
- (NSString *)toXMLElementCaptureAttachments: (NSMutableArray *) attachments;


/**
 * Gets the full representation of this object minus the elements in the exclusions array
 * and allows its member objects to append themselves as attachments for file uploads
 * (This only applies to ORBinaryData objects such as images, which need to be uploaded the server.)
 *
 */
- (NSString *)toXMLElementExcluding:(NSArray *)exclusions captureAttachments:(NSMutableArray *) attachments;

/**
 * Get the full XML representation of this object (minus the xml directive)
 * using the given element name.  Any Data objects discovered will be appended
 * to the attachments array 
 *
 *   [myPerson toXMLElementAs:@"human" captureAttachments: [NSMutableArray array]] 
 *
 *    //> @"<human><first_name>Ryan</first_name>...</human>"
 */
- (NSString *)toXMLElementAs:(NSString *)rootName captureAttachments:(NSMutableArray *) attachments;

/**
 * Get the full XML representation of this object (minus the xml directive)
 * using the given element name and excluding the given properties.  Attachements
 * will be captured to the the passed in array
 *
 *  [myPerson toXMLElementAs:@"human" excludingInArray:[NSArray arrayWithObjects:@"firstName", nil] 
 *          captureAttachments: [NSMutableArray array]]
 *
 *  //> @"<human><last-name>Daigle</last-name></human>
 */
- (NSString *)toXMLElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions 
		  captureAttachments:(NSMutableArray *) attachments;

/**
 * Get the full XML representation of this object (minus the xml directive)
 * using the given element name and translating property names with the keyTranslations mapping.
 * All binary Data objects will be captured to the passed in Mutable array for file upload
 *
 *  [myPerson toXMLElementAs:@"human" withTranslations:[NSDictionary dictionaryWithObjectsAndKeys:@"lastName", @"surname", nil] 
 *          captureAttachments: [NSMutableArray array]]
 *
 *  //> @"<human><first-name>Ryan</first-name><surname>Daigle</surname></human>
 */
- (NSString *)toXMLElementAs:(NSString *)rootName withTranslations:(NSDictionary *)keyTranslations 
		  captureAttachments:(NSMutableArray *) attachments;

/**
 * Get the full XML representation of this object (minus the xml directive)
 * using the given element name, excluding the given properties, and translating
 * property names with the keyTranslations mapping.
 *
 *  [myPerson toXMLElementAs:@"human" excludingInArray:[NSArray arrayWithObjects:@"firstName", nil]
 *			withTranslations:[NSDictionary dictionaryWithObjectsAndKeys:@"lastName", @"surname", nil]
 *          captureAttachments:[NSMutableArray array]]
 *
 *  //> @"<human><surname>Daigle</surname></human>
 */
- (NSString *)toXMLElementAs:(NSString *)rootName excludingInArray:(NSArray *)exclusions
			withTranslations:(NSDictionary *)keyTranslations captureAttachments:(NSMutableArray *)attachments;

@end