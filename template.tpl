___TERMS_OF_SERVICE___

By creating or modifying this file you agree to Google Tag Manager's Community
Template Gallery Developer Terms of Service available at
https://developers.google.com/tag-manager/gallery-tos (or such other URL as
Google may provide), as modified from time to time.


___INFO___

{
  "type": "MACRO",
  "id": "cvt_temp_public_id",
  "version": 1,
  "securityGroups": [],
  "displayName": "Simple Bot Detector",
 "categories": [
    "UTILITY"
  ],
  "description": "creates a marker for known rendering bots from search engines like Google, Bing, Baidu, Yandex  or services like Lighthouse, Ahrefs and others that identify in the user agent string",
  "containerContexts": [
    "WEB"
  ]
}


___TEMPLATE_PARAMETERS___

[
  {
    "type": "TEXT",
    "name": "inputVar",
    "displayName": "Input Variable (User Agent)",
    "simpleValueType": true,
    "enablingConditions": [],
    "valueValidators": [
      {
        "type": "NON_EMPTY"
      }
    ],
    "help": "Create a JS Variable for window.navigator.userAgent and use it as an input variable (templates do not have access to this information)."
  },
  {
    "type": "GROUP",
    "name": "setupFields",
    "displayName": "Advanced Configuration",
    "groupStyle": "ZIPPY_CLOSED",
    "subParams": [
      {
        "type": "TEXT",
        "name": "additionalMarkers",
        "displayName": "Additional Bot Markers",
        "simpleValueType": true,
        "canBeEmptyString": true,
        "lineCount": 5,
        "textAsList": true,
        "valueHint": "add additional user-agent markers like \"SomeBot\" (one per row)",
        "help": "if you use certain rendering tools yourself or suspect hits from known rendering bots that this variable does not detect, add a string that is contained in the bot´s user-agent string in a separate row."
      },
      {
        "type": "CHECKBOX",
        "name": "includeUserAgent",
        "checkboxText": "Include User Agent for Potential Bots",
        "simpleValueType": true,
        "defaultValue": false
      }
    ]
  }
]


___SANDBOXED_JS_FOR_WEB_TEMPLATE___

var ua_org = data.inputVar;
var ua = ua_org.toLowerCase();

var bots_ua = [
  //user-agents for known rendering crawlers from search engines and other services   
  "Googlebot", 
  "AdsBot-Google",
  "Mediapartners-Google",
  "Google Search Console",
  "Chrome-Lighthouse",
  "DuckDuckBot",
  "JobboerseBot",
  "woobot",
  "PingdomPageSpeed",
  "PagePeeker",
  "Refindbot",
  "HubSpot",
  "Yandex",
  "Investment Crawler",
  "BingPreview",
  "Bingbot",
  "Baiduspider",
  "Sogou",
  "SISTRIX",
  "facebookexternalhit",
  "Site-Shot",
  "wkhtmltoimage",
  "SMTBot", 
  "PetalBot", 
  "AhrefsBot", 
  "avalex",
  "RyteBot", 
  "SemrushBot",
  "Cookiebot", 
  "Seekport Crawler",
  "Cocolyzebot", 
  "Veoozbot", 
  "YisouSpider",
  "Elisabot",
  "ev-crawler",
  "screeenly-bot", 

  //poorly configured headless tools
  "HeadlessChrome",
  "MSIE 5.0",
  "PhantomJS"
];

if (data.additionalMarkers.length > 0) 
  bots_ua = bots_ua.concat(data.additionalMarkers);

var mrk;
for (var i=0;i<bots_ua.length;i++) {
  var bt = bots_ua[i].trim();
  if ((bt != "") && (ua.indexOf(bt.toLowerCase()) >= 0)) {mrk = "Bot ("+bt+")"; break;} 
}

if (!mrk && ((ua.indexOf('crawler') >= 0) || (ua.indexOf('spider') >= 0) ||  
             ((ua.indexOf('bot') >= 0) && (ua.indexOf('cubot') < 0)))) {
  mrk = "Potential Bot";
  if (data.includeUserAgent) mrk += " ("+ua_org+")";
}

return mrk || "OK";


___TESTS___

scenarios: []


___NOTES___

Created on 31.5.2022, 13:42:55


