/*
  Localization.m

  Controller class for Localization preferences bundle

  Author:	Sergii Stoian <stoyan255@ukr.net>
  Date:		28 Nov 2015

  This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License as
  published by the Free Software Foundation; either version 2 of
  the License, or (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

  See the GNU General Public License for more details.

  You should have received a copy of the GNU General Public
  License along with this program; if not, write to:

  	Free Software Foundation, Inc.
  	59 Temple Place - Suite 330
  	Boston, MA  02111-1307, USA
*/
#import <AppKit/NSApplication.h>
#import <AppKit/NSNibLoading.h>
#import <AppKit/NSScrollView.h>
#import <AppKit/NSScroller.h>
#import <AppKit/NSTableView.h>
#import <AppKit/NSTableColumn.h>

#import "Localization.h"

@implementation Localization

static NSBundle                 *bundle = nil;
static NSUserDefaults           *defaults = nil;
static NSMutableDictionary      *domain = nil;

- (id)init
{
  self = [super init];
  
  defaults = [NSUserDefaults standardUserDefaults];
  domain = [[defaults persistentDomainForName:NSGlobalDomain] mutableCopy];

  bundle = [NSBundle bundleForClass:[self class]];
  NSString *imagePath = [bundle pathForResource:@"Localization" ofType:@"tiff"];
  image = [[NSImage alloc] initWithContentsOfFile:imagePath];

  languages = [NSArray arrayWithObjects:
                       @"Dutch",
                       @"English",
                       @"Esperanto",
                       @"French",
                       @"German",
                       @"Hungarian",
                       @"Italian",
                       @"Korean",
                       @"Russian",
                       @"Slovak",
                       @"Spanish",
                       @"Traditional Chinese",
                       @"Ukrainian",
                       nil];
  [languages retain];
  
  return self;
}

- (void)dealloc
{
  [image release];
  [super dealloc];
}

- (void)awakeFromNib
{
  [view retain];
  [window release];

  {
    NSRect rect = [languageScrollView frame];
    NSTableColumn *tColumn;
    [languageList setHeaderView:nil];
    [languageList setCornerView:nil];
    tColumn = [languageList tableColumnWithIdentifier:@"language"];
    [tColumn setWidth:(rect.size.width-23)];
  }
}

- (NSView *)view
{
  if (view == nil)
    {
      if (![NSBundle loadNibNamed:@"Localization" owner:self])
        {
          NSLog (@"Localization.preferences: Could not load nib, aborting.");
          return nil;
        }
    }
  
  return view;
}

- (NSString *)buttonCaption
{
  return @"Localization Preferences";
}

- (NSImage *)buttonImage
{
  return image;
}

@end

@implementation Localization (TableViewDelegate)

- (int)numberOfRowsInTableView:(NSTableView *)aTableView
{
  if (aTableView == languageList)
    {
      return [languages count];
    }
  
  return 0;
}

- (id)            tableView:(NSTableView *)aTableView
  objectValueForTableColumn:(NSTableColumn *)aTableColumn
                        row:(int)rowIndex
{
  if (aTableView == languageList)
    {
      if (aTableColumn == [languageList tableColumnWithIdentifier:@"language"])
        {
          return [languages objectAtIndex:rowIndex];
        }
    }

  return nil;
}

- (void) tableView:(NSTableView *)aTableView
    setObjectValue:anObject
    forTableColumn:(NSTableColumn *)aTableColumn
               row:(int)rowIndex
{
}

@end
