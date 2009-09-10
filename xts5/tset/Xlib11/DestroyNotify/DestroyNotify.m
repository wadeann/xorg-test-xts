Copyright (c) 2005 X.Org Foundation L.L.C.

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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib11/DestroyNotify/DestroyNotify.m,v 1.2 2005-11-03 08:42:26 jmichael Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/tset/Xlib11/DestroyNotify/DestroyNotify.m
>># 
>># Description:
>># 	Tests for DestroyNotify()
>># 
>># Modifications:
>># $Log: dstryntfy.m,v $
>># Revision 1.2  2005-11-03 08:42:26  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:16  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:31:11  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:50:42  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:22:53  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:19:25  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:01:13  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  00:57:50  andy
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
>>TITLE DestroyNotify Xlib11
>>EXTERN
#define	EVENT		DestroyNotify
#define	MASK		StructureNotifyMask
#define	MASKP		SubstructureNotifyMask
>>#NOTEm >>ASSERTION
>>#NOTEm When ARTICLE xname event is generated for a particular window,
>>#NOTEm then ARTICLE xname event will not be generated for
>>#NOTEm any inferiors of this window.
>>#NOTEm >>ASSERTION
>>#NOTEm When a window is destroyed
>>#NOTEm as a result of a call to
>>#NOTEm .F XDestroyWindow
>>#NOTEm or
>>#NOTEm .F XDestroySubwindows ,
>>#NOTEm then ARTICLE xname event is generated.
>>ASSERTION Good A
When a xname event is generated,
then all clients having set
.S StructureNotifyMask
event mask bits on the destroyed window are delivered
a xname event.
>>STRATEGY
Create clients client2 and client3.
Create window.
Select for DestroyNotify events using StructureNotifyMask.
Select for DestroyNotify events using StructureNotifyMask with client2.
Select for no events with client3.
Generate DestroyNotify event.
Verify that a DestroyNotify event was delivered.
Verify that event member fields are correctly set.
Verify that a DestroyNotify event was delivered to client2.
Verify that no events were delivered to client3.
>>CODE
Display	*display = Dsp;
Display	*client2;
Display	*client3;
Window	w;
int	count;
XEvent	event_return;
XDestroyWindowEvent good;

