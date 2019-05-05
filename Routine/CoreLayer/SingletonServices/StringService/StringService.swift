import Foundation

class StringService: StringServiceInterface {
    
    var windowService: WindowServiceInterface!
    var languageService: LanguageServiceInterface!
    
    static var shared = StringService()
    
    private init () {}
    
    func localizeById(_ stringId: String) -> String {
        let result = self.localized(string: stringId)
        return result
    }
    
    func pluralsLocalizeByIds(str1: String, str24: String, str5: String, count: Int) -> String {
        let mod = count % 10
        
        if count >= 5 && count <= 20 {
            return self.localized(string: str5)
            
        } else if mod == 1 {
            return self.localized(string: str1)
            
        } else if mod == 2 || mod == 3 || mod == 4 {
            return self.localized(string: str24)
            
        } else {
            return self.localized(string: str5)
        }
    }
    
    func localizeHtmlById(_ stringId: String) -> String {
        let result = self.localized(string: stringId)
        
        let styleHtmlString: String = """
        <meta name="format-detection" content="telephone=no">
        <meta name="viewport" content="width=device-width, initial-scale = 1.0, maximum-scale=1.0, user-scalable=no" />
        <style>
        .body {
            position: absolute;
            left: 0;
            top: 18pt;
            bottom: 16pt;
            width: 100vw
            font-family: 'Foros-Regular';
            font-size: 12pt;
            display: flex;
            flex-direction: column;
            overflow-wrap: break-word;
            word-break: break-word;
            line-break: normal;
            hyphens: auto;
            color: inherit;
            text-decoration: none;
            word-break: break-all;
        }
        .header_text {
            font-family: 'Foros-Regular';
            font-size: \(self.windowService.is5sAndLess ? "14pt" : "18pt");
            display: block;
            padding: 8pt 0pt 8pt 0pt;
            color: inherit;
            text-decoration: none;
            font-weight: 100;
            overflow-wrap: break-word;
            word-break: break-word;
        }
        .black_regular_text {
            font-family: 'Foros-Regular';
            font-size: \(self.windowService.is5sAndLess ? "8pt" : "10pt");
            display: block;
            padding: 8pt 0pt 8pt 0pt;
            color: #000000;
            text-decoration: none;
            font-weight: 100;
            overflow-wrap: break-word;
            word-break: break-word;
        }
        .black_small_text {
            font-family: 'Foros-Regular';
            font-size: \(self.windowService.is5sAndLess ? "10pt" : "13pt");
            display: block;
            padding: 8pt 0pt 8pt 0pt;
            color: #000000;
            text-decoration: none;
            font-weight: 100;
            overflow-wrap: break-word;
            word-break: break-word;
        }
        .lightGray_header {
            font-family: 'Foros-Regular';
            font-size: \(self.windowService.is5sAndLess ? "13pt" : "15pt");
            display: block;
            padding: 8pt 0pt 8pt 0pt;
            color: #848484;
            text-decoration: none;
            font-weight: 100;
            overflow-wrap: break-word;
            word-break: break-word;
        }
        .lightGray_regular_text {
            font-family: 'Foros-Regular';
            font-size: \(self.windowService.is5sAndLess ? "10pt" : "13pt");
            display: block;
            padding: 8pt 0pt 8pt 0pt;
            color: #848484;
            text-decoration: none;
            font-weight: 100;
            overflow-wrap: break-word;
            word-break: break-word;
        }
        
        
        
        .center {
        text-align:center;
        }
        .href {
        color: #07C;
        text-decoration: none;
        }
        @media screen and (max-width:600pt) {
        
        }
        </style>
        """
        
        return styleHtmlString + result
    }
    
    private func localized(string: String, tableName: String = "Localizable") -> String {
        let bundle: Bundle? = self.languageService.bundle
        let string = NSLocalizedString(string, tableName: tableName, bundle: bundle ?? Bundle.main, value: "\(string)", comment: "")
        return string
    }
    
}
