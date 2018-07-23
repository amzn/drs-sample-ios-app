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


#import "Constants.h"

#define DRS_PREFIX   @"com.amazon.dash.replenishment."

@implementation Constants

/*
 * URL constants.
 */
NSString *const LAUNCH_PAGE_URL = @"https://drs-web.amazon.com";
NSString *const PATH = @"https://api.amazon.com/auth/O2/token";
NSString *const HOST_PATH = @"https://dash-replenishment-service-na.amazon.com";
NSString *const ACCIOCUSTOMERUI_CONST = @"AccioCustomerUI";
NSString *const TEASER_CONST = @"teaser";
NSString *const DEVICE_STATUS_PATH = @"deviceStatus";
NSString *const REGISTRATION_PATH = @"registration";
NSString *const REPLENISH_PATH = @"replenish";
NSString *const SLOT_STATUS_PATH = @"slotStatus";
NSString *const SETTINGS_PATH = @"settings";
NSString *const EXIT_URL_PATH = @"/null";
NSString *const SUBSCRIPTION_INFO_PATH = @"subscriptionInfo";
NSString *const CANCEL_TEST_ORDER_BASE_PATH = @"testOrders";
NSString *const CANCEL_TEST_ORDER_PATH = @"slots";

/*
 * Build URL constants.
 */
NSString *const HTTP_POST_METHOD = @"POST";
NSString *const HTTP_DELETE_METHOD = @"DELETE";
NSString *const HTTP_GET_METHOD = @"GET";
NSString *const REMINDER_URI_CONST = @"remindLaterUri";
NSString *const LOGIN_URI_CONST = @"loginUri";
NSString *const SKIP_URI_CONST = @"skipUri";
NSString *const COMPOSITE_ID_CONST = @"compositeId";
NSString *const CLIENT_ID_CONST = @"client_id";
NSString *const LWA_GRANT_TYPE_CONST = @"grant_type";
NSString *const LWA_AUTH_CODE_CONST = @"authorization_code";
NSString *const LWA_CODE_CONST = @"code";
NSString *const LWA_REDIRECT_URI_CONST = @"redirect_uri";
NSString *const LWA_CODE_VERIFIER_CONST = @"code_verifier";
NSString *const ACCESS_TOKEN_CONST = @"access_token";
NSString *const REFRESH_TOKEN_CONST = @"refresh_token";
NSString *const EXIT_URI_CONST = @"exitUri";
NSString *const DEVICE_MODEL_CONST = @"device_model";
NSString *const IS_TEST_DEVICE_CONST = @"is_test_device";
NSString *const INCLUDE_NON_LIVE_DEVICES = @"should_include_non_live";
NSString *const DEVICE_SERIAL_CONST = @"serial";
NSString *const SHA_256 = @"S256";

/*
 * HTTP Headers.
 */
NSString *const BEARER = @"Bearer ";
NSString *const AUTHORIZATION_HEADER = @"Authorization";
NSString *const ACCEPT_TYPE_HEADER = @"x-amzn-accept-type";
NSString *const VERSION_TYPE_HEADER = @"x-amzn-type-version";
NSString *const CONTENT_TYPE_KEY = @"Content-Type";
NSString *const CONTENT_TYPE_VALUE_JSON = @"application/json";

/*
 * Build teaser URL values.
 */
NSString *const REMINDER_URI_VALUE = @"RemindMeLater";
NSString *const LOGIN_URI_VALUE = @"LoginWeb";
NSString *const SKIP_URI_VALUE = @"Skip";
NSString *const BACK_URI_VALUE = @"Back";

/*
 * Scope of the login request.
 */
NSString *const LOGIN_SCOPE_CONST = @"dash:replenish";

NSString *const DEREGISTRATION_ACCEPT_TYPE = DRS_PREFIX @"DrsDeregisterResult@1.0";
NSString *const DEREGISTRATION_VERSION_TYPE = DRS_PREFIX @"DrsDeregisterInput@2.0";
NSString *const REPLENISH_ACCEPT_TYPE = DRS_PREFIX @"DrsReplenishResult@1.0";
NSString *const REPLENISH_VERSION_TYPE = DRS_PREFIX @"DrsReplenishInput@1.0";
NSString *const SLOT_STATUS_ACCEPT_TYPE = DRS_PREFIX @"DrsSlotStatusResult@1.0";
NSString *const SLOT_STATUS_VERSION_TYPE = DRS_PREFIX @"DrsSlotStatusInput@1.0";
NSString *const DEVICE_STATUS_ACCEPT_TYPE = DRS_PREFIX @"DrsDeviceStatusResult@1.0";
NSString *const DEVICE_STATUS_VERSION_TYPE = DRS_PREFIX @"DrsDeviceStatusInput@1.0";
NSString *const SUBSCRIPTION_INFO_ACCEPT_TYPE = DRS_PREFIX @"DrsSubscriptionInfoResult@2.0";
NSString *const SUBSCRIPTION_INFO_VERSION_TYPE = DRS_PREFIX @"DrsSubscriptionInfoInput@1.0";
NSString *const CANCEL_TEST_ORDER_ACCEPT_VERSION = DRS_PREFIX @"DrsCancelTestOrdersResult@1.0";
NSString *const CANCEL_TEST_ORDER_VERSION_TYPE = DRS_PREFIX @"DrsCancelTestOrdersInput@1.0";

NSString *const TRUE_STRING = @"true";
NSString *const FALSE_STRING = @"false";

NSString *const COMPOSITE_ID_VALUE = @"amzn1.dash.v1.composite.315d909f-e392-4040-8dba-48f8ec170a1c";
NSString *const CLIENT_ID_VALUE = @"amzn1.application-oa2-client.8b2ea609179a4bf9a73ca6171ac9b3fc";
NSString *const SAMPLE_DEVICE_NAME = @"ACM-S656-XYZ";

/*
 * Sample data.
 */
NSString *const SAMPLE_DEVICE_STATUS_DATA = @"{\"mostRecentlyActiveDate\":\"2015-06-01\"}";
NSString *const SAMPLE_SLOT_STATUS_DATA = @"{\"lastUseDate\":\"2015-06-01\","
                                           "\"remainingQuantityInUnit\":1,"
                                           "\"originalQuantityInUnit\":2,"
                                           "\"expectedReplenishmentDate\":\"2015-06-7\","
                                           "\"totalQuantityOnHand\":20}";

@end
