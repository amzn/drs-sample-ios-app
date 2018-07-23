/*
 * Copyright 2016-2018 Amazon.com, Inc. or its affiliates.  All Rights Reserved.
 *
 * Except as set forth below, this software is licensed under the Amazon Software License (the "License").  You may not use this software except in compliance with the License.
 * A copy of the License is located at
 *  http://aws.amazon.com/asl/
 * and is also copied below.
 *
 * This software is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, express or implied. See the License for the specific language governing permissions and limitations under the License.
 *
 * NOTICE REGARDING LOGIN WITH AMAZON
 *
 * This software includes certain Login with Amazon software (the "LWA Software") and requires the LWA Software to function.  The LWA Software is licensed as "Program Materials" under the Program Materials License Agreement of the Amazon Mobile App Distribution program, which is available at https://developer.amazon.com/sdk/pml.html.  See the Program Materials License Agreement for the specific language governing permissions and limitations applicable to the LWA Software.
 * The LWA Software is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *
 * FULL TEXT OF AMAZON SOFTWARE LICENSE
 *
 * Amazon Software License
 * 1. Definitions
 * “Licensor” means any person or entity that distributes its Work.
 * “Software” means the original work of authorship made available under this License.
 * “Work” means the Software and any additions to or derivative works of the Software that are made available under this License.
 * The terms “reproduce,” “reproduction,” “derivative works,” and “distribution” have the meaning as provided under U.S. copyright law; provided, however, that for the purposes of this License, derivative works shall not include works that remain separable from, or merely link (or bind by name) to the interfaces of, the Work.
 * Works, including the Software, are “made available” under this License by including in or with the Work either (a) a copyright notice referencing the applicability of this License to the Work, or (b) a copy of this License.
 * 2. License Grants
 * 2.1 Copyright Grant. Subject to the terms and conditions of this License, each Licensor grants to you a perpetual, worldwide, non-exclusive, royalty-free, copyright license to reproduce, prepare derivative works of, publicly display, publicly perform, sublicense and distribute its Work and any resulting derivative works in any form.
 * 2.2 Patent Grant. Subject to the terms and conditions of this License, each Licensor grants to you a perpetual, worldwide, non-exclusive, royalty-free patent license to make, have made, use, sell, offer for sale, import, and otherwise transfer its Work, in whole or in part. The foregoing license applies only to the patent claims licensable by Licensor that would be infringed by Licensor’s Work (or portion thereof) individually and excluding any combinations with any other materials or technology.
 * 3. Limitations
 * 3.1 Redistribution. You may reproduce or distribute the Work only if (a) you do so under this License, (b) you include a complete copy of this License with your distribution, and (c) you retain without modification any copyright, patent, trademark, or attribution notices that are present in the Work.
 * 3.2 Derivative Works. You may specify that additional or different terms apply to the use, reproduction, and distribution of your derivative works of the Work (“Your Terms”) only if (a) Your Terms provide that the use limitation in Section 3.3 applies to your derivative works, and (b) you identify the specific derivative works that are subject to Your Terms. Notwithstanding Your Terms, this License (including the redistribution requirements in Section 3.1) will continue to apply to the Work itself.
 * 3.3 Use Limitation. The Work and any derivative works thereof only may be used or intended for use with the web services, computing platforms or applications provided by Amazon.com, Inc. or its affiliates, including Amazon Web Services, Inc.
 * 3.4 Patent Claims. If you bring or threaten to bring a patent claim against any Licensor (including any claim, cross-claim or counterclaim in a lawsuit) to enforce any patents that you allege are infringed by any Work, then your rights under this License from such Licensor (including the grants in Sections 2.1 and 2.2) will terminate immediately.
 * 3.5 Trademarks. This License does not grant any rights to use any Licensor’s or its affiliates’ names, logos, or trademarks, except as necessary to reproduce the notices described in this License.
 * 3.6 Termination. If you violate any term of this License, then your rights under this License (including the grants in Sections 2.1 and 2.2) will terminate immediately.
 * 4. Disclaimer of Warranty.
 * THE WORK IS PROVIDED “AS IS” WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WARRANTIES OR CONDITIONS OF M ERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, TITLE OR NON-INFRINGEMENT. YOU BEAR THE RISK OF UNDERTAKING ANY ACTIVITIES UNDER THIS LICENSE. SOME STATES’ CONSUMER LAWS DO NOT ALLOW EXCLUSION OF AN IMPLIED WARRANTY, SO THIS DISCLAIMER MAY NOT APPLY TO YOU.
 * 5. Limitation of Liability.
 * EXCEPT AS PROHIBITED BY APPLICABLE LAW, IN NO EVENT AND UNDER NO LEGAL THEORY, WHETHER IN TORT (INCLUDING NEGLIGENCE), CONTRACT, OR OTHERWISE SHALL ANY LICENSOR BE LIABLE TO YOU FOR DAMAGES, INCLUDING ANY DIRECT, INDIRECT, SPECIAL, INCIDENTAL, OR CONSEQUENTIAL DAMAGES ARISING OUT OF OR RELATED TO THIS LICENSE, THE USE OR INABILITY TO USE THE WORK (INCLUDING BUT NOT LIMITED TO LOSS OF GOODWILL, BUSINESS INTERRUPTION, LOST PROFITS OR DATA, COMPUTER FAILURE OR MALFUNCTION, OR ANY OTHER COMM ERCIAL DAMAGES OR LOSSES), EVEN IF THE LICENSOR HAS BEEN ADVISED OF THE POSSIBILITY OF SUCH DAMAGES.
 * Effective Date – April 18, 2008 © 2008 Amazon.com, Inc. or its affiliates. All rights reserved.
 */