/* Create clients client2 and client3. */
	if ((client2 = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client2.");
		return;
	}
	else
		CHECK;
	if ((client3 = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client3.");
		return;
	}
	else
		CHECK;
/* Create window. */
	w = XCreateSimpleWindow(display, DRW(display), 1, 1, W_STDWIDTH, W_STDHEIGHT, 1, 0L, 0L);
/* Select for DestroyNotify events using StructureNotifyMask. */
	XSelectInput(display, w, MASK);
/* Select for DestroyNotify events using StructureNotifyMask with client2. */
	XSelectInput(client2, w, MASK);
/* Select for no events with client3. */
	XSelectInput(client3, w, NoEventMask);
/* Generate DestroyNotify event. */
	XSync(display, True);
	XSync(client2, True);
	XSync(client3, True);
	XDestroyWindow(display, w);
	XSync(display, False);
	XSync(client2, False);
	XSync(client3, False);
/* Verify that a DestroyNotify event was delivered. */
/* Verify that event member fields are correctly set. */
	count = XPending(display);
	if (count != 1) {
		report("Got %d events, expected %d", count, 1);
		FAIL;
		return;
	}
	else
		CHECK;
	XNextEvent(display, &event_return);
	good = event_return.xdestroywindow;
	good.type = EVENT;
	good.event = w;
	good.window = w;
	if (checkevent((XEvent *) &good, &event_return)) {
		report("Unexpected values in delivered event");
		FAIL;
	}
	else
		CHECK;
/* Verify that a DestroyNotify event was delivered to client2. */
	count = XPending(client2);
	if (count != 1) {
		report("Got %d events, expected %d for client2", count, 1);
		FAIL;
		return;
	}
	else
		CHECK;
	XNextEvent(client2, &event_return);
	good = event_return.xdestroywindow;
	good.type = EVENT;
	good.event = w;
	good.window = w;
	if (checkevent((XEvent *) &good, &event_return)) {
		report("Unexpected values in delivered event to client2");
		FAIL;
	}
	else
		CHECK;
/* Verify that no events were delivered to client3. */
	count = XPending(client3);
	if (count != 0) {
		report("Got %d events, expected %d for client3", count, 0);
		FAIL;
		return;
	}
	else
		CHECK;
	
	CHECKPASS(7);
>>ASSERTION Good A
When a xname event is generated,
then all clients having set
.S SubstructureNotifyMask
event mask bits on the parent of the destroyed window are delivered
a xname event.
>>STRATEGY
Create clients client2 and client3.
Create parent window.
Create window.
Select for DestroyNotify events using SubstructureNotifyMask.
Select for DestroyNotify events using SubstructureNotifyMask with client2.
Select for no events with client3.
Generate DestroyNotify event.
Verify that a DestroyNotify event was delivered.
Verify that event member fields are correctly set.
Verify that a DestroyNotify event was delivered to client2.
Verify that no events were delivered to client3.
>>CODE
Display	*display = Dsp;
Display	*client2;
Display	*client3;
Window	parent, w;
int	count;
XEvent	event_return;
XDestroyWindowEvent good;

/* Create clients client2 and client3. */
	if ((client2 = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client2.");
		return;
	}
	else
		CHECK;
	if ((client3 = opendisplay()) == (Display *) NULL) {
		delete("Couldn't create client3.");
		return;
	}
	else
		CHECK;
/* Create parent window. */
	parent = mkwin(display, (XVisualInfo *) NULL, (struct area *) NULL, False);
/* Create window. */
	w = XCreateSimpleWindow(display, parent, 1, 1, W_STDWIDTH, W_STDHEIGHT, 1, 0L, 0L);
/* Select for DestroyNotify events using SubstructureNotifyMask. */
	XSelectInput(display, parent, MASKP);
/* Select for DestroyNotify events using SubstructureNotifyMask with client2. */
	XSelectInput(client2, parent, MASKP);
/* Select for no events with client3. */
	XSelectInput(client3, parent, NoEventMask);
/* Generate DestroyNotify event. */
	XSync(display, True);
	XSync(client2, True);
	XSync(client3, True);
	XDestroyWindow(display, w);
	XSync(display, False);
	XSync(client2, False);
	XSync(client3, False);
/* Verify that a DestroyNotify event was delivered. */
/* Verify that event member fields are correctly set. */
	count = XPending(display);
	if (count != 1) {
		report("Got %d events, expected %d", count, 1);
		FAIL;
		return;
	}
	else
		CHECK;
	XNextEvent(display, &event_return);
	good = event_return.xdestroywindow;
	good.type = EVENT;
	good.event = parent;
	good.window = w;
	if (checkevent((XEvent *) &good, &event_return)) {
		report("Unexpected values in delivered event");
		FAIL;
	}
	else
		CHECK;
/* Verify that a DestroyNotify event was delivered to client2. */
	count = XPending(client2);
	if (count != 1) {
		report("Got %d events, expected %d for client2", count, 1);
		FAIL;
		return;
	}
	else
		CHECK;
	XNextEvent(client2, &event_return);
	good = event_return.xdestroywindow;
	good.type = EVENT;
	good.event = parent;
	good.window = w;
	if (checkevent((XEvent *) &good, &event_return)) {
		report("Unexpected values in delivered event to client2");
		FAIL;
	}
	else
		CHECK;
/* Verify that no events were delivered to client3. */
	count = XPending(client3);
	if (count != 0) {
		report("Got %d events, expected %d for client3", count, 0);
		FAIL;
		return;
	}
	else
		CHECK;
	
	CHECKPASS(7);
>>ASSERTION def
>>#NOTE	Tested for in previous two assertions.
When a xname event is generated,
then
clients not having set
.S StructureNotifyMask
event mask bits on the
destroyed window
and also not having set
.S SubstructureNotifyMask
event mask bits on the
parent of the destroyed window
are not delivered
a xname event.
>>#NOTEs >>ASSERTION
>>#NOTEs When ARTICLE xname event is delivered,
>>#NOTEs then
>>#NOTEs .M type
>>#NOTEs is set to
>>#NOTEs xname.
>>#NOTEs >>ASSERTION
>>#NOTEs >>#NOTE The method of expansion is not clear.
>>#NOTEs When ARTICLE xname event is delivered,
>>#NOTEs then
>>#NOTEs .M serial
>>#NOTEs is set
>>#NOTEs from the serial number reported in the protocol
>>#NOTEs but expanded from the 16-bit least-significant bits
>>#NOTEs to a full 32-bit value.
>>#NOTEm >>ASSERTION
>>#NOTEm When ARTICLE xname event is delivered
>>#NOTEm and the event came from a
>>#NOTEm .S SendEvent
>>#NOTEm protocol request,
>>#NOTEm then
>>#NOTEm .M send_event
>>#NOTEm is set to
>>#NOTEm .S True .
>>#NOTEs >>ASSERTION
>>#NOTEs When ARTICLE xname event is delivered
>>#NOTEs and the event was not generated by a
>>#NOTEs .S SendEvent
>>#NOTEs protocol request,
>>#NOTEs then
>>#NOTEs .M send_event
>>#NOTEs is set to
>>#NOTEs .S False .
>>#NOTEs >>ASSERTION
>>#NOTEs When ARTICLE xname event is delivered,
>>#NOTEs then
>>#NOTEs .M display
>>#NOTEs is set to
>>#NOTEs a pointer to the display on which the event was read.
>>#NOTEs >>ASSERTION
>>#NOTEs When ARTICLE xname event is delivered
>>#NOTEs and
>>#NOTEs .S StructureNotify
>>#NOTEs was selected,
>>#NOTEs then
>>#NOTEs .M event
>>#NOTEs is set to
>>#NOTEs the WINDOWTYPE window.
>>#NOTEs >>ASSERTION
>>#NOTEs When ARTICLE xname event is delivered
>>#NOTEs and
>>#NOTEs .S SubstructureNotify
>>#NOTEs was selected,
>>#NOTEs then
>>#NOTEs .M event
>>#NOTEs is set to
>>#NOTEs the WINDOWTYPE window's parent.
>>#NOTEs >>ASSERTION
>>#NOTEs >>#NOTE Global except for MappingNotify and KeymapNotify.
>>#NOTEs When ARTICLE xname event is delivered,
>>#NOTEs then
>>#NOTEs .M window
>>#NOTEs is set to
>>#NOTEs the
>>#NOTEs ifdef(`WINDOWTYPE', WINDOWTYPE, event)
>>#NOTEs window.