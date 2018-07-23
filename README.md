
# DRS Sample iOS Application

Dash Replenishment Service (DRS) sample application shows how to integrate with Login With Amazon and how to call the Dash Replenishment Service APIs.
Creating a DRS-enabled device requires you to become a part of our developer program and agree to the DRS terms and conditions, as well as other agreements, including our App Distribution and Services Agreement and the Login with Amazon Services Agreement.
Learn more at [developer.amazon.com](https://developer.amazon.com/dash-replenishment-service).

## Description

In the sample application you can:
* Inspect all the DRS responses
* Inspect and modify the refresh and access tokens
* Obtain or manually enter slot IDs
* Call all the DRS APIs

The provided code mimics the DRS device with the model identifier 'ACN-S656-YXZ' and the companion iOS application.
The sample DRS device was created in [Self-Service portal](https://developer.amazon.com/dash-replenishment/index.html) with two slots and a few ASINs in each slot, alongside with an [LWA Security Profile](https://developer.amazon.com/docs/dash/create-a-security-profile.html) and a default [SNS Topic](https://developer.amazon.com/docs/dash/create-an-sns-topic.html). The code can be logically split into two sections:
- Companion Application
- DRS Device

How to solve the communication between the companion application and the DRS device is out of the scope of this project, and we assume they can communicate over a secure channel.

### Companion application

The first three ViewControllers in the application demonstrate a simple companion application where the user can enter the model ID and the serial number of the DRS device. The `Composite ID`, `Random DSN` button and `is test device` switch are here for testing purposes and they must not be present in the final application available to users.
The third ViewController will load the WebView which will display a [DRS Teaser Page](https://developer.amazon.com/docs/dash/teaser-page.html) generated out of the composite ID.
In the next ViewController, an LWA login page is presented. The following authorization and DRS setup workflow is owned and maintained by Amazon. The end user needs to authorize the LWA application security profile to perform operations on his behalf, and select what kind of product his device will purchase. Upon successful completion, the user is brought back to the DrsSampleIOSApp. The last ViewController allows placing calls to DRS endpoints, mimicking a call from the DRS device, alongside with companion applications Login, Logout and Settings functionalities.

### DRS device

After you complete the first steps and successfully login, the application mimic the behaviour of a DRS device. You can see how to call different DRS APIs and what their responses are.
DRS APIs:
* [Replenish](https://developer.amazon.com/docs/dash/replenish-endpoint.html)
* [Slot status](https://developer.amazon.com/docs/dash/slotstatus-endpoint.html)
* [Device status](https://developer.amazon.com/docs/dash/devicestatus-endpoint.html)
* [Subscription info](https://developer.amazon.com/docs/dash/getsubscriptioninfo-endpoint.html)
* [Deregistration](https://developer.amazon.com/docs/dash/deregistration-endpoint.html)
* [Cancel Test Order](https://developer.amazon.com/docs/dash/canceltestorder-endpoint.html)
* [Get Order Info](https://developer.amazon.com/docs/dash/getorderinfo-endpoint.html)

Additional functionality of the companion app:
* Login - calls the login again
* Logout
* Settings - opens the consumable settings if you want to select a different product, change the shipping address or the payment method.

## Getting Started

1.  Pull down the code locally.
2.  In the 'DrsSampleIOSApp' folder open 'DrsSampleIOSApp.xcodeproj' with Xcode
3.  Run the application.

## Making changes

If you want to test your settings with the DrsSampleIOSApp you will need to make some changes:
* In the `Constants.h` change the `SAMPLE_DEVICE_NAME`
* In the `Constants.h` change the `CLIENT_ID_VALUE`
* Optional, in the `Constants.h` change the `COMPOSITE_ID_VALUE`. Amazon will provide you with `COMPOSITE_ID_VALUE` once you go through certification process on the Self-Service portal.
* In the `Info.plist` change the APIKey
* In the `Info.plist` change the `URL identifier`
* In the `Info.plist` change the `URL Schemes`
* In the `DrsSampleIOSApp` change the `Bundle Identifier`

## Additional information

* [DRS program](https://developer.amazon.com/public/solutions/devices/dash-replenishment-service)
* [DRS API](https://developer.amazon.com/public/solutions/devices/dash-replenishment-service/docs/dash-replenish-endpoint)
* [Login With Amazon](https://developer.amazon.com/public/apis/engage/login-with-amazon/content/documentation.html)
* [LWA Security Profile](https://developer.amazon.com/public/solutions/devices/dash-replenishment-service/docs/dash-create-a-security-profile)
* [SNS Topic](https://developer.amazon.com/public/solutions/devices/dash-replenishment-service/docs/dash-create-an-sns-topic)
* [Self Service portal](https://developer.amazon.com/dash-replenishment/index.html)


