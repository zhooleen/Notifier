# NSString+KeyPath
Key path string generator in iOS

# Example:

@"sometimes.you.want.query.value.from.dictionary"

@interface KPMaker (QueryKeyPath)

@property (readonly) KPMaker *sometimes;

-(KPMaker*) you;

-(KPMaker*) want;

...

-(KPMaker*) dictionary;

@end

NSString *keyPath = KeyPath(sometimes.you.want.query.value.from.dictionary);

# Advantage
1. The compiler checks the spelling error
2. Xcode suggests completions while typeing
3. Just declare the category, not neccessarily implement it.


# NSMutableString+KeyPath
Support all properties of any Class

# Example
 - KP._(view)._(backgroundColor)            ----> @"view.backgroundColor"
 - KP._(name)._(backgroundColor)._(view)    ----> @"name.backgroundColor.view"
