
import Foundation

class Kip {
    
    // <kip_unicode: kip_number>
    static let banloUnicodeToBanloNumberDictionary : [String: String] = [
        // A
        "Á": "A2",
        "À": "A3",
        "Â": "A5",
        "Ǎ": "A6",
        "Ā": "A7",
        "A̍": "A8",
        "A̋": "A9",
        
        // a
        "á": "a2",
        "à": "a3",
        "â": "a5",
        "ǎ": "a6",
        "ā": "a7",
        "a̍": "a8",
        "a̋": "a9",
        
        // I
        "Í": "I2",
        "Ì": "I3",
        "Î": "I5",
        "Ǐ": "I6",
        "Ī": "I7",
        "I̍": "I8",
        "I̋": "I9",
        
        // i
        "í": "i2",
        "ì": "i3",
        "î": "i5",
        "ǐ": "i6",
        "ī": "i7",
        "i̍": "i8",
        "i̋": "i9",
        
        // U
        "Ú": "U2",
        "Ù": "U3",
        "Û": "U5",
        "Ǔ": "U6",
        "Ū": "U7",
        "U̍": "U8",
        "Ű": "U9",
        
        // u
        "ú": "u2",
        "ù": "u3",
        "û": "u5",
        "ǔ": "u6",
        "ū": "u7",
        "u̍": "u8",
        "ű": "u9",
        
        // E
        "É": "E2",
        "È": "E3",
        "Ê": "E5",
        "Ě": "E6",
        "Ē": "E7",
        "E̍": "E8",
        "E̋": "E9",
        
        // e
        "é": "e2",
        "è": "e3",
        "ê": "e5",
        "ě": "e6",
        "ē": "e7",
        "e̍": "e8",
        "e̋": "e9",
        
        // O
        "Ó": "O2",
        "Ò": "O3",
        "Ô": "O5",
        "Ǒ": "O6",
        "Ō": "O7",
        "O̍": "O8",
        "Ő": "O9",
        
        // o
        "ó": "o2",
        "ò": "o3",
        "ô": "o5",
        "ǒ": "o6",
        "ō": "o7",
        "o̍": "o8",
        "ő": "o9",
        
        // Oo
        "Óo": "Oo2",
        "Òo": "Oo3",
        "Ôo": "Oo5",
        "Ǒo": "Oo6",
        "Ōo": "Oo7",
        "O̍o": "Oo8",
        "Őo": "Oo9",
        
        // OO
        "ÓO": "OO2",
        "ÒO": "OO3",
        "ÔO": "OO5",
        "ǑO": "OO6",
        "ŌO": "OO7",
        "O̍O": "OO8",
        "ŐO": "OO9",
        
        // o
        "óo": "oo2",
        "òo": "oo3",
        "ôo": "oo5",
        "ǒo": "oo6",
        "ōo": "oo7",
        "o̍o": "oo8",
        "őo": "oo9",
        
        // M
        "Ḿ": "M2",
        "M̀": "M3",
        "M̂": "M5",
        "M̌": "M6",
        "M̄": "M7",
        "M̍": "M8",
        "M̋": "M9",
        
        // m
        "ḿ": "m2",
        "m̀": "m3",
        "m̂": "m5",
        "m̌": "m6",
        "m̄": "m7",
        "m̍": "m8",
        "m̋": "m9",
        
        // N
        "Ń": "N2",
        "Ǹ": "N3",
        "N̂": "N5",
        "Ň": "N6",
        "N̄": "N7",
        "N̍": "N8",
        "N̋": "N9",
        
        // n
        "ń": "n2",
        "ǹ": "n3",
        "n̂": "n5",
        "ň": "n6",
        "n̄": "n7",
        "n̍": "n8",
        "n̋": "n9",
        
        // Ng
        "Ńg": "Ng2",
        "Ǹg": "Ng3",
        "N̂g": "Ng5",
        "Ňg": "Ng6",
        "N̄g": "Ng7",
        "N̍g": "Ng8",
        "N̋g": "Ng9",
        
        // NG
        "ŃG": "NG2",
        "ǸG": "NG3",
        "N̂G": "NG5",
        "ŇG": "NG6",
        "N̄G": "NG7",
        "N̍G": "NG8",
        "N̋G": "NG9",
        
        // ng
        "ńg": "ng2",
        "ǹg": "ng3",
        "n̂g": "ng5",
        "ňg": "ng6",
        "n̄g": "ng7",
        "n̍g": "ng8",
        "n̋g": "ng9",
    ]
    
    // <kip_number: kip_unicode>
    static let banloNumberToBanloUnicodeDictionary: [String: String] = {
        var dict = [String: String]()
        
        for (key, value) in banloUnicodeToBanloNumberDictionary {
            dict[value] = key
        }
        
        return dict
    }()

}
