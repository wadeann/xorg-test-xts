/*
Copyright (c) 2005 X.Org Foundation LLC

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
/*
* $Header: /cvs/xtest/xtest/xts5/include/X11/Xaw/Sme.h,v 1.1 2005-02-12 14:37:13 anderson Exp $
*
* Copyright (c) Applied Testing and Technology, Inc. 1995
* All Rights Reserved.
*
* Project: VSW5
*
* File: vsw5/include/X11/Xaw/Sme.h
*
* Description:
*	Defines used by the version of Athena widgets include in VSW5
*
* Modifications:
* $Log: Sme.h,v $
* Revision 1.1  2005-02-12 14:37:13  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:23:10  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:41:12  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:15:42  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:12:14  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:39:23  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:35:31  andy
* Prepare for GA Release
*
*/

/*
 * Copyright 1989 Massachusetts Institute of Technology
 *
 * Permission to use, copy, modify, distribute, and sell this software and its
 * documentation for any purpose is hereby granted without fee, provided that
 * the above copyright notice appear in all copies and that both that
 * copyright notice and this permission notice appear in supporting
 * documentation, and that the name of M.I.T. not be used in advertising or
 * publicity pertaining to distribution of the software without specific,
 * written prior permission.  M.I.T. makes no representations about the
 * suitability of this software for any purpose.  It is provided "as is"
 * without express or implied warranty.
 *
 * M.I.T. DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING ALL
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL M.I.T.
 * BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
 * WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION
 * OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF OR IN 
 * CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
 */

/*
 * Sme.h - Public Header file for Sme object.
 *
 * This is the public header file for the Athena Sme object.
 * It is intended to be used with the simple menu widget.  
 *
 * Date:    April 3, 1989
 *
 * By:      Chris D. Peterson
 *          MIT X Consortium 
 *          kit@expo.lcs.mit.edu
 */

#ifndef _Sme_h
#define _Sme_h

#include <X11/RectObj.h>

/****************************************************************
 *
 * Sme Object
 *
 ****************************************************************/

/* Simple Menu Entry Resources:

 Name		     Class		RepType		Default Value
 ----		     -----		-------		-------------
 callback            Callback		Pointer		NULL
 destroyCallback     Callback		Pointer		NULL
 height		     Height		Dimension	0
 sensitive	     Sensitive		Boolean		True
 width		     Width		Dimension	0
 x		     Position		Position	0n
 y		     Position		Position	0

*/

typedef struct _SmeClassRec*	SmeObjectClass;
typedef struct _SmeRec*	        SmeObject;

extern WidgetClass smeObjectClass;

#endif /* _Sme_h */
