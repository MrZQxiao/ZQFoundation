//
//  NSString+MSExtension.m
//  MIS
//
//  Created by LIUZHEN on 2017/2/20.
//  Copyright © 2017年 58. All rights reserved.
//

#import "NSString+ZQExtension.h"
#import <ZQFoundation/UIFont+ZQExtension.h>
#import <CommonCrypto/CommonDigest.h>
#import <ZQFoundation/UIDevice+ZQExtension.h>

@implementation NSString (ZQExtension)

- (NSString *)trim {
    NSCharacterSet *set = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    return [self stringByTrimmingCharactersInSet:set];
}

+ (BOOL)isNotBlank:(NSString *)str {
    return ![self isBlank:str];
}

+ (BOOL)isBlank:(NSString *)str {
    if (str == nil || str == NULL) {
        return YES;
    }
    
    if (![str isKindOfClass:[NSString class]]) {
        return YES;
    }
    
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    
    if ([str isEqualToString:@"null"]) {
        return YES;
    }

    if ([str isEqualToString:@"\"null\""]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isDigit:(NSString *)str {
    NSString *regex = @"[0-9]*";
    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    if ([pred evaluateWithObject:str]) {
        return YES;
    }
    return NO;
}

+ (BOOL)isChinese:(NSString *)str {
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:str];
}

+ (NSString *)disable_emoji:(NSString *)text {
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regex stringByReplacingMatchesInString:text options:0 range:NSMakeRange(0, [text length]) withTemplate:@""];
    return modifiedString;
}

- (NSInteger)convertStringLength {
    NSStringEncoding encode = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    NSData *data = [self dataUsingEncoding:encode];
    return [data length];
}

