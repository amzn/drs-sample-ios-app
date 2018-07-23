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

#import "DRSMainViewController.h"
#import "IdentityHandler.h"
#import "Constants.h"
#import "DrsUtil.h"
#import "CommunicationUtil.h"
#import "AMZNUIWebViewController.h"


@interface DRSMainViewController ()

/**
 * The slot picker control.
 */
@property(nonatomic, strong) UIPickerView *slotPicker;

/**
 * The slot picker toolbar.
 */
@property(nonatomic, strong) UIView *slotPickerToolbar;

/**
 * Slots names array. Used in picker view.
 */
@property(nonatomic, strong) NSArray *slotNames;

@end

#pragma mark -

@implementation DRSMainViewController

/**
 * An IdentityHandler used for login and logout.
 */
IdentityHandler *identityHandler;

/**
 * A CommunicationUtil object used for sending commands.
 */
CommunicationUtil *communicationUtil;

/**
 * Indicates is this a first time that this view is loading.
 */
BOOL viewLoaded;

/**
 * Controller title.
 */
NSString *const MAIN_TITLE = @"Sample DRS Device";

/**
 * Toolbar height.
 */
CGFloat const TOOLBAR_HEIGHT = 44;

/**
 * Done button text.
 */
NSString *const DONE_BUTTON = @"Done";

/**
 * Number of components in the picker view.
 */
NSInteger const NUMBER_OF_COMPONENTS = 1;

/**
 * Used to store an offset.
 * When we are displaying a keyboard, we store a current offset and restore the scroll view to this offset once we close a keyboard.
 */
CGFloat scrollViewOffset;

#pragma mark - UIViewController overrides

- (void)viewDidLoad {
    [super viewDidLoad];
    [self registerTapGesture];
    [self initializeView];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self populateView];
    if (!viewLoaded) {
        [identityHandler login];
        viewLoaded = YES;
    }
}

#pragma mark - Controller initialization

/**
 * Initialize a view.
 */
- (void)initializeView {
    identityHandler = [self getIdentityHandler];
    communicationUtil = [self getCommunicationUtil];

    [self initializeSlotPicker];
    [self initializeSlotPickerToolbar];
    
    self.slotIDTextField.inputAccessoryView = self.slotPickerToolbar;
    self.accessTokenTextField.delegate = self;
    self.refreshTokenTextField.delegate = self;
    self.slotIDTextField.delegate = self;

    self.slotPicker.dataSource = self;
    self.slotPicker.delegate = self;
}

/**
 * Initialize a slot picker toolbar.
 */
- (void)initializeSlotPickerToolbar {
    if (!self.slotPickerToolbar) {
        UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, TOOLBAR_HEIGHT)];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithTitle:DONE_BUTTON
                                                                       style:UIBarButtonItemStyleDone
                                                                      target:self
                                                                      action:@selector(slotPickerDone:)];
        [toolbar setItems:@[doneButton] animated:NO];
        self.slotPickerToolbar = toolbar;
    }
}

/**
 * Initialize a slot picker.
 */
- (void)initializeSlotPicker {
    if (!self.slotPicker) {
        self.slotPicker = [[UIPickerView alloc] init];
    }
}

/**
 * When a keyboard is displayed, click outside of it will minimize it.
 */
- (void)registerTapGesture {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(slotPickerDone:)];
    [self.view addGestureRecognizer:tap];
    
}

/**
 * Populate a view with default values.
 */
- (void)populateView {
    self.title = MAIN_TITLE;
    [self.navigationItem.backBarButtonItem setTitle:@"Back"];
    self.deviceModelLabel.text = [DrsUtil loadStringForKey:DEVICE_MODEL_CONST];
    self.deviceSerialLabel.text = [DrsUtil loadStringForKey:DEVICE_SERIAL_CONST];
    [self.testSwitch setOn:[DrsUtil loadBOOLForKey:IS_TEST_DEVICE_CONST]];
    [self.includeNonLiveDevicesSwitch setOn:[DrsUtil loadBOOLForKey:INCLUDE_NON_LIVE_DEVICES]];
}

/**
 * Get the IdentityHandler.
 * @return The IdentityHandler object.
 */
- (IdentityHandler *)getIdentityHandler {
    CodeChallengeGenerator *generator = [CodeChallengeGenerator sharedInstance];
    return [[IdentityHandler alloc] initWithDrsHandler:self andCodeChallengeGenerator:generator];
}

/**
 * Get the CommunicationUtil.
 * @return The CommunicationUtil object.
 */
- (CommunicationUtil *)getCommunicationUtil {
    return [[CommunicationUtil alloc] initWithDrsHandler:self];
}

#pragma mark - UIResponders

/**
 * Login button IBAction. Login and request access and refresh token.
 * @param sender The button which was pressed.
 */
- (IBAction)onLoginButtonClicked:(id)sender {
    [identityHandler login];
}

/**
 * Logout user. Deletes cached user tokens and other data.
 * @param sender The button which was pressed.
 */
- (IBAction)onLogoutButtonClicked:(id)sender {
    [identityHandler logout];
}

/**
 * Send the device status.
 * @param sender The button which was pressed.
 */
- (IBAction)sendDeviceStatus:(id)sender {
    [communicationUtil sendDeviceStatus];
}

/**
 * Send the 'Deregister device' command.
 * @param sender The button which was pressed.
 */
- (IBAction)sendDeregisterDevice:(id)sender {
    [communicationUtil deregisterDevice];
}

/**
 * Send the 'Initiate Replenish' command.
 * @param sender The button which was pressed.
 */