#import "CommunicationUtil.h"
#import "Constants.h"
#import "DrsUtil.h"

@interface CommunicationUtil ()

/**
 * A DrsDeviceProtocol object which will handle all events/data.
 */
@property(nonatomic) id <DrsDeviceProtocol> drsHandler;

@end

#pragma mark -

@implementation CommunicationUtil

/**
 * A block used to handle communication response.
 */
typedef void (^ResponseHandler)(NSData *data, NSURLResponse *response, NSError *error);

/*
 * Dictionary key for retrieving slot names.
 */
NSString *const SLOTS_SUBSCRIPTION_STATUS = @"slotsSubscriptionStatus";

#pragma mark - Initialization

- (instancetype)initWithDrsHandler:(id <DrsDeviceProtocol>)drsHandler {
    self = [super init];
    if (self) {
        _drsHandler = drsHandler;
    }
    return self;
}

#pragma mark - Public methods

- (void)sendDeviceStatus {
    NSURLRequest *request = [self buildDeviceStatusRequest];
    [self executeRequest:request finishHandler:[self finishHandler]];
}

- (void)initiateReplenishForSlot:(NSString *)slotID {
    NSURLRequest *request = [self buildReplenishRequestForSlot:slotID];
    [self executeRequest:request finishHandler:[self finishHandler]];
}

- (void)sendSlotStatusForSlot:(NSString *)slotID {
    NSURLRequest *request = [self buildSlotStatusRequestForSlot:slotID];
    [self executeRequest:request finishHandler:[self finishHandler]];
}

- (void)deregisterDevice {
    NSURLRequest *request = [self buildDeregisterDeviceRequest];
    [self executeRequest:request finishHandler:[self deregisterFinishHandler]];
}

- (void)sendSubscriptionInfo {
    NSURLRequest *request = [self buildSubscriptionInfoRequest];
    [self executeRequest:request finishHandler:[self subscriptionFinishHandler]];
}

- (void)cancelTestOrderForSlot:(NSString *)slotID {
    NSURLRequest *request = [self buildCancelTestOrderRequest:slotID];
    [self executeRequest:request finishHandler:[self finishHandler]];
}

- (void)cancelAllTestOrders {
    NSURLRequest *request = [self buildCancelTestOrderRequest:nil];
    [self executeRequest:request finishHandler:[self finishHandler]];
}

#pragma mark - Response handlers

/**
 * Deregistration response handler block.
 * @return The block which will handle deregistration.
 */
- (ResponseHandler)deregisterFinishHandler {
    __block id safeBlockSelf = self;
    return ^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            if ([safeBlockSelf respondsToSelector:@selector(handleErrorResponse:)]) {
                [safeBlockSelf handleErrorResponse:error];
            }
        } else {
            if ([safeBlockSelf respondsToSelector:@selector(handleSuccessResponse:)]) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[safeBlockSelf drsHandler] saveRefreshToken:[NSString string]];
                    [[safeBlockSelf drsHandler] saveAccessToken:[NSString string]];
                });
                [safeBlockSelf handleSuccessResponse:data];
            }
        }
    };
}

/**
 * Request response handler block.
 * @return The block which will handle response from the request.
 */
