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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib3/nxtrqst/nxtrqst.m,v 1.1 2005-02-12 14:37:32 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: vsw5/tset/Xlib3/nxtrqst/nxtrqst.m
>># 
>># Description:
>># 	Tests for XNextRequest()
>># 
>># Modifications:
>># $Log: nxtrqst.m,v $
>># Revision 1.1  2005-02-12 14:37:32  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:35:19  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:57:46  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:26:34  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:23:07  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:12:54  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:15:59  andy
>># Prepare for GA Release
>>#
>>#:
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

Permission to use, copy, modify, distribute, and sell this software and
its documentation for any purpose is hereby granted without fee,
provided that the above copyright notice appear in all copies and that
both that copyright notice and this permission notice appear in
supporting documentation, and that the name of UniSoft not be
used in advertising or publicity pertaining to distribution of the
software without specific, written prior permission.  UniSoft
makes no representations about the suitability of this software for any
purpose.  It is provided "as is" without express or implied warranty.
*/
>>SET   macro
>>TITLE XNextRequest Xlib3
unsigned long
XNextRequest(display)
Display	*display = Dsp;
>>ASSERTION Good B 1
A call to xname returns the serial number of the next request over the
connection specified by the
.A display
argument.
>>STRATEGY
Obtain the serial number of the last request processed by the server using XLastKnownRequestProcessed.
Obtain the serial number of the next request to be sent using xname.
Verify that the two serial numbers are not the same.
>>CODE
unsigned long	sno, nno;

	sno = XLastKnownRequestProcessed(display);
	nno = XCALL;
	report("Last processed serial number was %lu, next serial number is %lu.", sno, nno);
	if(sno == nno) {
		report("The next serial number (%lu) was not different to the current serial number.", nno);
		FAIL;
	} else
		CHECK;

	CHECKUNTESTED(1);

>>ASSERTION Good B 1
Serial numbers are maintained separately for each display connection.
>>STRATEGY
Open two displays using XOpenDisplay.
Obtain the next serial number for each display using xname.
Perform an XNoOp request on the first display.
Verify that the next serial number for that display is not the same.
Verify that the next serial number for the second display is the same.
>>#
>># COMMENT :	The mad posturing with _startcall and _endcall is to
>>#		avoid the XSync calls which are planted by XCALL as
>>#		these call increment the serial number.
>>#
>># Cal 23/07/91
>>#
>>CODE
unsigned long	nr1, nr2, nar1, nar2;
Display		*disp2;

	disp2 = opendisplay();

	_startcall(display);
	nr1 = XNextRequest(display);
	_endcall(display);
	if (geterr() != Success) {
		report("Got %s, Expecting Success", errorname(geterr()));
		FAIL;
	} else
		CHECK;

	_startcall(disp2);
	nr2 = XNextRequest(disp2);
	_endcall(disp2);
	if (geterr() != Success) {
		report("Got %s, Expecting Success", errorname(geterr()));
		FAIL;
	} else
		CHECK;

	XNoOp(display);

	_startcall(display);
	nar1 = XNextRequest(display);
	_endcall(display);
	if (geterr() != Success) {
		report("Got %s, Expecting Success", errorname(geterr()));
		FAIL;
	} else
		CHECK;

	_startcall(disp2);
	nar2 = XNextRequest(disp2);
	_endcall(disp2);

	if (geterr() != Success) {
		report("Got %s, Expecting Success", errorname(geterr()));
		FAIL;
	} else
		CHECK;

	if(nr1 == nar1) {
		delete("The next serial number (%lu) was the same after a XNoOp request.", nr1);
		return;
	} else
		CHECK;


	if(nr2 != nar2) {
		report("The next serial number changed without a request.");
		FAIL;
	} else
		CHECK;

	CHECKUNTESTED(6);







