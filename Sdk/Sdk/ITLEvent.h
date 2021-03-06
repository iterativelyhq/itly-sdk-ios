//
//  ITLEvent.h
//  Sdk
//
//  Copyright © 2020 Iteratively. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Foundation/NSObjCRuntime.h>
#import <ItlySdk/ITLEventMetadata.h>
#import <ItlySdk/ITLProperties.h>

NS_SWIFT_NAME(Event)
@interface ITLEvent : ITLProperties

@property (readonly, copy, nonnull) NSString* name;
@property (readonly, copy, nonnull) ITLEventMetadata* metadata;
@property (readonly, copy, nonnull) NSString* eventId NS_SWIFT_NAME(id);
@property (readonly, copy, nonnull) NSString* version;

-(instancetype _Nonnull )initWithName:(NSString * _Nonnull)nameParam
                        propertiesDict:(NSDictionary<NSString*, id>* _Nullable)propertiesDictParam
                        id:(NSString * _Nullable)idParam
                        version:(NSString * _Nullable)versionParam
                        metadata:(ITLEventMetadata* _Nullable)metadataParam;

@end
