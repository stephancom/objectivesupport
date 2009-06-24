//
//  SerializationConfig.h
//  SmartMingle
//
//  Created by William Castrogiovanni on 6/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 This class defines methods common to all serializers.
 */

@interface SerializationConfig : NSObject

	/**
	 Returns TRUE if the serializer should capture binary data as separate attachments
	 Returns FALSE if binary data should be stored alongside the text (usually by Base64-encoding it)
	 */
	+ (BOOL)getShouldCaptureBinaryAttachments;

	/**
	 Set to TRUE if you want your serializer to capture binary data into a separate array
	 Set to FALSE if you want your serializer to encode the binary data alongside the text
	 Defaults to TRUE.
	 */	
	+ (void)setShouldCaptureBinaryAttachments: (BOOL) flag;
	

@end
