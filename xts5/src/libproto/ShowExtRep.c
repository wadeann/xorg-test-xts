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
* $Header: /cvs/xtest/xtest/xts5/src/libproto/ShowExtRep.c,v 1.1 2005-02-12 14:37:16 anderson Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	vsw5/src/libproto/ShowExtRep.c
*
* Description:
*	Protocol test support routines
*
* Modifications:
* $Log: ShowExtRep.c,v $
* Revision 1.1  2005-02-12 14:37:16  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:25:08  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:21  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:30  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:03  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.0  1995/12/15 08:43:56  tbr
* Branch point for Release 5.0.0
*
* Revision 3.1  1995/12/15  00:41:35  andy
* Prepare for GA Release
*
*/

/*
Portions of this software are based on Xlib and X Protocol Test Suite.
We have used this material under the terms of its copyright, which grants
free use, subject to the conditions below.  Note however that those
portions of this software that are based on the original Test Suite have
been significantly revised and that all such revisions are copyright (c)
1995 Applied Testing and Technology, Inc.  Insomuch as the proprietary
revisions cannot be separated from the freely copyable material, the net
result is that use of this software is governed by the ApTest copyright.

Copyright (c) 1990, 1991  X Consortium

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
X CONSORTIUM BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

Except as contained in this notice, the name of the X Consortium shall not be
used in advertising or otherwise to promote the sale, use or other dealings
in this Software without prior written authorization from the X Consortium.

Copyright 1990, 1991 by UniSoft Group Limited.

Permission to use, copy, modify, distribute, and sell this software and
its documentation for any purpose is hereby granted without fee,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of UniSoft not be
used in advertising or publicity pertaining to distribution of the
software without specific, written prior permission.  UniSoft
makes no representations about the suitability of this software for any
purpose.  It is provided "as is" without express or implied warranty.

Copyright 1988 by Sequent Computer Systems, Inc., Portland, Oregon

                        All Rights Reserved

Permission to use, copy, modify, and distribute this software and its
documentation for any purpose and without fee is hereby granted,
provided that the above copyright notice appears in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of Sequent not be used
in advertising or publicity pertaining to distribution or use of the
software without specific, written prior permission.

SEQUENT DISCLAIMS ALL WARRANTIES WITH REGARD TO THIS SOFTWARE, INCLUDING
ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS, IN NO EVENT SHALL
SEQUENT BE LIABLE FOR ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS,
WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION,
ARISING OUT OF OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS
SOFTWARE.
*/

#ifndef lint
static char rcsid[]="$Header: /cvs/xtest/xtest/xts5/src/libproto/ShowExtRep.c,v 1.1 2005-02-12 14:37:16 anderson Exp $";
#endif

#include "XstlibInt.h"
extern int XInputMajorOpcode;

void
Show_Ext_Rep(mp,type,bytes_given)
xReply *mp;
int type;
long bytes_given;
{
#ifdef INPUTEXTENSION
	if (type & 0x0ff == XInputMajorOpcode) {
		switch (type >> 8) {
		case X_GetExtensionVersion:
			BPRINTF1("GetExtensionVersion:\n");
			break;
		case X_ListInputDevices:
			BPRINTF1("ListInputDevices:\n");
			break;
		case X_OpenDevice:
			BPRINTF1("OpenDevice:\n");
			break;
		case X_SetDeviceMode:
			BPRINTF1("SetDeviceMode:\n");
			break;
		case X_GetSelectedExtensionEvents:
			BPRINTF1("GetSelectedExtensionEvents:\n");
			break;
		case X_GetDeviceDontPropagateList:
			BPRINTF1("GetDeviceDontPropagateList:\n");
			break;
		case X_GetDeviceMotionEvents:
			BPRINTF1("GetDeviceMotionEvents:\n");
			break;
		case X_ChangeKeyboardDevice:
			BPRINTF1("ChangeKeyboardDevice:\n");
			break;
		case X_ChangePointerDevice:
			BPRINTF1("ChangePointerDevice:\n");
			break;
		case X_GrabDevice:
			BPRINTF1("GrabDevice:\n");
			break;
		case X_GetDeviceFocus:
			BPRINTF1("GetDeviceFocus:\n");
			break;
		case X_GetFeedbackControl:
			BPRINTF1("GetFeedbackControl:\n");
			break;
		case X_GetDeviceKeyMapping:
			BPRINTF1("GetDeviceKeyMapping:\n");
			break;
		case X_GetDeviceModifierMapping:
			BPRINTF1("GetDeviceModifierMapping:\n");
			break;
		case X_SetDeviceModifierMapping:
			BPRINTF1("SetDeviceModifierMapping:\n");
			break;
		case X_GetDeviceButtonMapping:
			BPRINTF1("GetDeviceButtonMapping:\n");
			break;
		case X_SetDeviceButtonMapping:
			BPRINTF1("SetDeviceButtonMapping:\n");
			break;
		case X_QueryDeviceState:
			BPRINTF1("QueryDeviceState:\n");
			break;
		case X_SetDeviceValuators:
			BPRINTF1("SetDeviceValuators:\n");
			break;
		case X_GetDeviceControl:
			BPRINTF1("GetDeviceControl:\n");
			break;
		case X_ChangeDeviceControl:
			BPRINTF1("GetDeviceControl:\n");
			break;
		default:
			BPRINTF1("Impossible request:\n");
			BPRINTF2("\trepType = %ld\n",(long) ((xGetDeviceControlReq *)mp)->reqType);
			break;
		}
	}
	else 	{
		BPRINTF1("Unsupported Extension request:\n");
		BPRINTF2("\treqType = %ld\n",(long) ((xGetDeviceControlReq *)mp)->reqType);
	}
#endif
}
