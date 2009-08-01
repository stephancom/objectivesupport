//
//  NSDictionary+UrlEncoding.h
//
//  Created by Don McCaughey 
//  See his blog entry at http://blog.ablepear.com/2008/12/urlencoding-category-for-nsdictionary.html
//  Integrated into ObjectiveSupport by William Castrogiovanni on 7/31/09.
//

#import <Foundation/Foundation.h>


@interface NSDictionary (UrlEncoding)

-(NSString*) urlEncodedString;

@end