- (ResponseHandler)finishHandler {
    __block id safeBlockSelf = self;
    return ^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            if ([safeBlockSelf respondsToSelector:@selector(handleErrorResponse:)]) {
                [safeBlockSelf handleErrorResponse:error];
            }
        } else {
            if ([safeBlockSelf respondsToSelector:@selector(handleSuccessResponse:)]) {
                [safeBlockSelf handleSuccessResponse:data];
            }
        }
    };
}

/**
 * Subscription response handler block.
 * @return The block which will handle subscription response.
 */
- (ResponseHandler)subscriptionFinishHandler {
    __block id safeBlockSelf = self;
    return ^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error) {
            if ([safeBlockSelf respondsToSelector:@selector(handleErrorResponse:)]) {
                [safeBlockSelf handleErrorResponse:error];
            }
        } else {
            if ([safeBlockSelf respondsToSelector:@selector(handleSuccessResponse:)]) {
                [safeBlockSelf handleSlotNamesOutput:data];
                [safeBlockSelf handleSuccessResponse:data];
            }
        }
    };
}

#pragma mark - Private methods, request building

/**
 * Build the device status request.
 * @return The NSURLRequest for rhe device status command.
 */
- (NSURLRequest *)buildDeviceStatusRequest {
    NSMutableURLRequest *request = [self buidlRequestForPaths:@[DEVICE_STATUS_PATH]];
    [request addValue:DEVICE_STATUS_ACCEPT_TYPE forHTTPHeaderField:ACCEPT_TYPE_HEADER];
    [request addValue:DEVICE_STATUS_VERSION_TYPE forHTTPHeaderField:VERSION_TYPE_HEADER];
    [request addValue:CONTENT_TYPE_VALUE_JSON forHTTPHeaderField:CONTENT_TYPE_KEY];
    [request setHTTPMethod:HTTP_POST_METHOD];
    [request setHTTPBody:[self getDeviceStatusData]];
    return request;
}

/**
 * Build the replenish request for the slot.
 * @param slotID ID of the slot to replenish.
 * @return The NSURLRequest for the replenish slot command.
 */
- (NSURLRequest *)buildReplenishRequestForSlot:(NSString *)slotID {
    NSMutableURLRequest *request = [self buidlRequestForPaths:@[REPLENISH_PATH, slotID]];
    [request addValue:REPLENISH_ACCEPT_TYPE forHTTPHeaderField:ACCEPT_TYPE_HEADER];
    [request addValue:REPLENISH_VERSION_TYPE forHTTPHeaderField:VERSION_TYPE_HEADER];
    [request setHTTPMethod:HTTP_POST_METHOD];
    return request;
}

/**
 * Build the status request for the slot.
 * @param slotID ID of the slot.
 * @return The NSURLRequest for the slot status command.
 */
- (NSURLRequest *)buildSlotStatusRequestForSlot:(NSString *)slotID {
    NSMutableURLRequest *request = [self buidlRequestForPaths:@[SLOT_STATUS_PATH, slotID]];
    [request setHTTPBody:[self getSlotStatusForSlot:slotID]];
    [request addValue:SLOT_STATUS_ACCEPT_TYPE forHTTPHeaderField:ACCEPT_TYPE_HEADER];
    [request addValue:SLOT_STATUS_VERSION_TYPE forHTTPHeaderField:VERSION_TYPE_HEADER];
    [request setHTTPMethod:HTTP_POST_METHOD];
    [request addValue:CONTENT_TYPE_VALUE_JSON forHTTPHeaderField:CONTENT_TYPE_KEY];
    return request;
}

/**
 * Build the deregistration request.
 * @return The NSURLRequest for deregister device command.
 */
- (NSURLRequest *)buildDeregisterDeviceRequest {
    NSMutableURLRequest *request = [self buidlRequestForPaths:@[REGISTRATION_PATH]];
    [request addValue:DEREGISTRATION_ACCEPT_TYPE forHTTPHeaderField:ACCEPT_TYPE_HEADER];
    [request addValue:DEREGISTRATION_VERSION_TYPE forHTTPHeaderField:VERSION_TYPE_HEADER];
    [request setHTTPMethod:HTTP_DELETE_METHOD];
    return request;
}

/**
 * Build the subscription request.
 * @return The NSURLRequest for the subscription info command.
 */
- (NSURLRequest *)buildSubscriptionInfoRequest {
    NSMutableURLRequest *request = [self buidlRequestForPaths:@[SUBSCRIPTION_INFO_PATH]];
    [request addValue:SUBSCRIPTION_INFO_ACCEPT_TYPE forHTTPHeaderField:ACCEPT_TYPE_HEADER];
    [request addValue:SUBSCRIPTION_INFO_VERSION_TYPE forHTTPHeaderField:VERSION_TYPE_HEADER];
    [request setHTTPMethod:HTTP_GET_METHOD];
    return request;
}

