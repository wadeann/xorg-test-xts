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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib12/gtmtnevnts/gtmtnevnts.m,v 1.1 2005-02-12 14:37:19 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: vsw5/tset/Xlib12/gtmtnevnts/gtmtnevnts.m
>># 
>># Description:
>># 	Tests for XGetMotionEvents()
>># 
>># Modifications:
>># $Log: gtmtnevnts.m,v $
>># Revision 1.1  2005-02-12 14:37:19  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:33:21  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:54:46  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:24:47  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:21:18  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:07:33  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:07:57  andy
>># Prepare for GA Release
>>#
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
>>TITLE XGetMotionEvents Xlib12
XTimeCoord *
XGetMotionEvents(display, w, start, stop, nevents_return)
Display *display = Dsp;
Window w = DRW(display);
Time start = CurrentTime;
Time stop = CurrentTime;
int *nevents_return = &_nevents_return;
>>EXTERN
static	int	_nevents_return;
>>ASSERTION Good D 1
If
the implementation supports a more complete
history of the pointer motion than is reported by event notification:
a call to xname
returns all events in the motion history buffer
that fall between the
.A start
and
.A stop
times, inclusive,
which have coordinates that lie within the specified window
(including its borders)
at its present placement
and sets
.A nevents_return
to the number of events returned.
>>STRATEGY
If a pointer motion buffer is not supported, return.
>>CODE

/* If a pointer motion buffer is not supported, return. */
	if (!config.displaymotionbuffersize)
		unsupported("Pointer motion buffer is not supported.");
	else
		untested("There is no known portable test method for this assertion");
>>ASSERTION Good C
If
the implementation does not support a more complete
history of pointer motion than is reported by event notification:
a call to xname returns no events.
>>STRATEGY
If a pointer motion buffer is supported, return.
Call XGetMotionEvents.
Verify that no events were returned.
>>CODE
XTimeCoord *tc;

/* If a pointer motion buffer is supported, return. */
	if (config.displaymotionbuffersize != 0) {
		report("Pointer motion buffer is supported.");
		UNSUPPORTED;
		return;
	}
	else
		CHECK;
	start = 0;
	stop = CurrentTime;
	*nevents_return = 1;
/* Call XGetMotionEvents. */
	tc = XCALL;
/* Verify that no events were returned. */
	if (tc != (XTimeCoord *) NULL) {
		report("Returned 0x%x, expected NULL", tc);
		FAIL;
		XFree((char*)tc);
	}
	else
		CHECK;
	if (*nevents_return != 0) {
		report("Returned %d, expected 0", *nevents_return);
		FAIL;
	}
	else
		CHECK;
	CHECKPASS(3);
>>ASSERTION Good A
When
.A start
is later than
.A stop ,
then a call to xname returns no events.
>>STRATEGY
Set stop to current time.
Call XGetMotionEvents with start greater than stop.
Verify that no events were returned.
>>CODE
XTimeCoord *tc;

/* Set stop to current time. */
	stop = gettime(display);
/* Call XGetMotionEvents with start greater than stop. */
	start = stop + 1;
	tc = XCALL;
/* Verify that no events were returned. */
	if (tc != (XTimeCoord *) NULL) {
		report("Returned 0x%x, expected NULL", tc);
		FAIL;
		XFree((char*)tc);
	}
	else
		CHECK;
	if (*nevents_return != 0) {
		report("Returned %d, expected 0", *nevents_return);
		FAIL;
	}
	else
		CHECK;
	CHECKPASS(2);
>>ASSERTION Good A
When
.A start
is in the future,
then a call to xname returns no events.
>>STRATEGY
Set stop to current time.
Set start to a future time.
Call XGetMotionEvents.
Verify that no events were returned.
>>CODE
XTimeCoord *tc;

/* Set stop to current time. */
	stop = CurrentTime;
/* Set start to a future time. */
	start = gettime(display) + 10000;
/* Call XGetMotionEvents. */
	tc = XCALL;
/* Verify that no events were returned. */
	if (tc != (XTimeCoord *) NULL) {
		report("Returned 0x%x, expected NULL", tc);
		FAIL;
		XFree((char*)tc);
	}
	else
		CHECK;
	if (*nevents_return != 0) {
		report("Returned %d, expected 0", *nevents_return);
		FAIL;
	}
	else
		CHECK;
	CHECKPASS(2);
>>ASSERTION Good B 1
>>#NOTE	I do not believe that this is testable (we can not generate events).
A call to xname with
.A stop
in the future,
is equivalent to specifying
a value of
.S CurrentTime
for
.A stop .
>>ASSERTION Good D 1
On a call to xname
the
.M x
and
.M y
members of the events returned
are set to the coordinates of the pointer
relative to the origin
of the specified window and the
.M time
member is set to the time the pointer reached this coordinate.
>>ASSERTION Bad A
.ER BadWindow
