/*
   The browser viewer.

   Copyright (C) 2014 Sergii Stoian
   Copyright (C) 2005 Saso Kiselkov

   This library is free software; you can redistribute it and/or
   modify it under the terms of the GNU Library General Public
   License as published by the Free Software Foundation; either
   version 2 of the License, or (at your option) any later version.
   
   This library is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
   Library General Public License for more details.
   
   You should have received a copy of the GNU Library General Public
   License along with this library; if not, write to the Free
   Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
*/

#include <AppKit/AppKit.h>

#import <Protocols/FileViewer.h>
#import <Protocols/Viewer.h>

@interface BrowserViewer : NSObject <Viewer>
{
  id bogusWindow;
  id view;

  id <FileViewer> owner;

  NSFileManager *fileManager;
  NSString      *rootPath;
  NSString      *currentPath;
  NSArray       *selection;

  NSRange displayedRange;

  CGFloat    columnWidth;
  NSUInteger columnCount;
  unsigned   numVerts;
}

- (void)reloadColumn:(NSUInteger)col;
- (void)reloadLastColumn;

- (void)doClick:(id)sender;
- (void)doDoubleClick:(id)sender;

@end
