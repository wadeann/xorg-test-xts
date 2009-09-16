include ../common.mk
AUTOMAKE_OPTIONS = subdir-objects

AM_CFLAGS = $(XTS_LCFLAGS) $(XTS_CFLAGS)
LDADD = $(TCM) $(XTS_LLIBS) $(XTS_LIBS)

libexec_PROGRAMS = $(tprogs)
BUILT_SOURCES = $(tprogs:$(EXEEXT)=.c)
CLEANFILES = $(BUILT_SOURCES)

tprogs = \
	AllowDeviceEvents/AllowDeviceEvents \
	ChangeDeviceControl/ChangeDeviceControl \
	ChangeFeedbackControl/ChangeFeedbackControl \
	ChangeKeyboardDevice/ChangeKeyboardDevice \
	XChangeDeviceDontPropagateList/XChangeDeviceDontPropagateList \
	ChangePointerDevice/ChangePointerDevice \
	ChangeDeviceKeyMapping/ChangeDeviceKeyMapping \
	CloseDevice/CloseDevice \
	DeviceBell/DeviceBell \
	XGetDeviceControl/XGetDeviceControl \
	GetFeedbackControl/GetFeedbackControl \
	XGetDeviceFocus/XGetDeviceFocus \
	XGetDeviceDontPropagateList/XGetDeviceDontPropagateList \
	GetExtensionVersion/GetExtensionVersion \
	GrabDevice/GrabDevice \
	GrabDeviceButton/GrabDeviceButton \
	GrabDeviceKey/GrabDeviceKey \
	GetDeviceButtonMapping/GetDeviceButtonMapping \
	XGetDeviceKeyMapping/XGetDeviceKeyMapping \
	XGetDeviceModifierMapping/XGetDeviceModifierMapping \
	GetDeviceMotionEvents/GetDeviceMotionEvents \
	XGetSelectedExtensionEvents/XGetSelectedExtensionEvents \
	ListInputDevices/ListInputDevices \
	Miscellaneous/Miscellaneous \
	OpenDevice/OpenDevice \
	XQueryDeviceState/XQueryDeviceState \
	SetDeviceValuators/SetDeviceValuators \
	SetDeviceButtonMapping/SetDeviceButtonMapping \
	XSetDeviceFocus/XSetDeviceFocus \
	SetDeviceModifierMapping/SetDeviceModifierMapping \
	SetDeviceMode/SetDeviceMode \
	XSelectExtensionEvent/XSelectExtensionEvent \
	SendExtensionEvent/SendExtensionEvent \
	XUngrabDevice/XUngrabDevice \
	UngrabDeviceButton/UngrabDeviceButton \
	UngrabDeviceKey/UngrabDeviceKey