/**
 * Build the cancel test order request.
 * @param slotID ID of the slot. If slot ID is not submited will return the 'cancel all test orders' request.
 * @return The NSURLRequest for the cancel test order command.
 */
- (NSURLRequest *)buildCancelTestOrderRequest:(NSString *)slotID {
    NSMutableURLRequest *request;
    if ([slotID length] > 0) {
        request = [self buidlRequestForPaths:@[CANCEL_TEST_ORDER_BASE_PATH, CANCEL_TEST_ORDER_PATH, slotID]];
    } else {
        request = [self buidlRequestForPaths:@[CANCEL_TEST_ORDER_BASE_PATH]];
    }
    
    [request addValue:CANCEL_TEST_ORDER_ACCEPT_VERSION forHTTPHeaderField:ACCEPT_TYPE_HEADER];
    [request addValue:CANCEL_TEST_ORDER_VERSION_TYPE forHTTPHeaderField:VERSION_TYPE_HEADER];
    [request setHTTPMethod:HTTP_DELETE_METHOD];
    return request;
}

/**
 * Get the device status data.
 * @return The sample device status data.
 */
- (NSData *)getDeviceStatusData {
    return [SAMPLE_DEVICE_STATUS_DATA dataUsingEncoding:NSUTF8StringEncoding];
}

/**
 * Get the slot status data.
 * @param slotID The id of the slot.
 * @return The sample slot status data.
 */
- (NSData *)getSlotStatusForSlot:(NSString *)slotID {
    return [SAMPLE_SLOT_STATUS_DATA dataUsingEncoding:NSUTF8StringEncoding];
}

/**
 * Build the NSMutableURLRequest.
 * @param paths Array of parameters for the URL request.
 * @return URL request.
 */
- (NSMutableURLRequest *)buidlRequestForPaths:(NSArray *)paths {
    NSURL *url = [DrsUtil buildURLforHost:HOST_PATH withPaths:paths andParam:nil urlEncodeParam:YES];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:url];
    return request;
}

/**
 * Build the NSURLSession.
 * @return The NSURLSession.
 */
- (NSURLSession *)buildSession {
    NSString *authorizationToken = [NSString stringWithFormat:@"%@%@", BEARER, [self.drsHandler loadAccessToken]];
    NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
    config.HTTPAdditionalHeaders = @{AUTHORIZATION_HEADER: authorizationToken,};
    NSURLSession *session = [NSURLSession sessionWithConfiguration: config];
    return session;
}

#pragma mark - Request executor

/**
 * Execute the request.
 * @param request Request which needs to be executed.
 */
- (void)executeRequest:(NSURLRequest *)request
         finishHandler:(ResponseHandler)handler {
    NSURLSession *session = [self buildSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:handler];
    [task resume];
    [session finishTasksAndInvalidate];
}

#pragma mark - Output

/**
 * Handle the successful response.
 * @param data The data from the response.
 */
- (void)handleSuccessResponse:(NSData *)data {
    NSString *body = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    [self displayOutput:body];
}

/**
 * Handle the error.
 * @param error The error data from the response.
 */
- (void)handleErrorResponse:(NSError *)error {
    [self displayOutput:[error localizedDescription]];
}

/**
 * Sends the NSString output to the '[DrsDeviceProtocol handleOutputMessage]' method on the main thread.
 * @param output The raw output of the request.
 */
- (void)displayOutput:(NSString *)output {
    if (nil == output) {
        output = [NSString string];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.drsHandler handleOutputMessage:output];
    });
}

/**
 * Parse the slots names from the JSON response and forward it to the DrsDeviceProtocol object on the main thread.
 * @param data A response data which contains slots names.
 */
- (void)handleSlotNamesOutput:(NSData *)data {
    NSError *parsingError = nil;
    
    // Parse the data.
    NSMutableDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data
                                                                      options:NSJSONReadingMutableContainers
                                                                        error:&parsingError];
    
    if(parsingError) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self handleErrorResponse:parsingError];
        });
        return;
    }
    
    NSDictionary *slotNamesDictionary = dictionary[SLOTS_SUBSCRIPTION_STATUS];
    NSArray *slotsNames = [slotNamesDictionary allKeys];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.drsHandler saveSlotNames:slotsNames];
    });
}

@end
