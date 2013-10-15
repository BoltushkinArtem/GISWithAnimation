//
//  GoogleImageSearchManager.m
//  GISWithAnimation
//
//  Created by Dragon on 15.10.13.
//  Copyright (c) 2013 Dragon. All rights reserved.
//

#import "GoogleImageSearchManager.h"
#import <ifaddrs.h>
#import <arpa/inet.h>

static GoogleImageSearchManager *sharedInstance = nil;

@implementation GoogleImageSearchManager

#pragma mark - Инициализация

+ (GoogleImageSearchManager*)instance;
{
    @synchronized(self) {
        if (sharedInstance == nil)
            sharedInstance = [[self alloc] initSingleton];
    }
    return sharedInstance;
}

- (id)initSingleton
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (id)init
{
    return nil;
}

#pragma mark - Публичные методы

- (void)searchImageWithTitle:(NSString*)imageTitle
                   pageIndex:(int)pageIndex
                onCompletion:(ArrayResponseBlock)completionBlock
                     onError:(ErrorResponseBlock)errorBlock
{
    NSString *ipAddress = [self getIPAddress];
    //Replace all space characters with the + character
    NSString *phrase = [[imageTitle componentsSeparatedByString:@" "] componentsJoinedByString:@"+"];
    //The query contains the phrase we want to search, the users ip address and which page we want to pull.
    NSString *requestQuery = [NSString stringWithFormat:@"https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=%@&userip=%@&start=%d", phrase, ipAddress, pageIndex];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestQuery]
                                                           cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                       timeoutInterval:10];
    [request setHTTPMethod: @"GET"];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if (data != nil) {
                                   NSArray *parse_data_array = [self parseResponse:data];
                                   completionBlock(parse_data_array);
                               }
                               else
                                   errorBlock(error);
                           }];
}

- (void)searchImageWithTitle:(NSString*)imageTitle
                minPageIndex:(int)minPageIndex
                maxPageIndex:(int)maxPageIndex
                onCompletion:(ArrayResponseBlock)completionBlock
                     onError:(ErrorResponseBlock)errorBlock
{
    NSString *ipAddress = [self getIPAddress];
    //Replace all space characters with the + character
    NSString *phrase = [[imageTitle componentsSeparatedByString:@" "] componentsJoinedByString:@"+"];
    //The query contains the phrase we want to search, the users ip address and which page we want to pull.
    
    requestNumder = 0;
    answerNumder = 0;
    if (dataArray == nil)
        dataArray = [NSMutableArray new];
    else
        [dataArray removeAllObjects];
    
    for (int page_index = minPageIndex; page_index <= maxPageIndex; page_index = page_index + 4) {
        requestNumder++;
        NSString *requestQuery = [NSString stringWithFormat:@"https://ajax.googleapis.com/ajax/services/search/images?v=1.0&q=%@&userip=%@&start=%d", phrase, ipAddress, page_index];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestQuery]
                                                               cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                                           timeoutInterval:10];
        [request setHTTPMethod: @"GET"];
        [NSURLConnection sendAsynchronousRequest:request
                                           queue:[NSOperationQueue mainQueue]
                               completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                                   answerNumder++;
                                   
                                   if (data != nil) {
                                       NSArray *parse_data_array = [self parseResponse:data];
                                       if (parse_data_array.count != 0)
                                           [dataArray addObjectsFromArray:[parse_data_array mutableCopy]];
                                   }
                                   
                                   if (requestNumder == answerNumder) {
                                       if (dataArray.count != 0) {
                                           completionBlock([dataArray mutableCopy]);
                                       }
                                       else
                                           errorBlock(error);
                                       
                                       requestNumder = 0;
                                       answerNumder = 0;
                                       [dataArray removeAllObjects];
                                   }
                               }];
    }
    

}

#pragma mark - Приватные методы

/*
 *  Метод генерирует IP адрес
 */
- (NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

/*
 *  Метод парсит ответ
 */
-(NSArray *)parseResponse:(NSData *)response
{
    NSError *error = nil;
    NSDictionary *json_array = [NSJSONSerialization JSONObjectWithData:response
                                                               options: NSJSONReadingMutableContainers
                                                                 error: &error];
    
    NSArray *parse_response_array = nil;
    NSDictionary *item = nil;
    for (NSString *item_key in [json_array allKeys]) {
        if ([item_key isEqualToString:@"responseData"] == YES) {
            if ([[json_array objectForKey:item_key] isEqual:[NSNull null]] == YES)
                return parse_response_array;
            else
                item = [json_array objectForKey:item_key];
            
            for (NSString *parse_kay in [item allKeys]) {
                if ([parse_kay isEqualToString:@"results"] == YES) {
                    parse_response_array = [item objectForKey:parse_kay];
                }
            }
            break;
        }
    }
    return parse_response_array;
}

@end
