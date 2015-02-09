//
//  LDCTesseractImageRecognizerPlugin.m
//
//  Version 0.0.1
//
//  The MIT License (MIT)
//
//  Copyright (c) 2015 Paulo Miguel Almeida Rodenas <paulo.ubuntu@gmail.com>
//
//  Get the latest version from here:
//
//  https://github.com/pauloubuntu/cordova-plugin-tesseract-camera
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//
#import "LDCTesseractImageRecognizerPlugin.h"

@implementation LDCTesseractImageRecognizerPlugin

-(void)recognizeImage:(CDVInvokedUrlCommand *)command
{
    NSString* imageData = (NSString*)[command.arguments objectAtIndex:0];
    NSString* charWhiteList = (NSString*)[command.arguments objectAtIndex:1 withDefault:nil];
    
    __weak LDCTesseractImageRecognizerPlugin* weakSelf = self;
    
    [self.commandDelegate runInBackground:^{
        
        LDCTesseractImageRecognizer* tesseract = [[LDCTesseractImageRecognizer alloc] init];
        
        UIImage* imageToBeRecognized = [imageData imageFromBase64String];
        
        [tesseract recognizeText:imageToBeRecognized AndCharWhitelist:charWhiteList AndCompletion:^(G8Tesseract *tesseract) {
            
            // Fetch the recognized text
            NSString *recognizedText = tesseract.recognizedText;
        
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:recognizedText];
            [weakSelf.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        }];
        
    }];
    
}

-(UIImage*) imageFromBase64String:(NSString*) base64String{
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:base64String options:NSDataBase64DecodingIgnoreUnknownCharacters];
    return [UIImage imageWithData:decodedData];
}
@end
