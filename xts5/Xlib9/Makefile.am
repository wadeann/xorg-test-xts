include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

libexec_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	XClearArea/XClearArea \
	XClearWindow/XClearWindow \
	XCopyArea/XCopyArea \
	XCopyPlane/XCopyPlane \
	XDrawArc/XDrawArc \
	XDrawArcs/XDrawArcs \
	XDrawImageString16/XDrawImageString16 \
	XDrawImageString/XDrawImageString \
	XDrawLine/XDrawLine \
	XDrawLines/XDrawLines \
	XDrawPoint/XDrawPoint \
	XDrawPoints/XDrawPoints \
	XDrawRectangle/XDrawRectangle \
	XDrawRectangles/XDrawRectangles \
	XDrawSegments/XDrawSegments \
	XDrawString/XDrawString \
	XDrawString16/XDrawString16 \
	XDrawText/XDrawText \
	XDrawText16/XDrawText16 \
	XFillArc/XFillArc \
	XFillArcs/XFillArcs \
	XFillPolygon/XFillPolygon \
	XFillRectangle/XFillRectangle \
	XFillRectangles/XFillRectangles \
	XFreeFont/XFreeFont \
	XFreeFontInfo/XFreeFontInfo \
	XFreeFontNames/XFreeFontNames \
	XFreeFontPath/XFreeFontPath \
	XGetFontProperty/XGetFontProperty \
	XGetFontPath/XGetFontPath \
	XGetImage/XGetImage \
	XGetSubImage/XGetSubImage \
	XLoadFont/XLoadFont \
	XLoadQueryFont/XLoadQueryFont \
	XListFonts/XListFonts \
	XListFontsWithInfo/XListFontsWithInfo \
	XPutImage/XPutImage \
	XQueryFont/XQueryFont \
	XQueryTextExtents16/XQueryTextExtents16 \
	XQueryTextExtents/XQueryTextExtents \
	XSetFontPath/XSetFontPath \
	XTextExtents16/XTextExtents16 \
	XTextExtents/XTextExtents \
	XTextWidth/XTextWidth \
	XTextWidth16/XTextWidth16 \
	XUnloadFont/XUnloadFont