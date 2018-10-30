/*
 * Copyright 2012 ZXing authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#import "ZXCode39WriterTestCase.h"
#import "ZXCode39Writer.h"

@implementation ZXCode39WriterTestCase

- (void)testEncode {
  NSString *testStr = @"000001001011011010110101001011010110100101101101101001010101011001011011010110010101"
  "011011001010101010011011011010100110101011010011010101011001101011010101001101011010"
  "100110110110101001010101101001101101011010010101101101001010101011001101101010110010"
  "101101011001010101101100101100101010110100110101011011001101010101001011010110110010"
  "110101010011011010101010011011010110100101011010110010101101101100101010101001101011"
  "01101001101010101100110101010100101101101101001011010101100101101010010110110100000\n";
  [self doTest:@"ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789" expected:testStr];

  // extended mode blocks
  [self doTest:[NSString stringWithFormat:@"%C%C%C%C%C%C%C%C\b\t\n%C\f\r%C%C%C%C%C%C%C%C%C%C%C%C%C%C%C%C%C%C", 0x0000, 0x0001, 0x0002, 0x0003, 0x0004, 0x0005, 0x0006, 0x0007, 0x000b, 0x000e, 0x000f, 0x0010, 0x0011, 0x0012, 0x0013, 0x0014, 0x0015, 0x0016, 0x0017, 0x0018, 0x0019, 0x001a, 0x001b, 0x001c, 0x001d, 0x001e, 0x001f] expected:@"000001001011011010101001001001011001010101101001001001010110101001011010010010010101011010010110100100100101011011010010101001001001010101011001011010010010010101101011001010100100100101010110110010101001001001010101010011011010010010010101101010011010100100100101010110100110101001001001010101011001101010010010010101101010100110100100100101010110101001101001001001010110110101001010010010010101010110100110100100100101011010110100101001001001010101101101001010010010010101010101100110100100100101011010101100101001001001010101101011001010010010010101010110110010100100100101011001010101101001001001010100110101011010010010010101100110101010100100100101010010110101101001001001010110010110101010010010010101001101101010101001001001011010100101101010010010010101101001011010100100100101101101001010101001001001010101100101101010010010010110101100101010010110110100000\n"];
  [self doTest:@" !\"#$%&'()*+,-./0123456789:;<=>?" expected:@"00000100101101101010011010110101001001010010110101001011010010010100101011010010110100100101001011011010010101001001010010101011001011010010010100101101011001010100100101001010110110010101001001010010101010011011010010010100101101010011010100100101001010110100110101001001010010101011001101010010010100101101010100110100100101001010110101001101001010110110110010101101010010010100101101011010010101001101101011010010101101011001010110110110010101010100110101101101001101010101100110101010100101101101101001011010101100101101010010010100101001101101010101001001001010110110010101010010010010101010011011010100100100101101010011010101001001001010110100110101010010010010101011001101010010110110100000\n"];
  [self doTest:@"@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\]^_" expected:@"0000010010110110101010010010010100110101011011010100101101011010010110110110100101010101100101101101011001010101101100101010101001101101101010011010101101001101010101100110101101010100110101101010011011011010100101010110100110110101101001010110110100101010101100110110101011001010110101100101010110110010110010101011010011010101101100110101010100101101011011001011010101001101101010101001001001011010101001101010010010010101101010011010100100100101101101010010101001001001010101101001101010010010010110101101001010010110110100000\n"];
  [self doTest:@"`abcdefghijklmnopqrstuvwxyz{|}~" expected:@"000001001011011010101001001001011001101010101001010010010110101001011010010100100101011010010110100101001001011011010010101001010010010101011001011010010100100101101011001010100101001001010110110010101001010010010101010011011010010100100101101010011010100101001001010110100110101001010010010101011001101010010100100101101010100110100101001001010110101001101001010010010110110101001010010100100101010110100110100101001001011010110100101001010010010101101101001010010100100101010101100110100101001001011010101100101001010010010101101011001010010100100101010110110010100101001001011001010101101001010010010100110101011010010100100101100110101010100101001001010010110101101001010010010110010110101010010100100101001101101010101001001001010110110100101010010010010101010110011010100100100101101010110010101001001001010110101100101010010010010101011011001010010110110100000\n"];
}

- (void)doTest:(NSString *)input expected:(NSString *)expected {
  ZXBitMatrix *matrix = [[[ZXCode39Writer alloc] init] encode:input
                                                       format:kBarcodeFormatCode39
                                                        width:0
                                                       height:0
                                                        error:nil];
  XCTAssertEqualObjects(expected, [matrix descriptionWithSetString:@"1" unsetString:@"0"]);
}

@end