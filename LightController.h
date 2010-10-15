#include <arpa/inet.h>
#include <sys/ioctl.h>


struct color {
	unsigned char red;
	unsigned char green;
	unsigned char blue;
};

struct light_packet {
	unsigned int magic;
	unsigned short ver;
	unsigned short type;
	unsigned int seq;
	unsigned char port;
	unsigned short timerVal;
	unsigned int uni;
	char unknown;
	struct color colors[170];
	unsigned short footer;
};


@interface LightController : NSObject {
	int sock;
	struct sockaddr_in sa;
}

- (id)initWithHost:(NSString *)aHost port:(NSInteger)aPort;
- (id)initWithHost:(NSString *)aHost;
- (void)setRed:(unsigned char)r green:(unsigned char)g blue:(unsigned char)b;

@end
