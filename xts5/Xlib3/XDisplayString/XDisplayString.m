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

Copyright (c) Applied Testing and Technology, Inc. 1995
All Rights Reserved.

>># Project: VSW5
>># 
>># File: xts5/Xlib3/XDisplayString/XDisplayString.m
>># 
>># Description:
>># 	Tests for XDisplayString()
>># 
>># Modifications:
>># $Log: dsplystr.m,v $
>># Revision 1.2  2005-11-03 08:43:22  jmichael
>># clean up all vsw5 paths to use xts5 instead.
>>#
>># Revision 1.1.1.2  2005/04/15 14:05:24  anderson
>># Reimport of the base with the legal name in the copyright fixed.
>>#
>># Revision 8.0  1998/12/23 23:35:12  mar
>># Branch point for Release 5.0.2
>>#
>># Revision 7.0  1998/10/30 22:57:38  mar
>># Branch point for Release 5.0.2b1
>>#
>># Revision 6.0  1998/03/02 05:26:27  tbr
>># Branch point for Release 5.0.1
>>#
>># Revision 5.0  1998/01/26 03:23:00  tbr
>># Branch point for Release 5.0.1b1
>>#
>># Revision 4.0  1995/12/15 09:12:35  tbr
>># Branch point for Release 5.0.0
>>#
>># Revision 3.1  1995/12/15  01:15:37  andy
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
>>TITLE XDisplayString Xlib3
char *
XDisplayString(display);
Display	*display = Dsp;
>>MAKE
>>#
>>#
>># Plant some rules in the Makefile to construct
>># stand-alone executable Test1 to allow the setting
>># of environment variables.
>>#
>># Cal 22/6/91
>>#
#
# The following lines are copied from the .m file by mc
# under control of the >>MAKE directive
# to create rules for the executable file Test1.
#
AUXFILES=Test1
AUXCLEAN=Test1.o Test1

all: Test

Test1 : Test1.o $(LIBS) $(top_builddir)/src/tet3/tcm/libtcmchild.la
	$(CC) $(LDFLAGS) -o $@ Test1.o $(top_builddir)/src/tet3/tcm/libtcmchild.la $(LIBLOCAL) $(LIBS) $(SYSLIBS)

#
# End of section copied from the .m file.
#
>>ASSERTION Good A
A call to xname returns the string that was used as the argument to the
.S XOpenDisplay
call that returned the value used as the
.A display
argument.
>>STRATEGY
Open a connection using XOpenDisplay.
Obtain the display string using xname.
Verify that the value of the string is the parameter used in XOpenDisplay.
Close the display using XCloseDisplay.
>>CODE
char	*rdispstr;

	rdispstr = XCALL;

	if(rdispstr == (char *) NULL) {
		report("%s() returned NULL.", TestName);
		FAIL;
	} else {
		CHECK;
		if(strcmp(rdispstr, config.display) != 0) {
			report("%s() returned \"%s\" instead of \"%s\".", TestName, rdispstr, config.display);
			FAIL;
		} else
			CHECK;
	}

	CHECKPASS(2);

>>ASSERTION Good C
If the system is POSIX compliant:
When the argument passed to the
.S XOpenDisplay
call that returned the value used as the
.A display
argument was NULL, then a call to xname returns the value of
the DISPLAY environment variable when
.S XOpenDisplay
was called.
>>STRATEGY
Fork a child process using tet_fork.
In child :
  Exec the file \"./Test1\" with the environment variable DISPLAY set.
  Open the display "" using XOpenDisplay.
  Obtain the value of the display string using xname.
  Obtain the value of the DISPLAY environment variable.
  Verify that the two strings are identical.
>>CODE

	if(config.posix_system == 0) {
		unsupported("This assertion can only be tested on a POSIX system.");
	} else
		(void) tet_fork(t002exec, TET_NULLFP, 0, 0xFF);

>>EXTERN
extern char **environ;

static void
t002exec()
{
char	*argv[2];
char	*str;
char	*dstr;
char	*mstr = "DISPLAY=%s";

	if((dstr = getenv("DISPLAY")) == (char *) NULL) {
		delete("DISPLAY configuration variable is not defined.");
		return;
	}		

	if((str = (char *) malloc( strlen(dstr) + strlen(mstr) + 1)) == (char *) NULL) {
		delete("malloc() failed.");
		return;
	}

	sprintf(str, mstr, dstr);

	argv[0] = "./Test1";
	argv[1] = (char *) NULL;

	if (xtest_putenv( str ) ) {
		delete("xtest_putenv failed");
		return;
	}

	(void) tet_exec("./Test1", argv, environ);

	delete("Exec of file ./Test1 failed");
	free( (char *) str);
}