- (IBAction)sendInitiateReplenish:(id)sender {
    [communicationUtil initiateReplenishForSlot:self.slotIDTextField.text];
}

/**
 * Send the slot status.
 * @param sender The button which was pressed.
 */
- (IBAction)sendSlotStatus:(id)sender {
    [communicationUtil sendSlotStatusForSlot:self.slotIDTextField.text];
}

/**
 * Request a new access token. You must have a refresh token.
 * @param sender The button which was pressed.
 */
- (IBAction)getNewAccessToken:(id)sender {
    [identityHandler getNewAccessTokenWithRefreshToken:self.refreshTokenTextField.text];
}

/**
 * Display the ASIN select view.
 * @param sender The button which was pressed.
 */
- (IBAction)onSettingsButtonClicked:(id)sender {
    NSString *accessToken = [self loadAccessToken];
    AMZNUIWebViewController *viewController = [self getAMAZNUIWebViewControllerWithUrl:
                                               [DrsUtil getSettingsPageURLWithToken:accessToken]];
    UINavigationController *parentController = [self navigationController];
    [parentController pushViewController:viewController animated:YES];
}

/*
 * Send the subscription info request.
 * @param sender The button which was pressed.
 */
- (IBAction)sendSubscriptionInfo:(id)sender {
    [communicationUtil sendSubscriptionInfo];
}

/**
 * Send the cancel test order request.
 * Takes the slot ID from the slotIDTextField.
 * @param sender The button which was pressed.
 */
- (IBAction)sendCancelTestOrder:(id)sender {
    [communicationUtil cancelTestOrderForSlot:self.slotIDTextField.text];
}

/**
 * Send the cancel all test oreders request.
 * @param sender The button which was pressed.
 */
- (IBAction)sendCancelAllTestOrders:(id)sender {
    [communicationUtil cancelAllTestOrders];
}

- (IBAction)getSlotNames:(id)sender {
    self.slotIDTextField.inputView = self.slotPicker;
    [self.slotIDTextField becomeFirstResponder];
}

# pragma mark - Private methods

/**
 * Scroll to offset.
 * @param offset The offset where you want to scroll.
 */
- (void)scrollToOffset:(CGFloat)offset {
    CGPoint newOffset = CGPointMake(0, offset);
    [self.scrollView setContentOffset:newOffset animated:YES];
}

/**
 * Minimize the keyboard.
 */
- (void)dismissKeyboard {
    [self.slotIDTextField resignFirstResponder];
    [self.accessTokenTextField resignFirstResponder];
    [self.refreshTokenTextField resignFirstResponder];
    [self scrollToOffset:scrollViewOffset];
}

/**
 * Dismiss a picker view.
 */
- (void)slotPickerDone:(id)sender {
    [self dismissKeyboard];
    [self scrollToOffset:scrollViewOffset];
    NSInteger selectedItem = [self.slotPicker selectedRowInComponent:0];
    self.slotIDTextField.text = self.slotNames[selectedItem];
    self.slotIDTextField.inputView = nil;
}

#pragma mark - DrsDeviceProtocol implementation

- (void)saveDeviceModel:(NSString *)deviceModel {
    self.deviceModelLabel.text = deviceModel;
}

- (NSString *)loadDeviceModel {
    return [[self deviceModelLabel] text];
}

- (void)saveDeviceSerialNumber:(NSString *)deviceSerialNumber {
    [[self deviceModelLabel] setText:deviceSerialNumber];
}

- (NSString *)loadDeviceSerialNumber {
    return [[self deviceSerialLabel] text];
}

- (void)saveAccessToken:(NSString *)accessToken {
    self.accessTokenTextField.text = accessToken;
}

- (NSString *)loadAccessToken {
    return [[self accessTokenTextField] text];
}

- (void)saveRefreshToken:(NSString *)refreshToken {
    self.refreshTokenTextField.text = refreshToken;
}

- (NSString *)loadRefreshToken {
    return [[self refreshTokenTextField] text];
}

- (BOOL)isTestDevice {
    return self.testSwitch.isOn;
}

- (BOOL)includeNonLiveDevices {
    return self.includeNonLiveDevicesSwitch.isOn;
}

- (void)handleOutputMessage:(NSString *)outputMessage {
    self.outputView.text = outputMessage;
}

- (void)saveSlotNames:(NSArray *)slotNames {
    self.slotNames = slotNames;
    [self.slotPicker reloadAllComponents];
}

#pragma mark - UITextFieldDelegate implementation

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    //Intercept 'return' button press and minimize the keyboard.
    [textField endEditing:YES];
    [self scrollToOffset:scrollViewOffset];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (self.slotIDTextField.inputView == self.slotPicker) {
        [communicationUtil sendSubscriptionInfo];
    }
    [self.slotIDTextField reloadInputViews];
    
    scrollViewOffset = self.scrollView.contentOffset.y;
    // Making sure that text field is always visible while typing.
    // Calculate the textField position relative to root view.
    CGPoint textFieldPosition = [self.scrollView convertPoint:self.slotIDTextField.frame.origin toView:nil];
    // Get the half of the screen height.
    CGFloat halfScreenHeight = self.view.frame.size.height / 2;
    // Calculate how much we have to move textField to be in the middle of the screen.
    CGFloat offset = textFieldPosition.y - halfScreenHeight;
    // Add offset to current scroll view offset and add height of the toolbar.
    CGFloat newOffset = self.scrollView.contentOffset.y + offset + TOOLBAR_HEIGHT;
    // Set the new offset.
    [self scrollToOffset:newOffset];
}

#pragma mark - Slot picker implementation

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return NUMBER_OF_COMPONENTS;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.slotNames count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return self.slotNames[row];
}

@end
