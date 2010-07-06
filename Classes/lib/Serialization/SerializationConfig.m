//
//  SerializationConfig.m
//  SmartMingle
//
//  Created by William Castrogiovanni on 6/19/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SerializationConfig.h"


static BOOL _shouldCaptureBinaryAttachments = TRUE;

@implementation SerializationConfig

+ (BOOL) getShouldCaptureBinaryAttachments {
	return _shouldCaptureBinaryAttachments;
}

+ (void) setShouldCaptureBinaryAttachments: (BOOL) flag {
	_shouldCaptureBinaryAttachments = flag;	
}

@end
