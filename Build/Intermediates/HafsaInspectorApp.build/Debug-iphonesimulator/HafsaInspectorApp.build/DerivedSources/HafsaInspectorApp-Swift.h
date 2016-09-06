// Generated by Apple Swift version 2.2 (swiftlang-703.0.18.1 clang-703.0.29)
#pragma clang diagnostic push

#if defined(__has_include) && __has_include(<swift/objc-prologue.h>)
# include <swift/objc-prologue.h>
#endif

#pragma clang diagnostic ignored "-Wauto-import"
#include <objc/NSObject.h>
#include <stdint.h>
#include <stddef.h>
#include <stdbool.h>

#if !defined(SWIFT_TYPEDEFS)
# define SWIFT_TYPEDEFS 1
# if defined(__has_include) && __has_include(<uchar.h>)
#  include <uchar.h>
# elif !defined(__cplusplus) || __cplusplus < 201103L
typedef uint_least16_t char16_t;
typedef uint_least32_t char32_t;
# endif
typedef float swift_float2  __attribute__((__ext_vector_type__(2)));
typedef float swift_float3  __attribute__((__ext_vector_type__(3)));
typedef float swift_float4  __attribute__((__ext_vector_type__(4)));
typedef double swift_double2  __attribute__((__ext_vector_type__(2)));
typedef double swift_double3  __attribute__((__ext_vector_type__(3)));
typedef double swift_double4  __attribute__((__ext_vector_type__(4)));
typedef int swift_int2  __attribute__((__ext_vector_type__(2)));
typedef int swift_int3  __attribute__((__ext_vector_type__(3)));
typedef int swift_int4  __attribute__((__ext_vector_type__(4)));
#endif

#if !defined(SWIFT_PASTE)
# define SWIFT_PASTE_HELPER(x, y) x##y
# define SWIFT_PASTE(x, y) SWIFT_PASTE_HELPER(x, y)
#endif
#if !defined(SWIFT_METATYPE)
# define SWIFT_METATYPE(X) Class
#endif

#if defined(__has_attribute) && __has_attribute(objc_runtime_name)
# define SWIFT_RUNTIME_NAME(X) __attribute__((objc_runtime_name(X)))
#else
# define SWIFT_RUNTIME_NAME(X)
#endif
#if defined(__has_attribute) && __has_attribute(swift_name)
# define SWIFT_COMPILE_NAME(X) __attribute__((swift_name(X)))
#else
# define SWIFT_COMPILE_NAME(X)
#endif
#if !defined(SWIFT_CLASS_EXTRA)
# define SWIFT_CLASS_EXTRA
#endif
#if !defined(SWIFT_PROTOCOL_EXTRA)
# define SWIFT_PROTOCOL_EXTRA
#endif
#if !defined(SWIFT_ENUM_EXTRA)
# define SWIFT_ENUM_EXTRA
#endif
#if !defined(SWIFT_CLASS)
# if defined(__has_attribute) && __has_attribute(objc_subclassing_restricted)
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) __attribute__((objc_subclassing_restricted)) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# else
#  define SWIFT_CLASS(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
#  define SWIFT_CLASS_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_CLASS_EXTRA
# endif
#endif

#if !defined(SWIFT_PROTOCOL)
# define SWIFT_PROTOCOL(SWIFT_NAME) SWIFT_RUNTIME_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
# define SWIFT_PROTOCOL_NAMED(SWIFT_NAME) SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_PROTOCOL_EXTRA
#endif

#if !defined(SWIFT_EXTENSION)
# define SWIFT_EXTENSION(M) SWIFT_PASTE(M##_Swift_, __LINE__)
#endif

#if !defined(OBJC_DESIGNATED_INITIALIZER)
# if defined(__has_attribute) && __has_attribute(objc_designated_initializer)
#  define OBJC_DESIGNATED_INITIALIZER __attribute__((objc_designated_initializer))
# else
#  define OBJC_DESIGNATED_INITIALIZER
# endif
#endif
#if !defined(SWIFT_ENUM)
# define SWIFT_ENUM(_type, _name) enum _name : _type _name; enum SWIFT_ENUM_EXTRA _name : _type
# if defined(__has_feature) && __has_feature(generalized_swift_name)
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) enum _name : _type _name SWIFT_COMPILE_NAME(SWIFT_NAME); enum SWIFT_COMPILE_NAME(SWIFT_NAME) SWIFT_ENUM_EXTRA _name : _type
# else
#  define SWIFT_ENUM_NAMED(_type, _name, SWIFT_NAME) SWIFT_ENUM(_type, _name)
# endif
#endif
#if defined(__has_feature) && __has_feature(modules)
@import UIKit;
@import CoreGraphics;
@import ObjectiveC;
@import Material;
#endif

#pragma clang diagnostic ignored "-Wproperty-attribute-mismatch"
#pragma clang diagnostic ignored "-Wduplicate-method-arg"
@class UIWindow;
@class EstablishmentPickerViewController;
@class UIApplication;
@class NSObject;

