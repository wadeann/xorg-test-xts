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
* $Header: /cvs/xtest/xtest/xts5/src/libproto/XstlibInt.h,v 1.1 2005-02-12 14:37:16 anderson Exp $
*
* Copyright Applied Testing and Technology Inc. 1995
* All rights reserved
*
* Project: VSW5
*
* File:	vsw5/src/libproto/XstlibInt.h
*
* Description:
*	X test suite protocol test library include file
*
* Modifications:
* $Log: XstlibInt.h,v $
* Revision 1.1  2005-02-12 14:37:16  anderson
* Initial revision
*
* Revision 8.0  1998/12/23 23:25:16  mar
* Branch point for Release 5.0.2
*
* Revision 7.0  1998/10/30 22:43:30  mar
* Branch point for Release 5.0.2b1
*
* Revision 6.0  1998/03/02 05:17:38  tbr
* Branch point for Release 5.0.1
*
* Revision 5.0  1998/01/26 03:14:10  tbr
* Branch point for Release 5.0.1b1
*
* Revision 4.2  1998/01/26 01:15:54  tbr
* vswsr111
* Changes to allow BAD_LENGTH and TOO_LONG testing if client and server
* both support Big-Requests extension
*
* Revision 4.1  1996/03/22 17:05:52  andy
* Added string.h include
*
* Revision 4.0  1995/12/15  08:44:22  tbr
* Branch point for Release 5.0.0
*
* Revision 3.2  1995/12/15  00:42:05  andy
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

#include "Xstlib.h"
#include <stdio.h>
#include <string.h>
#include <errno.h>

#ifndef NULL
#define NULL 0
#endif

void Copy_Padded_String16();
void Copy_Padded_String8();
void SendIt(int cl, unsigned long bytesToSend, int isABigRequest);
void Send_String16();
void Send_TextItem16();
void Send_TextItem8();
void Send_Value_List();
unsigned char unpack1();
unsigned short unpack2();
unsigned long unpack4();
void pack1();
void pack2();
void pack4();
void packpad();
void XstIOError();
int Xst_Read();
void squeeze_me_in(int cl, unsigned long len);

/* 128 bytes per reply plus 32736 longwords for reply data (just big enough
to do GetRootImage on NCD terminal) */

#define OBUFSIZE (4*32768+128) /* Output buffer size (for sending on the wire) */
#define IBUFSIZE OBUFSIZE	/* input buffer size (max reply size) */

/* the following magic number makes the GetImage reply able to be shown */
/* this is a temporary quick fix */

#define PRTBUFSIZ 1024	/* Print buffer size (for Show_* routines) */

#define	XTESTKNOBS	"XTestKnobs"	/* file to change default test
					   reporting parameters */
#define	SERVER_DEF	""		/* the X server */

/*
 *	Macros for sending messages to the display server via the 
 *	'Display' structure buffer
 *
 */

#define send1(cl,val)	*((Get_Display(cl)->bufptr)++) = (unsigned char) val

#define send2(cl,val)	pack2(&(Get_Display(cl)->bufptr),(short)val,Xst_clients[cl].cl_swap)

#define send4(cl,val)	pack4(&(Get_Display(cl)->bufptr),(long)val,Xst_clients[cl].cl_swap)

#define send2_lsb(cl,val)  pack2_lsb(&(Get_Display(cl)->bufptr),(short)val)

#define sendpad(cl,cnt)	wbzero(Get_Display(cl)->bufptr,cnt);\
			Get_Display(cl)->bufptr += cnt


/*
 *	Defines used in Show_* for creating a print buffer.
 */

#define BPRINTF1(fmt)	Log_Debug2(fmt);
#define VBPRINTF1(fmt)	Log_Debug3(fmt);

#define BPRINTF2(fmt,var)	Log_Debug2((fmt),(var));
#define VBPRINTF2(fmt,var)	Log_Debug3((fmt),(var));

#define	FORMAT8		8
#define	FORMAT16	16
#define	FORMAT32	32
#define	FORMATtimecoord	1
#define FORMATrgb	2
#define FORMATpoint	3
#define FORMATrectangle	4
#define	FORMATarc	5
#define	FORMATcoloritem	6
#define FORMATfontprop  7
#define FORMATcharinfo  9

/*
 *	Defines used to indicate unimplemented functions - their
 *	appearance in the log file indicates use of a portion of
 *	a library routine which has not been completely fleshed out.
 */

#define CANT_MAKE(structname,eltname)	\
    {\
	char ebuf[132];\
	sprintf(ebuf,"\tCANT_MAKE (%s->%s)\n",structname,eltname);\
	Log_Debug(ebuf);\
    }

#define CANT_SEND(structname,eltname)	\
    {\
	char ebuf[132];\
	sprintf(ebuf,"\tCANT_SEND (%s->%s)\n",structname,eltname);\
	Log_Debug(ebuf);\
    }

#define CANT_SHOW(structname,eltname)	\
    {\
	char ebuf[132];\
	sprintf(ebuf,"\tCANT_SHOW (%s->%s)\n",structname,eltname);\
	Log_Debug(ebuf);\
    }

/*
 *	Safety net for all defaults in switch statements - this indicates
 *	an internal error in the library
 */

#define DEFAULT_ERROR	\
    {\
	char ebuf[132];\
	sprintf(ebuf,"\tDEFAULT_ERROR(file = %s, line = %d)\n",__FILE__,__LINE__);\
	Log_Msg(ebuf);\
	Delete();\
    }

/*
 *	Externs for test-wide globals
 */
extern char *Xst_server_node;	/* the X server */
extern int Xst_required_byte_sex;/* byte sex wanted */
extern int  Xst_timeout_value;	/* seconds that Expect will wait */
extern int  Xst_visual_check;	/* seconds to delay at Visual_Check calls */

extern int Xst_byte_sex;	/* client byte sex for this connection */
extern int Xst_error_count;	/* number of calls to Log_Error */
extern int Xst_delete_count;	/* number of calls to Log_Del */
extern int Xst_untested_count;	/* indicates to Log_Close that Untested called */
extern char *Xst_def_font8;	/* default 8-bit font to use */
extern char *Xst_def_font16;	/* default 16-bit font to use */
extern int Xst_protocol_version;
extern int Xst_protocol_revision;
extern int Xst_override;

/*
 * Timer assignments
 */

#define EXPECT_TIMER_ID		1
#define VISUAL_CHECK_TIMER	2
#define CONNECT_TIMER_ID	3
