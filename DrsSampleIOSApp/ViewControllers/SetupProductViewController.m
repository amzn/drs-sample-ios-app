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

#import "SetupProductViewController.h"
#import "DrsUtil.h"
#import "Constants.h"
#import "AMZNUIWebViewController.h"

@interface SetupProductViewController () <UITextFieldDelegate>

/**
 * Enum for distinguishing UITextFields.
 */
typedef NS_ENUM(NSUInteger, TextFieldTag) {
    MODEL_TAG = 1,
    SERIAL_TAG = 2
};

@end

#pragma mark -

@implementation SetupProductViewController

/**
 * UIAlertController title.
 */
static NSString *const POPUP_TITLE = @"Invalid input";

/**
 * UIAlertController message text.
 */
static NSString *const INVALID_INPUT_MESSAGE = @"Please correct your input";

/**
 * UIAlertController button text.
 */
static NSString *const OK_BUTTON = @"OK";

#pragma mark - UIViewController overrides

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initializeView];
    [self populateView];
}

#pragma mark - Controller initialization

/**
 * Initialize a view.
 */
- (void)initializeView {
    self.deviceSerialTextField.delegate = self;
    self.deviceModelTextField.delegate = self;
    self.compositeIDTextField.delegate = self;

    self.deviceModelTextField.tag = MODEL_TAG;
    self.deviceSerialTextField.tag = SERIAL_TAG;
}

/**
 * Populate a view.
 */
- (void)populateView {
    NSString *deviceModel = [DrsUtil loadStringForKey:DEVICE_MODEL_CONST];
    NSString *deviceSerial = [DrsUtil loadStringForKey:DEVICE_SERIAL_CONST];
    NSString *compositeID = [DrsUtil loadStringForKey:COMPOSITE_ID_CONST];
    
    if (![DrsUtil isValidInput:deviceModel]) {
        deviceModel = SAMPLE_DEVICE_NAME;
        [DrsUtil saveString:deviceModel forKey:DEVICE_MODEL_CONST];
    }
    if (![DrsUtil isValidInput:deviceSerial]) {
        deviceSerial = [DrsUtil generateRandomDSN];
        [DrsUtil saveString:deviceSerial forKey:DEVICE_SERIAL_CONST];
    }
    if (![DrsUtil isNotEmpty:compositeID]) {
        compositeID = COMPOSITE_ID_VALUE;
        [DrsUtil saveString:compositeID forKey:COMPOSITE_ID_CONST];
    }
    
    self.deviceModelTextField.text = deviceModel;
    self.deviceSerialTextField.text = deviceSerial;
    self.compositeIDTextField.text = compositeID;
}

#pragma mark - UITextFieldDelegate implementation

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField endEditing:YES];
    return YES;
}

#pragma mark - UIResponders

/**
 * Generate a random DSN button and populate a view with a new value.
 * @param sender The button which was pressed.
 */
- (IBAction)generateRandomDSN:(id)sender {
    [DrsUtil saveString:self.deviceModelTextField.text forKey:DEVICE_MODEL_CONST];
    [DrsUtil saveString:[DrsUtil generateRandomDSN] forKey:DEVICE_SERIAL_CONST];
    [self populateView];
}

/**
 * Continue button interceptor. Proceed to next view.
 * @param sender The button which was pressed.
 */
- (IBAction)continueButtonPressed:(id)sender {
    if ([DrsUtil isValidInput:[[self deviceModelTextField] text]] &&
            [DrsUtil isValidInput:[[self deviceSerialTextField] text]] &&
            [DrsUtil isNotEmpty:[[self compositeIDTextField] text]]) {
        
        [self saveIsTestDevice];
        [self saveIncludeNonLiveDevices];
        [DrsUtil saveString:self.deviceModelTextField.text forKey:DEVICE_MODEL_CONST];
        [DrsUtil saveString:self.deviceSerialTextField.text forKey:DEVICE_SERIAL_CONST];
        [DrsUtil saveString:self.compositeIDTextField.text forKey:COMPOSITE_ID_CONST];
        
        AMZNUIWebViewController *viewController = [self getAMAZNUIWebViewControllerWithUrl:[DrsUtil getTeaserURL]];
        UINavigationController *parentController = self.navigationController;
        [parentController pushViewController:viewController animated:YES];
    } else {
        [self displayAlertWithTitle:POPUP_TITLE andMessage:INVALID_INPUT_MESSAGE];
    }
}

/**
 * Save is this device a test device.
 */
- (void)saveIsTestDevice {
    [DrsUtil saveBOOL:self.isTestDevice.isOn forKey:IS_TEST_DEVICE_CONST];
}

/*
 * Whether or not we should include non-live devices.
 */
- (void)saveIncludeNonLiveDevices {
    [DrsUtil saveBOOL:self.includeNonLiveDevicesSwitch.isOn forKey:INCLUDE_NON_LIVE_DEVICES];
}

#pragma mark - UIAlertController

/**
 * Display alert box.
 * @param title The alert title.
 * @param message The alert message.
 */
- (void)displayAlertWithTitle:(NSString *)title andMessage:(NSString *)message {
    UIAlertController *alert = [UIAlertController
            alertControllerWithTitle:title
                             message:message
                      preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *okButton = [UIAlertAction
            actionWithTitle:OK_BUTTON
                      style:UIAlertActionStyleDefault
                    handler:nil];

    [alert addAction:okButton];

    [self presentViewController:alert animated:YES completion:nil];
}

@end