SWIFT_CLASS("_TtC17HafsaInspectorApp11AppDelegate")
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (nonatomic, strong) UIWindow * _Nullable window;
@property (nonatomic, strong) EstablishmentPickerViewController * _Nonnull vc;
@property (nonatomic) NSInteger errorCount;
- (BOOL)application:(UIApplication * _Nonnull)application willFinishLaunchingWithOptions:(NSDictionary * _Nullable)launchOptions;
- (BOOL)application:(UIApplication * _Nonnull)application didFinishLaunchingWithOptions:(NSDictionary * _Nullable)launchOptions;
- (void)applicationWillResignActive:(UIApplication * _Nonnull)application;
- (void)applicationDidEnterBackground:(UIApplication * _Nonnull)application;
- (void)applicationWillEnterForeground:(UIApplication * _Nonnull)application;
- (void)applicationDidBecomeActive:(UIApplication * _Nonnull)application;
- (void)applicationWillTerminate:(UIApplication * _Nonnull)application;
- (void)getData;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

@class UIPickerView;
@class UITextField;
@class UIButton;
@class UIImageView;
@class HITextField;
@class NSBundle;
@class NSCoder;

SWIFT_CLASS("_TtC17HafsaInspectorApp27ChapterPickerViewController")
@interface ChapterPickerViewController : UIViewController <UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified nextButton;
@property (nonatomic, weak) IBOutlet UIImageView * _Null_unspecified imageView;
@property (nonatomic, weak) IBOutlet HITextField * _Null_unspecified chapterTextField;
@property (nonatomic, weak) IBOutlet HITextField * _Null_unspecified nameTextField;
@property (nonatomic, copy) NSArray<NSString *> * _Nonnull chapterData;
@property (nonatomic, readonly, strong) UIPickerView * _Nonnull picker;
+ (ChapterPickerViewController * _Nonnull)create;
- (void)viewDidLoad;
- (void)setupView;
- (BOOL)textFieldShouldReturn:(UITextField * _Nonnull)textField;
- (void)textFieldDidBeginEditing:(UITextField * _Nonnull)textField;
- (IBAction)nextButtonPressed:(id _Nonnull)sender;
- (void)backButtonPressed;
- (void)saveData;
- (void)didGetChapterData;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UILabel;

SWIFT_CLASS("_TtC17HafsaInspectorApp33EstablishmentPickerViewController")
@interface EstablishmentPickerViewController : UIViewController <UITextFieldDelegate>
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified nextButton;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified establishmentLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified nameLabel;
@property (nonatomic, weak) IBOutlet HITextField * _Null_unspecified establishmentTextField;
+ (EstablishmentPickerViewController * _Nonnull)create;
- (void)viewDidLoad;
- (void)setupView;
- (IBAction)nextButtonPressed:(id _Nonnull)sender;
- (void)settingsButtonPressed;
- (void)didChangeChapter;
- (void)didGetEstablishmentData;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UITableView;
@class NSIndexPath;
@class UITableViewCell;

SWIFT_CLASS("_TtC17HafsaInspectorApp23FormTableViewController")
@interface FormTableViewController : UITableViewController
+ (FormTableViewController * _Nonnull)create;
- (void)viewDidLoad;
- (NSInteger)numberOfSectionsInTableView:(UITableView * _Nonnull)tableView;
- (NSInteger)tableView:(UITableView * _Nonnull)tableView numberOfRowsInSection:(NSInteger)section;
- (UITableViewCell * _Nonnull)tableView:(UITableView * _Nonnull)tableView cellForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)tableView:(UITableView * _Nonnull)tableView willDisplayCell:(UITableViewCell * _Nonnull)cell forRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (CGFloat)tableView:(UITableView * _Nonnull)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (CGFloat)tableView:(UITableView * _Nonnull)tableView heightForRowAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (nonnull instancetype)initWithStyle:(UITableViewStyle)style OBJC_DESIGNATED_INITIALIZER;
- (nonnull instancetype)initWithNibName:(NSString * _Nullable)nibNameOrNil bundle:(NSBundle * _Nullable)nibBundleOrNil OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end

@class UICollectionView;
@class UICollectionViewCell;

@interface FormTableViewController (SWIFT_EXTENSION(HafsaInspectorApp)) <UICollectionViewDelegate, UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView * _Nonnull)collectionView numberOfItemsInSection:(NSInteger)section;
- (UICollectionViewCell * _Nonnull)collectionView:(UICollectionView * _Nonnull)collectionView cellForItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
- (void)collectionView:(UICollectionView * _Nonnull)collectionView didSelectItemAtIndexPath:(NSIndexPath * _Nonnull)indexPath;
@end

@class NSArray;

