
import Foundation
import UIKit

class KeyboardTemplate {
    
    static let taigiLomaji = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
                              ["!", "?", "e", "r", "t", "y", "u", "i", "o", "p"],
                              ["a", "s", "d", "f", "g", "h", "j", "k", "l", "-"],
                              ["shift", ",", ".", "c", "v", "b", "n", "m", "backspace"],
                              ["symbolPage", "keyboardChange", "taibunSpace", "hanloSwitch", "enter"]]
    static let taigiLomajiShifted = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
                                     ["!", "?", "E", "R", "T", "Y", "U", "I", "O", "P"],
                                     ["A", "S", "D", "F", "G", "H", "J", "K", "L", "-"],
                                     ["shift", ",", ".", "C", "V", "B", "N", "M", "backspace"],
                                     ["symbolPage", "keyboardChange", "taibunSpace", "hanloSwitch", "enter"]]
    static let taigiHanji = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
                             ["！", "？", "e", "r", "t", "y", "u", "i", "o", "p"],
                             ["a", "s", "d", "f", "g", "h", "j", "k", "l", "-"],
                             ["shift", "，", "。", "c", "v", "b", "n", "m", "backspace"],
                             ["symbolPage", "keyboardChange", "taibunSpace", "hanloSwitch", "enter"]]
    static let taigiHanjiShifted = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
                                    ["！", "？", "E", "R", "T", "Y", "U", "I", "O", "P"],
                                    ["A", "S", "D", "F", "G", "H", "J", "K", "L", "-"],
                                    ["shift", "，", "。", "C", "V", "B", "N", "M", "backspace"],
                                    ["symbolPage", "keyboardChange", "taibunSpace", "hanloSwitch", "enter"]]
    static let taigiKeysWidthPercentage: [[CGFloat]] = [[10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
                                                        [10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
                                                        [10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
                                                        [15, 10, 10, 10, 10, 10, 10, 10, 15],
                                                        [15, 15, 40, 15, 15]]
    
    static let symbolLomaji = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
                               ["!", "`", "~", "@", "#", "$", "*", "/", "+", "-"],
                               ["%", "^", "&", "(", ")", "[", "]", "{", "}", "?"],
                               ["shift", ".", ",", ":", ";", "_", "=", "\"", "backspace"],
                               ["lomajiPage","keyboardChange", "space", "hanloSwitch", "enter"]]
    static let symbolLomajiShifted = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
                                      ["!", "`", "~", "@", "#", "$", "*", "/", "+", "-"],
                                      ["℃", "™", "©", "®", "<", ">", "€", "£", "¥", "\\"],
                                      ["shift", ".", ",", ":", ";", "_", "=", "\"", "backspace"],
                                      ["lomajiPage","keyboardChange", "space", "hanloSwitch", "enter"]]
    static let symbolHanji = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
                              ["！", "～", "＠", "＃", "＄", "＊", "／", "＋", "－", "＝"],
                              ["＆", "『", "』", "（", "）", "【", "】", "｛", "｝", "？"],
                              ["shift","。", "，", "：", "；", "、", "「", "」", "backspace"],
                              ["lomajiPage","keyboardChange", "space", "hanloSwitch", "enter"]]
    static let symbolHanjiShifted = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
                                     ["！", "～", "＠", "＃", "＄", "＊", "／", "＋", "－", "＝"],
                                     ["％", "〖", "〗", "〔", "〕", "［", "］", "｜", "＿", "＼"],
                                     ["shift","。", "，", "：", "；", "、", "「", "」", "backspace"],
                                     ["lomajiPage","keyboardChange", "space", "hanloSwitch", "enter"]]
    static let symbolKeyWidthPercentage: [[CGFloat]] = [[10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
                                                        [10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
                                                        [10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
                                                        [15, 10, 10, 10, 10, 10, 10, 10, 15],
                                                        [15, 15, 40, 15, 15]]
    
    static let enggiLomaji = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
                              ["q", "w", "e", "r", "t", "y", "u", "i", "o", "p"],
                              ["a", "s", "d", "f", "g", "h", "j", "k", "l", ","],
                              ["shift", "z", "x", "c", "v", "b", "n", "m", "backspace"],
                              ["symbolPage", "keyboardChange", "engbunSpace", ".", "enter"]]
    static let enggiLomajiShifted = [["1", "2", "3", "4", "5", "6", "7", "8", "9", "0"],
                                     ["Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P"],
                                     ["A", "S", "D", "F", "G", "H", "J", "K", "L", ","],
                                     ["shift", "Z", "X", "C", "V", "B", "N", "M", "backspace"],
                                     ["symbolPage", "keyboardChange", "engbunSpace", ".", "enter"]]
    static let enggiKeysWidthPercentage: [[CGFloat]] = [[10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
                                                        [10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
                                                        [10, 10, 10, 10, 10, 10, 10, 10, 10, 10],
                                                        [15, 10, 10, 10, 10, 10, 10, 10, 15],
                                                        [15, 15, 40, 15, 15]]
    
    static let taigiKeyboardTemplate: [KeyboardTemplateModel] = [KeyboardTemplateModel(halfwidthKeyCodes: taigiLomaji,
                                                                                       halfwidthKeyCodesShifted: taigiLomajiShifted,
                                                                                       fullwidthKeyCodes: taigiHanji,
                                                                                       fullwidthKeyCodesShifted: taigiHanjiShifted,
                                                                                       keysWidthPercentage: taigiKeysWidthPercentage),
                                                                 KeyboardTemplateModel(halfwidthKeyCodes: symbolLomaji,
                                                                                       halfwidthKeyCodesShifted: symbolLomajiShifted,
                                                                                       fullwidthKeyCodes: symbolHanji,
                                                                                       fullwidthKeyCodesShifted: symbolHanjiShifted,
                                                                                       keysWidthPercentage: symbolKeyWidthPercentage),
                                                                 KeyboardTemplateModel(halfwidthKeyCodes: enggiLomaji,
                                                                                       halfwidthKeyCodesShifted: enggiLomajiShifted,
                                                                                       fullwidthKeyCodes: enggiLomaji,
                                                                                       fullwidthKeyCodesShifted: enggiLomajiShifted,
                                                                                       keysWidthPercentage: enggiKeysWidthPercentage),]
    
    static let taigiLomajiDirectOutputKey = ["-", "!", ".", "?", ",", "！", "。", "？", "，"]
    static let autoCapitalizeEndingTexts = [".", "!", "?", "。", "！", "？"]
}
