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


#import "DrsUtil.h"
#import "Constants.h"

@implementation DrsUtil

/**
 * Web view controller identifier. If you are changing this value, you need to update AMZNUIWebViewController's Storyboard ID inside Main.storyboard.
 */
NSString *const WEBVIEW_CONTROLLER_CONST = @"WebViewControllerID";

/**
 * Web view controller identifier. If you are changing this value, you need to update ViewController's Storyboard ID inside Main.storyboard.
 */
NSString *const MAIN_VIEW_CONTROLLER_CONST = @"MainViewControllerID";

/**
 * The device serial number size.
 */
static const int DSN_SIZE = 32;

/**
 * The maximum input string.
 */
static const int MAX_INPUT_SIZE = 64;

/**
 * The acceptable alpha numeric value for the device serial number (DSN).
 */
NSString *const alphaNumericString = @"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789";

/**
 * The regex pattern for a valid device serial number and model ID.
 */
NSString *const PATTERN = @"[[\\w]|[+_-]]+";

+ (NSString *)generateRandomDSN {
    NSString *dsn = [self generateRandomString:DSN_SIZE];
    return dsn;
}

+ (NSURL *)getTeaserURL {
    NSString *compositeID = [DrsUtil loadStringForKey:COMPOSITE_ID_CONST];
    NSDictionary *params = @{REMINDER_URI_CONST: REMINDER_URI_VALUE,
                             LOGIN_URI_CONST: LOGIN_URI_VALUE,
                             SKIP_URI_CONST: SKIP_URI_VALUE,
                             COMPOSITE_ID_CONST: compositeID,
                             CLIENT_ID_CONST: CLIENT_ID_VALUE};

    return [self buildURLforHost:LAUNCH_PAGE_URL
                       withPaths:@[ACCIOCUSTOMERUI_CONST, TEASER_CONST]
                        andParam:params
                  urlEncodeParam:NO];
}

+ (NSURL *)getSettingsPageURLWithToken:(NSString *)accessToken {
    NSMutableDictionary *params = NSMutableDictionary.new;
    if (accessToken.length != 0) {
        params[ACCESS_TOKEN_CONST] = accessToken;
    }
    params[EXIT_URI_CONST] = EXIT_URL_PATH;

    return [self buildURLforHost:LAUNCH_PAGE_URL
                       withPaths:@[SETTINGS_PATH]
                        andParam:params
                  urlEncodeParam:YES];
}

+ (BOOL)isValidInput:(NSString *)input {
    if (![self isNotEmpty:input] || [input length] >= MAX_INPUT_SIZE) {
        return NO;
    }
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", PATTERN];
    return [regexTest evaluateWithObject:input];
}

+ (BOOL)isNotEmpty:(NSString *)input {
    return [input length] != 0;
}

+ (void)saveString:(NSString *)value forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:key];
}

+ (NSString *)loadStringForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] stringForKey:key];
}

+ (void)saveBOOL:(BOOL)value forKey:(NSString *)key {
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
}

+ (BOOL)loadBOOLForKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] boolForKey:key];
}

+ (NSString *)flatNSDictionaryToURLString:(NSDictionary *)params urlEncode:(BOOL)encode {
    if (nil != params && [params count] != 0) {
        NSMutableString *output = NSMutableString.new;
        for (NSString *key in params) {
            [output appendString:encode ? [self urlEncodeString:key] : key];
            [output appendString:@"="];
            [output appendString:encode ? [self urlEncodeString:params[key]] : params[key]];
            [output appendString:@"&"];
        }
        [output deleteCharactersInRange:NSMakeRange([output length] - 1, 1)];
        return output;
    }
    return [NSString string];

}

+ (NSString *)getIsTestDeviceString:(BOOL)isTest {
    if (isTest) {
        return TRUE_STRING;
    } else {
        return FALSE_STRING;
    }
}

+ (NSString *)urlEncodeString:(NSString *)inputString {
    NSString *encodedUrl = [inputString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet alphanumericCharacterSet]];
    return encodedUrl;
}

+ (NSURL *)buildURLforHost:(NSString *)host
                 withPaths:(NSArray *)paths
                  andParam:(NSDictionary *)params
            urlEncodeParam:(BOOL)urlEncode {
    NSMutableString *url = NSMutableString.new;
    if (host.length != 0) {
        [url appendString:host];
        if ([paths count] != 0) {
            for (NSString *path in paths) {
                if (path.length != 0) {
                    [url appendString:@"/"];
                    [url appendString:urlEncode ? [self urlEncodeString:path] : path];
                }
            }
        }
        if ([params count] != 0) {
            [url appendString:@"?"];
            [url appendString:[self flatNSDictionaryToURLString:params urlEncode:urlEncode]];
        }
    }
    return [NSURL URLWithString:url];
}

#pragma mark - Private methods

/**
 * Generates the random string from the 'alphaNumericString'.
 * @param size The int size of the generated string.
 * @return The random NSString.
 */
+ (NSString *)generateRandomString:(int)size {
    NSMutableString *output = [NSMutableString stringWithCapacity:size];
    
    for (int i = 0; i < size; i++) {
        [output appendFormat:@"%C",
         [alphaNumericString characterAtIndex:arc4random_uniform((uint32_t) [alphaNumericString length])]];
    }
    return output;
}

@end