SWIFT_CLASS("_TtC17HafsaInspectorApp9HIManager")
@interface HIManager : NSObject
@property (nonatomic, copy) NSString * _Nonnull userName;
@property (nonatomic, copy) NSString * _Nonnull currentChapter;
@property (nonatomic, copy) NSString * _Nonnull currentEstablishment;
@property (nonatomic, strong) NSArray * _Nonnull data;
@property (nonatomic, copy) NSArray<NSString *> * _Nonnull chapterArray;
@property (nonatomic, copy) NSArray<NSString *> * _Nonnull establishmentArray;
@property (nonatomic, copy) NSArray<NSString *> * _Nonnull supplierArray;
+ (HIManager * _Nonnull)sharedClient;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC17HafsaInspectorApp11HITextField")
@interface HITextField : TextField <UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, strong) NSArray * _Nonnull data;
@property (nonatomic, readonly, strong) UIPickerView * _Nonnull picker;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
- (void)setup;
- (void)setupPicker;
- (void)setupChapterPicker;
- (void)setupEstablishmentPicker;
- (void)donePicker;
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView * _Nonnull)chapterPickerView;
- (NSInteger)pickerView:(UIPickerView * _Nonnull)chapterPickerView numberOfRowsInComponent:(NSInteger)component;
- (NSString * _Nullable)pickerView:(UIPickerView * _Nonnull)chapterPickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
- (void)pickerView:(UIPickerView * _Nonnull)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
@end


SWIFT_CLASS("_TtC17HafsaInspectorApp18ImageTableViewCell")
@interface ImageTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified addImageButton;
@property (nonatomic, weak) IBOutlet UICollectionView * _Null_unspecified collectionView;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC17HafsaInspectorApp17NameTableViewCell")
@interface NameTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified nameLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified chapterLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified establishmentLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified datelabel;
- (void)configureNameCell;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


SWIFT_CLASS("_TtC17HafsaInspectorApp21SupplierTableViewCell")
@interface SupplierTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified supplierNameLabel;
@property (nonatomic, weak) IBOutlet UILabel * _Null_unspecified poundLabel;
@property (nonatomic, weak) IBOutlet UIButton * _Null_unspecified addPoundsButton;
@property (nonatomic) double previousPounds;
@property (nonatomic, strong) UITextField * _Null_unspecified tField;
- (void)configureSupplierCell:(NSInteger)index;
- (void)updatePounds:(double)pounds;
- (IBAction)addPoundsPressed:(id _Nonnull)sender;
- (void)configurationTextField:(UITextField * _Null_unspecified)textField;
- (nonnull instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString * _Nullable)reuseIdentifier OBJC_DESIGNATED_INITIALIZER;
- (nullable instancetype)initWithCoder:(NSCoder * _Nonnull)aDecoder OBJC_DESIGNATED_INITIALIZER;
@end


@interface UIColor (SWIFT_EXTENSION(HafsaInspectorApp))
+ (UIColor * _Nonnull)HIBackground;
@end


@interface UINavigationController (SWIFT_EXTENSION(HafsaInspectorApp))
@property (nonatomic, readonly, strong) UIViewController * _Nullable topMostViewController;
@end


@interface UIScreen (SWIFT_EXTENSION(HafsaInspectorApp))
@end


@interface UITabBarController (SWIFT_EXTENSION(HafsaInspectorApp))
@property (nonatomic, readonly, strong) UIViewController * _Nullable topMostViewController;
@end


@interface UIView (SWIFT_EXTENSION(HafsaInspectorApp))
@property (nonatomic, readonly, strong) UIViewController * _Nullable parentViewController;
@end


@interface UIViewController (SWIFT_EXTENSION(HafsaInspectorApp))
- (void)hideKeyboardWhenTappedAround;
- (void)dismissKeyboard;
@end


@interface UIViewController (SWIFT_EXTENSION(HafsaInspectorApp))
@property (nonatomic, readonly, strong) UIViewController * _Nullable topMostViewController;
@end


@interface UIViewController (SWIFT_EXTENSION(HafsaInspectorApp))
- (void)setNavBarWithSettingsIcon:(NSString * _Nonnull)selector;
- (void)setNavBarWithBackButton;
- (void)backButtonPressed;
@property (nonatomic, readonly) BOOL isVisible;
@property (nonatomic, readonly) BOOL isTopViewController;
@property (nonatomic, readonly) BOOL isOnScreen;
- (void)createAlert:(NSString * _Nonnull)error;
- (void)createWebAlertWithTryAgain:(NSString * _Nonnull)error selector:(SEL _Null_unspecified)selector;
@end


@interface UIWindow (SWIFT_EXTENSION(HafsaInspectorApp))
@property (nonatomic, readonly, strong) UIViewController * _Nullable topMostViewController;
@end


@interface UIWindow (SWIFT_EXTENSION(HafsaInspectorApp))
@property (nonatomic, readonly, strong) UIViewController * _Nullable visibleViewController;
+ (UIViewController * _Nullable)getVisibleViewControllerFrom:(UIViewController * _Nullable)vc;
@end

@class NSData;

SWIFT_CLASS("_TtC17HafsaInspectorApp10WebService")
@interface WebService : NSObject
- (NSDictionary<NSString *, id> * _Nullable)parseJSON:(NSData * _Nonnull)data;
- (nonnull instancetype)init OBJC_DESIGNATED_INITIALIZER;
@end

#pragma clang diagnostic pop
