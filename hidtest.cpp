/*******************************************************
 Windows HID simplification

 Alan Ott
 Signal 11 Software

 8/22/2009

 Copyright 2009

 This contents of this file may be used by anyone
 for any reason without any conditions and may be
 used as a starting point for your own applications
 which use HIDAPI.


 Modified 06/07/2015 by Jeff Moore
 The sample code has been modified to cause it to run
 in a loop and print to stdout the character values
 from the 4th byte of the report frame which seems to
 be the only relevant byte for the 8-bitty controller
 :-0
 Works in concert with shell script to control
 robotics stuff via bluetooth.
********************************************************/

#include <stdio.h>
#include <wchar.h>
#include <string.h>
#include <stdlib.h>
#include "hidapi.h"

// Headers needed for sleeping.
#ifdef _WIN32
	#include <windows.h>
#else
	#include <unistd.h>
#endif
// Options, can be overridden from cmdline
bool verbose=false;
char path[255] = "/dev/hidraw0";
bool enumerate=false;
bool numeric=false;

void showHelp()
{
	printf("Command line tool for displaying bluetooth data.\n");
	printf("btcmd [-ev] [path]\n");
        printf("Options: \n");
	printf("-v, --verbose    :   Full-frame data display\n");
	printf("-e, --enumerate  :   Search for and enumerate all BT devices\n");
	printf("-n, --numeric    :   Output character ascii values (non-char)\n");
	printf("[path] defaults to /dev/hidraw0.  \n");
	exit(1);
}

void parseArgs(int argc, char *argv[])
{
	for (int i = 0; i < argc; i++)
	{
		char *arg = argv[i];
        if (strcmp(arg, "-v")==0){
            verbose=true; continue;
        }
        if (strcmp(arg, "-e")==0 ||
            strcmp(arg,"--enumerate")==0) {
            enumerate=true;
            continue;
		}
		if (strcmp(arg, "--help")==0 ||
            strcmp(arg, "-h")==0 ) {
            showHelp();
		}
		if (strcmp(arg, "--numeric")==0 || strcmp(arg, "-n")==0)
		{
		    numeric=true;
		}
		if (i == (argc-1)) sprintf(path,"%s",arg);
	}
}

int main(int argc, char* argv[])
{
	int res;
	unsigned char buf[256];
	#define MAX_STR 255
	//wchar_t wstr[MAX_STR];
	hid_device *handle;
	int i;

#ifdef WIN32
	UNREFERENCED_PARAMETER(argc);
	UNREFERENCED_PARAMETER(argv);
#endif

	struct hid_device_info *devs, *cur_dev;
        struct hid_device_info *last_dev;

	parseArgs(argc, argv);

	if (hid_init())
		return -1;

	if (enumerate)
	{
		devs = hid_enumerate(0x0, 0x0);
		cur_dev = devs;

		if ( cur_dev == NULL) printf("cur_dev=NULL\n");
		else printf("Enumerating devices...\n");

		while (cur_dev) {
			printf("Device Found\n  type: %04hx %04hx\n",
				cur_dev->vendor_id, cur_dev->product_id);
			printf("  path: %s\n  serial_number: %ls",
				cur_dev->path, cur_dev->serial_number);
			printf("\n");
			printf("  Manufacturer: %ls\n", cur_dev->manufacturer_string);
			printf("  Product:      %ls\n", cur_dev->product_string);
			printf("  Release:      %hx\n", cur_dev->release_number);
			printf("  Interface:    %d\n",  cur_dev->interface_number);
			printf("\n");
	                last_dev = cur_dev;
			cur_dev = cur_dev->next;
		}
	}
	//hid_free_enumeration(devs);

	// Set up the command buffer.
	memset(buf,0x00,sizeof(buf));
	buf[0] = 0x01;
	buf[1] = 0x81;

	//printf("last_dev=%d\n", (int)last_dev);
	if (0) {
	handle = hid_open(last_dev->vendor_id, last_dev->product_id, NULL);
        printf("Opening VID=%04hx, PID=%04hx \n",
		last_dev->vendor_id,
		last_dev->product_id);
	if (!handle) {
		printf("unable to open device\n");
 		return 1;
	}
	}

	handle = hid_open_path(path);
	if (!handle) {
		printf("unable to open device\n");
 		return 1;
	}

	// Set the hid_read() function to be non-blocking.
	hid_set_nonblocking(handle, 1);

	// Try to read from the device. There shoud be no
	// data here, but execution should not block.
	res = hid_read(handle, buf, 17);

	// Send a Feature Report to the device
	memset(buf,0,sizeof(buf));

	// Read requested state. hid_read() has been set to be
	// non-blocking by the call to hid_set_nonblocking() above.
	// This loop demonstrates the non-blocking nature of hid_read().
	res = 0;
	while (1) {
		res = hid_read(handle, buf, sizeof(buf));
		if (res < 0)
			printf("Unable to read()\n");
		#ifdef WIN32
		Sleep(500);
		#else
		usleep(20*1000);
		#endif

        if ( res > 0) {
			if ( verbose ) {
				printf("Length=%d\n", res);
				for (i = 0; i < res; i++) {
					printf("%02hhx|", buf[i]);
				}
				printf("\n");
				for (i = 0; i < res; i++) {
					printf("%c |", buf[i]);
				}
				printf("\n");
			} else {
				if ( res >= 4 )
				{
				    if (numeric) printf("%d\n", buf[3]);
				    else printf("%c\n", buf[3]);
				}
			}
		}
	}

	//printf("Data read:\n   ");
	/// Print out the returned buffer.
	//for (i = 0; i < res; i++)
	//	printf("%02hhx ", buf[i]);
	//printf("\n");

	hid_close(handle);

	/* Free static HIDAPI objects. */
	hid_exit();

#ifdef WIN32
	system("pause");
#endif

	return 0;
}
