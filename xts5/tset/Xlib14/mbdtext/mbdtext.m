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
$Header: /cvs/xtest/xtest/xts5/tset/Xlib14/mbdtext/mbdtext.m,v 1.1 2005-02-12 14:37:21 anderson Exp $

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: vsw5/tset/Xlib14/mbdtext/mbdtext.m
>># 
>># Description:
>># 	Tests for XmbDrawText()
>># 
>># Modifications:
>># $Log: mbdtext.m,v $
>># Revision 1.1  2005-02-12 14:37:21  anderson
>># Initial revision
>>#
>># Revision 8.0  1998/12/23 23:38:55  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 23:02:01  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.1  1998/09/24 01:11:47  mar
>># vswsr216: (mbd|wcd)(istr|str|text) tp1 - skip locales that are not the C locale
>># since non-C locales are not standard such that uniform a1.*.dat files can be
>># created.
>>#
>># Revision 6.0  1998/03/02 05:29:56  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:26:29  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:23:46  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  02:01:34  andy
>># Prepare for GA Release
>>#
/*

Copyright (c) 1993  X Consortium

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
Copyright 1993 by Sun Microsystems, Inc. Mountain View, CA.

                  All Rights Reserved

Permission  to  use,  copy,  modify,  and  distribute   this
software  and  its documentation for any purpose and without
fee is hereby granted, provided that the above copyright no-
tice  appear  in all copies and that both that copyright no-
tice and this permission notice appear in  supporting  docu-
mentation,  and  that the names of Sun or MIT not be used in
advertising or publicity pertaining to distribution  of  the
software  without specific prior written permission. Sun and
M.I.T. make no representations about the suitability of this
software for any purpose. It is provided "as is" without any
express or implied warranty.

SUN DISCLAIMS ALL WARRANTIES WITH REGARD TO  THIS  SOFTWARE,
INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY AND FIT-
NESS FOR A PARTICULAR PURPOSE. IN NO EVENT SHALL SUN BE  LI-
ABLE  FOR  ANY SPECIAL, INDIRECT OR CONSEQUENTIAL DAMAGES OR
ANY DAMAGES WHATSOEVER RESULTING FROM LOSS OF USE,  DATA  OR
PROFITS,  WHETHER  IN  AN  ACTION OF CONTRACT, NEGLIGENCE OR
OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION  WITH
THE USE OR PERFORMANCE OF THIS SOFTWARE.
*/
>>EXTERN
#include <locale.h>
#include <ximtest.h>

>>TITLE XmbDrawText Xlib14
void
XmbDrawText(display,d,gc,x,y,items,nitems) 
Display	*display = Dsp;
Drawable d;
GC		gc;
int 	x = 4;
int 	y = 20;
XmbTextItem	*items = deftext;
int 	nitems = NELEM(deftext);
>>EXTERN
static XmbTextItem	deftext[] = {
/* char *chars, int nchars, int delta, XFontSet font_set */
	{"hello", 5, 0,  None},
	{"world", 5, 20, None},
};

static void
fillbuf(bp)
	char	*bp;
{
	int 	i;

	for (i = 0; i < 256; i++)
		*bp++ = i;
}
>>SET startup localestartup
>>SET cleanup localecleanup
>>ASSERTION Good C
If the implementation is X11R5 or later:
On a call to xname each of the text
.A items ,
specifying a string
.M chars
of 8-bit characters
from a
.M font
with interstring spacing given by
.M delta ,
shall be drawn in turn.
>>STRATEGY
For all locales, for all fontsets, draw all the 
characters between 0&255 in all the xtest fonts, by setting
up XTestItem structs to point to groups of characters at a time.
Pixmap verify.  Only one visual will be tested, since XDrawText is
being tested elsewhere and XmbDrawText eventually calls the same
routines as XDrawText.    
>>EXTERN
#define	T1_NITEMS 3
#define	T1_GROUPSIZE 3
>>CODE
#if XT_X_RELEASE > 4
Display *dpy;
char *plocale;
XVisualInfo     *vp;
unsigned int    width, height;
char *font_list;
XFontSet pfs;
char *fontset;
char *defstr;
int missing_cnt;
char **missing_chars;
char	buf[256];
int 	delta;
int	skipped;
XmbTextItem	ti[T1_NITEMS];
#endif

#if XT_X_RELEASE > 4

	fillbuf(buf);

	dpy = Dsp;
	resetlocale();
	skipped=0;
	while(nextlocale(&plocale))
	{

		if (strcmp(plocale,"C")!=0) {
			skipped++;
			CHECK;
			report("Locale being skipped.");
			continue;
		}
		if (locale_set(plocale))
			CHECK;
		else
		{
			report("Couldn't set locale.");
			FAIL;
			continue;
		}

		if (!linklocale(plocale))
		{
			untested("Couldn't create data link.");
			FAIL;
			continue;
		}

		resetvinf(VI_WIN_PIX); 
		if(nextvinf(&vp))
		{
		int i, c;

			d = makewin(display, vp);
			gc = makegc(display, d);
			getsize(display, d, &width, &height);

			/* cycle through the fontsets */
			resetfontset();
			while(nextfontset(&font_list))
			{
				trace("Font Set %s", font_list);
				pfs = XCreateFontSet(dpy,font_list,&missing_chars,
					&missing_cnt,&defstr);
				if(pfs == NULL)
				{
					report("XCreateFontSet unable to create fontset, %s",
						font_list);
					FAIL;
					continue;
				}

				for (i = 0; i < T1_NITEMS; i++)
					ti[i].font_set = None;
				delta = 0;

				items = ti;
				nitems = T1_NITEMS;

				ti[0].font_set = pfs;
				for (c = 0; c < 256; )
				{
					debug(1, "Chars from %d...", c);
					for(y=20; y < height; y+=20)
					{
						for (i = 0; i < T1_GROUPSIZE; i++)
						{
							if (c < 256)
							{
								ti[i].chars = buf+c;
								ti[i].nchars = (256-c<=T1_GROUPSIZE)? 256-c: T1_GROUPSIZE;
								c += T1_GROUPSIZE;
								ti[i].delta = delta;
								if (delta++ >= 7)
									delta = -2;
							}
						}
						XCALL;
					}
					debug(1, "..to char %d", c);
					PIXCHECK(display, d);
					dclear(display, d);
				}	/* for c */
				XFreeFontSet(dpy,pfs);
				XFreeStringList(missing_chars);
			}	/* nextvinf */
		}	/* nextfontset */
	}	/* nextlocale */

	unlinklocales();

	CHECKPASS(nlocales()+(256/(((height/20)-1)*T1_GROUPSIZE*T1_GROUPSIZE)-1)*(nlocales()-skipped)*nfontset());
#else

	tet_infoline("INFO: Implementation not X11R5 or greater");
	tet_result(TET_UNSUPPORTED);
#endif