- (NSInteger)convertStringLength1 {
    int strlength = 0;
    char *p = (char *)[self cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [self lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++) {
        if (*p) {
            p++;
            strlength++;
        } else {
            p++;
        }
    }
    return strlength;
}

+ (NSString *)decreaseBracketsBy:(NSString *)string {
    NSString *newString = [string stringByReplacingOccurrencesOfString:@"(" withString:@""];
    newString = [newString stringByReplacingOccurrencesOfString:@")" withString:@"-"];
    newString = [newString stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    newString = [newString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    newString = [newString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return newString;
}

+ (NSString *)randomWords:(NSInteger)length {
    NSString *words = [NSString new];
    for (int i = 0; i < length; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            words = [words stringByAppendingString:tempString];
        } else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            words = [words stringByAppendingString:tempString];
        }
    }
    return words;
}

+ (NSString *)randomChineseWords:(NSInteger)length {
    NSMutableString *words = [NSMutableString string];
    for (int i = 0; i < length; i++) {
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        NSInteger randomH = 0xA1 + arc4random() % (0xFE - 0xA1+1);
        NSInteger randomL = 0xB0 + arc4random() % (0xF7 - 0xB0+1);
        NSInteger number = (randomH << 8) + randomL;
        NSData *data = [NSData dataWithBytes:&number length:2];
        NSString *word = [[NSString alloc] initWithData:data encoding:gbkEncoding];
        [words appendFormat:@"%@", word];
    }
    return [words copy];
}

- (CGSize)sizeForConstrain:(CGSize)size font:(UIFont *)font {
    return [self boundingRectWithSize:size
                              options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                           attributes:@{NSFontAttributeName : font ?: [UIFont ms_normalFont]}
                              context:nil].size;
}

- (CGSize)sizeForConstrain:(CGSize)size fontSize:(NSInteger)fontSize {
    return [self sizeForConstrain:size font:[UIFont systemFontOfSize:fontSize]];
}

- (CGFloat)getSpaceLabelHeightwithSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font withWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.lineSpacing = lineSpeace;
    NSDictionary *dic = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paraStyle};
    CGSize size = [self boundingRectWithSize:CGSizeMake(width,MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:dic context:nil].size;
    
    //文本的高度减去字体高度小于等于行间距，判断为当前只有1行
    if ((size.height - font.lineHeight) <= paraStyle.lineSpacing) {
        if ([self containChinese:self]) {  //如果包含中文
            return size.height - paraStyle.lineSpacing;
         }
    }
    
    return size.height;
}
    
//判断是否包含中文
- (BOOL)containChinese:(NSString *)str {
    for(int i=0; i< [str length];i++){
        int a = [str characterAtIndex:i];
        if( a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

// 动态计算lable的高度
- (CGFloat)autolableHeightWithFont:(UIFont *)font Width:(CGFloat)width {
    
    CGSize size = CGSizeMake(width, MAXFLOAT);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize  msgSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    return msgSize.height;
}

- (CGFloat)autolableWidthtWithFont:(UIFont *)font {
    
    CGSize size = CGSizeMake(MAXFLOAT, 20);
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGSize  msgSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading  attributes:tdic context:nil].size;
    return msgSize.width;
}

+ (NSString *)randomWDs:(NSInteger)length {
    
    NSString *words = [NSString new];
    for (int i = 0; i < length; i++) {
        int number = arc4random() % 36;
        if (number < 10) {
            int figure = arc4random() % 10;
            NSString *tempString = [NSString stringWithFormat:@"%d", figure];
            words = [words stringByAppendingString:tempString];
        } else {
            int figure = (arc4random() % 26) + 97;
            char character = figure;
            NSString *tempString = [NSString stringWithFormat:@"%c", character];
            words = [words stringByAppendingString:tempString];
        }
    }
    return words;
}

#pragma mark - MD5

- (NSString *)MD5 {
    if ([NSString isBlank:self]) return self;
    
    const char *cStr =[self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (unsigned int)strlen(cStr), result);
    return[NSString stringWithFormat:
           @"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
           result[0], result[1], result[2], result[3],
           result[4], result[5], result[6], result[7],
           result[8], result[9], result[10], result[11],
           result[12], result[13], result[14], result[15]
           ];
}

- (NSString *)SHA1 {
    const char *cstr = [self cStringUsingEncoding:NSUTF8StringEncoding];
    
    NSData *data = [NSData dataWithBytes:cstr length:self.length];
    uint32_t length = (uint32_t)data.length;
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    CC_SHA1(data.bytes, length, digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++) {
        [output appendFormat:@"%02x", digest[i]];
    }
    return output;
}

- (NSData *)stringToByte {
    return [[self class] stringToByte:self];
}

+ (NSData *)stringToByte:(NSString *)string {
    NSString *hexString=[[string uppercaseString] stringByReplacingOccurrencesOfString:@" " withString:@""];
    if ([hexString length]%2!=0) {
        return nil;
    }
    Byte tempbyt[1]={0};
    NSMutableData* bytes=[NSMutableData data];
    for(int i=0;i<[hexString length];i++)
    {
        unichar hex_char1 = [hexString characterAtIndex:i]; ////两位16进制数中的第一位(高位*16)
        int int_ch1;
        if(hex_char1 >= '0' && hex_char1 <='9')
            int_ch1 = (hex_char1-48)*16;   //// 0 的Ascll - 48
        else if(hex_char1 >= 'A' && hex_char1 <='F')
            int_ch1 = (hex_char1-55)*16; //// A 的Ascll - 65
        else
            return nil;
        i++;
        
        unichar hex_char2 = [hexString characterAtIndex:i]; ///两位16进制数中的第二位(低位)
        int int_ch2;
        if(hex_char2 >= '0' && hex_char2 <='9')
            int_ch2 = (hex_char2-48); //// 0 的Ascll - 48
        else if(hex_char2 >= 'A' && hex_char2 <='F')
            int_ch2 = hex_char2-55; //// A 的Ascll - 65
        else
            return nil;
        
        tempbyt[0] = int_ch1+int_ch2;  ///将转化后的数放入Byte数组里
        [bytes appendBytes:tempbyt length:1];
    }
    return bytes;
}

+ (NSString *)hexStringFromData:(NSData *)data {
    
    Byte *bytes = (Byte *)[data bytes];
    // 下面是Byte 转换为16进制。
    NSString *hexStr=@"";
    for(int i = 0; i < [data length]; i++) {
        NSString *newHexStr = [NSString stringWithFormat:@"%x",bytes[i]&0xff]; // 16进制数
        if([newHexStr length] == 1)
            hexStr = [NSString stringWithFormat:@"%@0%@",hexStr,newHexStr];
        else
            hexStr = [NSString stringWithFormat:@"%@%@",hexStr,newHexStr];
    }
    
    NSLog(@"%@",hexStr);
    
    return hexStr;
}


#pragma mark - Emoji

+ (BOOL)stringContainsEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length]) options:NSStringEnumerationByComposedCharacterSequences usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        
        const unichar hs = [substring characterAtIndex:0];
        if (0xd800 <= hs && hs <= 0xdbff) {
            if (substring.length > 1) {
                const unichar ls = [substring characterAtIndex:1];
                const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                if (0x1d000 <= uc && uc <= 0x1f77f) {
                    returnValue = YES;
                }
            }
        } else if (substring.length > 1) {
            const unichar ls = [substring characterAtIndex:1];
            if (ls == 0x20e3) {
                returnValue = YES;
            }
        } else {
            // non surrogate
            if (0x2100 <= hs && hs <= 0x27ff) {
                returnValue = YES;
            } else if (0x2B05 <= hs && hs <= 0x2b07) {
                returnValue = YES;
            } else if (0x2934 <= hs && hs <= 0x2935) {
                returnValue = YES;
            } else if (0x3297 <= hs && hs <= 0x3299) {
                returnValue = YES;
            } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                returnValue = YES;
            }
        }
    }];
    return returnValue;
}

