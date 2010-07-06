//
//  NSDictionary+UrlEncoding.m
//
//  Created by Don McCaughey 
//  See his blog entry at http://blog.ablepear.com/2008/12/urlencoding-category-for-nsdictionary.html
//  Integrated into ObjectiveSupport by William Castrogiovanni on 7/31/09.
//

#import "NSDictionary+UrlEncoding.h"


// helper function: get the string form of any object
static NSString *toString(id object) {
	return [NSString stringWithFormat: @"%@", object];
}

// helper function: get the url encoded string form of any object
static NSString *urlEncode(id object) {
	NSString *string = toString(object);
	return [string stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
}


@implementation NSDictionary (UrlEncoding)

-(NSString*) urlEncodedString {
	NSMutableArray *parts = [NSMutableArray array];
	for (id key in self) {
		id value = [self objectForKey: key];
		NSString *part = [NSString stringWithFormat: @"%@=%@", urlEncode(key), urlEncode(value)];
		[parts addObject: part];
	}
	return [parts componentsJoinedByString: @"&"];
}

@end