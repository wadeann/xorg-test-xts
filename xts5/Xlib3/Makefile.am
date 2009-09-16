include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

libexec_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

# Tests ending in _m test the macro version of Xlib
tprogs = XAllPlanes/XAllPlanes \
	XBlackPixel/XBlackPixel XBlackPixel/XBlackPixel_m \
	XBlackPixelOfScreen/XBlackPixelOfScreen XBlackPixelOfScreen/XBlackPixelOfScreen_m \
	XBitmapBitOrder/XBitmapBitOrder XBitmapBitOrder/XBitmapBitOrder_m \
	XBitmapPad/XBitmapPad XBitmapPad/XBitmapPad_m \
	XBitmapUnit/XBitmapUnit XBitmapUnit/XBitmapUnit_m \
	XCellsOfScreen/XCellsOfScreen XCellsOfScreen/XCellsOfScreen_m \
	XCloseDisplay/XCloseDisplay \
	XConnectionNumber/XConnectionNumber XConnectionNumber/XConnectionNumber_m \
	XDefaultColormap/XDefaultColormap XDefaultColormap/XDefaultColormap_m \
	XDefaultColormapOfScreen/XDefaultColormapOfScreen XDefaultColormapOfScreen/XDefaultColormapOfScreen_m \
	XDefaultDepth/XDefaultDepth XDefaultDepth/XDefaultDepth_m \
	XDefaultDepthOfScreen/XDefaultDepthOfScreen XDefaultDepthOfScreen/XDefaultDepthOfScreen_m \
	XDefaultGC/XDefaultGC XDefaultGC/XDefaultGC_m \
	XDefaultGCOfScreen/XDefaultGCOfScreen XDefaultGCOfScreen/XDefaultGCOfScreen_m \
	XDefaultRootWindow/XDefaultRootWindow XDefaultRootWindow/XDefaultRootWindow_m \
	XDefaultScreen/XDefaultScreen XDefaultScreen/XDefaultScreen_m \
	XDefaultScreenOfDisplay/XDefaultScreenOfDisplay XDefaultScreenOfDisplay/XDefaultScreenOfDisplay_m \
	XDefaultVisual/XDefaultVisual XDefaultVisual/XDefaultVisual_m \
	XDefaultVisualOfScreen/XDefaultVisualOfScreen XDefaultVisualOfScreen/XDefaultVisualOfScreen_m \
	XDoesBackingStore/XDoesBackingStore XDoesBackingStore/XDoesBackingStore_m \
	XDisplayCells/XDisplayCells XDisplayCells/XDisplayCells_m \
	XDisplayHeight/XDisplayHeight XDisplayHeight/XDisplayHeight_m \
	XDisplayHeightMM/XDisplayHeightMM XDisplayHeightMM/XDisplayHeightMM_m \
	XDisplayOfScreen/XDisplayOfScreen XDisplayOfScreen/XDisplayOfScreen_m \
	XDisplayPlanes/XDisplayPlanes XDisplayPlanes/XDisplayPlanes_m \
	XDisplayString/XDisplayString XDisplayString/XDisplayString_m \
	XDisplayWidth/XDisplayWidth XDisplayWidth/XDisplayWidth_m \
	XDisplayWidthMM/XDisplayWidthMM XDisplayWidthMM/XDisplayWidthMM_m \
	XDoesSaveUnders/XDoesSaveUnders XDoesSaveUnders/XDoesSaveUnders_m \
	XEventMaskOfScreen/XEventMaskOfScreen XEventMaskOfScreen/XEventMaskOfScreen_m \
	XFree/XFree \
	XHeightMMOfScreen/XHeightMMOfScreen XHeightMMOfScreen/XHeightMMOfScreen_m \
	XHeightOfScreen/XHeightOfScreen XHeightOfScreen/XHeightOfScreen_m \
	XImageByteOrder/XImageByteOrder XImageByteOrder/XImageByteOrder_m \
	XListDepths/XListDepths \
	XLastKnownRequestProcessed/XLastKnownRequestProcessed XLastKnownRequestProcessed/XLastKnownRequestProcessed_m \
	XListPixmapFormats/XListPixmapFormats \
	XMinCmapsOfScreen/XMinCmapsOfScreen XMinCmapsOfScreen/XMinCmapsOfScreen_m \
	XMaxCmapsOfScreen/XMaxCmapsOfScreen XMaxCmapsOfScreen/XMaxCmapsOfScreen_m \
	XNoOp/XNoOp \
	XNextRequest/XNextRequest XNextRequest/XNextRequest_m \
	XOpenDisplay/XOpenDisplay \
	XPlanesOfScreen/XPlanesOfScreen XPlanesOfScreen/XPlanesOfScreen_m \
	XProtocolRevision/XProtocolRevision XProtocolRevision/XProtocolRevision_m \
	XProtocolVersion/XProtocolVersion XProtocolVersion/XProtocolVersion_m \
	XQLength/XQLength XQLength/XQLength_m \
	XRootWindow/XRootWindow XRootWindow/XRootWindow_m \
	XRootWindowOfScreen/XRootWindowOfScreen XRootWindowOfScreen/XRootWindowOfScreen_m \
	XScreenCount/XScreenCount XScreenCount/XScreenCount_m \
	XScreenNumberOfScreen/XScreenNumberOfScreen \
	XScreenOfDisplay/XScreenOfDisplay XScreenOfDisplay/XScreenOfDisplay_m \
	XServerVendor/XServerVendor XServerVendor/XServerVendor_m \
	XSetCloseDownMode/XSetCloseDownMode \
	XVendorRelease/XVendorRelease XVendorRelease/XVendorRelease_m \
	XWidthMMOfScreen/XWidthMMOfScreen XWidthMMOfScreen/XWidthMMOfScreen_m \
	XWidthOfScreen/XWidthOfScreen XWidthOfScreen/XWidthOfScreen_m \
	XWhitePixel/XWhitePixel XWhitePixel/XWhitePixel_m \
	XWhitePixelOfScreen/XWhitePixelOfScreen XWhitePixelOfScreen/XWhitePixelOfScreen_m

# Auxiliary programs run from tests
libexec_PROGRAMS += \
	XDisplayString/Test1 \
	XOpenDisplay/Test1
XDisplayString_Test1_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)
XOpenDisplay_Test1_LDADD = $(TCMCHILD) $(XTS_LLIBS) $(XTS_LIBS)