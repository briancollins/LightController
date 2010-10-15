#import "LightController.h"

@implementation LightController

- (id)initWithHost:(NSString *)aHost port:(NSInteger)aPort {
	if (self = [super init]) {
		sock = socket(PF_INET,SOCK_DGRAM,0);
		sa.sin_family = AF_INET;
		sa.sin_addr.s_addr = inet_addr([aHost UTF8String]);
		sa.sin_port = htons(aPort);
	}
	
	return self;
}

- (void)setRed:(unsigned char)r green:(unsigned char)g blue:(unsigned char)b {
	struct light_packet lp = { 0 };
	lp.magic = 0x4adc0104;
	lp.ver = 0x0001;
	lp.type = 0x0101;
	lp.uni = -1;
	
	for (int i = 0; i < 170; i++) {
		lp.colors[i].red = r;
		lp.colors[i].green = g;
		lp.colors[i].blue = b;
	}
	
	lp.footer = 0xffbf;
	
	sendto(sock, &lp, sizeof(lp), 0, (struct sockaddr *)&sa, sizeof(sa));
}

- (id)initWithHost:(NSString *)aHost {
	if (self = [self initWithHost:aHost port:6038]);
	return self;
}

- (void)dealloc {
	close(sock);
	[super dealloc];
}
@end