+ (NSString *)handlePhoneByPhone:(NSString *)string city:(NSString *)city {
    if ([string rangeOfString:@"-"].length > 0 || [string characterAtIndex:0] == '1' || [string length] < 7) {
        return string;
    }
    
    NSMutableString *resustString = [NSMutableString stringWithFormat:@"%@",string];
    if ([string characterAtIndex:0] == '0') {
        if ([string characterAtIndex:1] == '1' || [string characterAtIndex:1] == '2') {
            [resustString insertString:@"-" atIndex:3];
        } else {
            [resustString insertString:@"-" atIndex:4];
        }
    } else {
        NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"CityList" ofType:@"plist"];
        NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
        NSString *number = [dic valueForKey:city];
        if ([NSString isBlank:number]) {
            return string;
        }
        resustString = [NSMutableString stringWithFormat:@"%@-%@",number,resustString];
    }
    return resustString;
}

//手机号码验证
+ (BOOL)validateMobile:(NSString *)mobile {
//"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)"
    //手机号以13， 15，18开头，八个 \d 数字字符
    //    NSString *phoneRegex = @"((\\d{11})|^((\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})|(\\d{4}|\\d{3})-(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1})|(\\d{7,8})-(\\d{4}|\\d{3}|\\d{2}|\\d{1}))$)";//@"^((13[0-9])|(15[^4,\\D])|(18[0,0-9]))\\d{8}$";
    
    //    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
    //
    //    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    //
    //    BOOL isMatch = [pred evaluateWithObject:mobile];
    //    return isMatch;
    
    NSString *phoneRegex = @"^(13[0-9]|14[0-9]|15[0-9]|16[0-9]|17[0-9]|18[0-9]|19[0-9])\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

- (MISFileType)fileType {
    //    NSArray *officeTypeArray = @[@"doc",@"xls",@"xlsx",@"ppt"];
    NSArray *videoTypeArray = @[@"mov",@"mp4",@"3gp",@"m4v"];
    NSArray *audioTypeArray = @[@"aac",@"caf",@"mp3",@"m4a",@"wav",@"m4r"];
    NSArray *pictureTypeArray = @[@"jpg",@"jpeg",@"gif",@"png",@"ico"];
    NSArray *zipTypeArray = @[@"jpg",@"jpeg",@"gif",@"png",@"ico"];
    
    if ([self isEqualToString:@"doc"] || [self isEqualToString:@"docx"]||[self isEqualToString:@"txt"]) {
        return MISFileTypeWord;
    }else if ([self isEqualToString:@"xls"]||[self isEqualToString:@"xlsx"]) {
        return MISFileTypeExcel;
    }else if ([self isEqualToString:@"ppt"]||[self isEqualToString:@"pptx"]||[self isEqualToString:@"pdf"]) {
        return MISFileTypePPT;
    }else if ([videoTypeArray containsObject:self]) {
        return MISFileTypeVideo;
    }else if ([audioTypeArray containsObject:self]) {
        return MISFileTypeAudio;
    }else if ([pictureTypeArray containsObject:self]) {
        return MISFileTypePicture;
    }else if ([zipTypeArray containsObject:self]) {
        return MISFileTypeZip;
    }else {
        return MISFileTypeUnknow;
    }
}

+ (NSString *)convertFileSize:(long long)size {
    long kb = 1024;
    long mb = kb * 1024;
    long gb = mb * 1024;
    
    if (size >= gb) {
        return [NSString stringWithFormat:@"%.2f GB", (float) size / gb];
    } else if (size >= mb) {
        float f = (float) size / mb;
        if (f > 100) {
            return [NSString stringWithFormat:@"%.0f MB", f];
        } else {
            return [NSString stringWithFormat:@"%.2f MB", f];
        }
    } else if (size >= kb) {
        float f = (float) size / kb;
        if (f > 100) {
            return [NSString stringWithFormat:@"%.0f KB", f];
        } else {
            return [NSString stringWithFormat:@"%.2f KB", f];
        }
    } else {
        return [NSString stringWithFormat:@"%lld B", size];
    }
}

+ (NSString*)encodeString:(NSString*)unencodedString {

    return [unencodedString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"]];;
}

- (NSString *)stringByEncoded {

    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"!*'();:@&=+$,/?%#[]"]];;
    
}


