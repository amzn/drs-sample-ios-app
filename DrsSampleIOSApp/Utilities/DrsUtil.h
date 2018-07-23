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


#import <Foundation/Foundation.h>

/**
 * Helper class. Contains multiple static methods needed across the application.
 */
@interface DrsUtil : NSObject

/**
 * Web view controller identifier. If you are changing this value, you need to update AMZNUIWebViewController's Storyboard ID inside Main.storyboard.
 */
extern NSString *const WEBVIEW_CONTROLLER_CONST;

/**
 * Web view controller identifier. If you are changing this value, you need to update ViewController's Storyboard ID inside Main.storyboard.
 */
extern NSString *const MAIN_VIEW_CONTROLLER_CONST;

/**
 * Generates the random device serial number.
 * @return The random string.
 */
+ (NSString *)generateRandomDSN;

/**
 * Build the teaser URL.
 * @return The teaser URL.
 */
+ (NSURL *)getTeaserURL;

/**
 * Build the settings page url.
 * @param accessToken The access token needed to build the URL.
 * @return The URL for the settings page.
 */
+ (NSURL *)getSettingsPageURLWithToken:(NSString *)accessToken;

/**
 * Check if the input is valid. Not null and not longer than 64 characters.
 * @param input The NSString input to be checked.
 */
+ (BOOL)isValidInput:(NSString *)input;

/**
 * Return YES if the string is not nil and the length is greater than 0.
 * @param input The NSString input to be checked.
 */
+ (BOOL)isNotEmpty:(NSString *)input;

/**
 * Save the NSString value for a key.
 * @param value NSString value.
 * @param key NSString key.
 */
+ (void)saveString:(NSString *)value forKey:(NSString *)key;

/**
 * Load the NSString value for a key.
 * @param key NSString key.
 * @return The NSString value.
 */
+ (NSString *)loadStringForKey:(NSString *)key;

/**
 * Save the BOOL value for a key.
 * @param value Value to save.
 * @param key The key for the value.
 */
+ (void)saveBOOL:(BOOL)value forKey:(NSString *)key;

/**
 * Load the BOOL value for a key.
 * @param key The key under which the value is saved.
 * @return The BOOL value.
 */
+ (BOOL)loadBOOLForKey:(NSString *)key;

/**
 * Transform the NSDictionary to an URL format string.
 * Example dictionary @{ key1 : value, key2 : value2 } -> output is: @"key1=value1&key2=value2"
 * @param param NSDictionary to encode.
 * @param encode The BOLL YES if the dictionary should be URL encoded, NO otherwise.
 * @return The URL encoded NSString.
 */
+ (NSString *)flatNSDictionaryToURLString:(NSDictionary *)param urlEncode:(BOOL)encode;

/**
 * Get the proper value for the 'isTest' constant.
 * @return 'true' or 'false' depending on the isTest input parameter.
 */
+ (NSString *)getIsTestDeviceString:(BOOL)isTest;

/**
 * URL encoding. Encodes all non alphanumeric characters.
 * @param inputString The NSString to encode.
 * @return The URL encoded NSString.
 */
+ (NSString *)urlEncodeString:(NSString *)inputString;

/**
 * Build the NSURL.
 * @param host The host value. The base of the URL.
 * @param paths The array of the paths which needs to be appended to the URL.
 * @param param The array of the parameters.
 * @param urlEncode BOOL urlEncode. If set to NO, if paths or parameters contains illegal URL char, will return nil.
 * @return The NSURL object. Can return nil if URL contains illegal characters, and urlEncode is set to NO.
 */
+ (NSURL *)buildURLforHost:(NSString *)host
                 withPaths:(NSArray *)paths
                  andParam:(NSDictionary *)param
            urlEncodeParam:(BOOL)urlEncode;

@end