//URLDEcode
+ (NSString *)decodeString:(NSString *)encodedString {
    
    return [encodedString stringByRemovingPercentEncoding];
}

// 从bundle当中获取素材
+ (NSString *)stringWithBundleName:(NSString *)bundlePath imageName:(NSString *)imageName {
    NSString *path = [[NSBundle mainBundle] pathForResource:bundlePath ofType:@"bundle"];
    NSString *imagePath = imageName;
    if (path) {
        imagePath = [path stringByAppendingPathComponent:imageName];
    }
    return imagePath;
}

+ (NSString *)stringWithBundleClass:(Class)bundleClass bundleName:(NSString *)bundleName imageName:(NSString *)imageName {
    NSString *bundlePath = [[NSBundle bundleForClass:bundleClass] pathForResource:bundleName ofType:@"bundle"];
    NSString *imagePath = imageName;
    if (bundlePath) {
        imagePath = [bundlePath stringByAppendingPathComponent:imageName];
    }
    return imagePath;
}

+ (NSString *)sizeToString:(long long)size {
    CGFloat k = 1024.0;
    CGFloat fileSize = size;
    if (size < k) { // B
        fileSize = size;
    } else if (size < k * k) { // KB
        fileSize = size / k;
    } else {
        fileSize = size / (k * k);
    }
    
    if (size < k) { // B
        return [NSString stringWithFormat:@"%.2fB", fileSize];
    } else if (size < k * k) { // KB
        return [NSString stringWithFormat:@"%.2fKB", fileSize];
    } else { // M
        return [NSString stringWithFormat:@"%.2fM", fileSize];
    }
}
    
- (NSMutableArray *)getRangeWithSubString:(NSString *)subString {
    NSMutableArray *arrayRanges = [NSMutableArray array];
    
    if ([NSString isBlank:subString]) {
        return nil;
    }
    NSRange rang = [self rangeOfString:subString]; //获取第一次出现的range
    if (rang.location != NSNotFound && rang.length != 0) {
        [arrayRanges addObject:[NSValue valueWithRange:rang]];//将第一次的加入到数组中
        NSRange rang1 = {0,0};
        NSInteger location = 0;
        NSInteger length = 0;
        for (int i = 0;; i++) {
            if (0 == i) {//去掉这个xxx
                location = rang.location + rang.length;
                length = self.length - rang.location - rang.length;
                rang1 = NSMakeRange(location, length);
            } else {
                location = rang1.location + rang1.length;
                length = self.length - rang1.location - rang1.length;
                rang1 = NSMakeRange(location, length);
            }

            //在一个range范围内查找另一个字符串的range
            rang1 = [self rangeOfString:subString options:NSCaseInsensitiveSearch range:rang1];
            if (rang1.location == NSNotFound && rang1.length == 0) {
                break;
            } else {//添加符合条件的location进数组
                [arrayRanges addObject:[NSValue valueWithRange:rang1]];
            }
        }
        return arrayRanges;
    }
    return nil;
}

@end
