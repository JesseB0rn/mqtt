#include <stdio.h>
#import <string.h>
#import <dlfcn.h>
#include <objc/runtime.h>
#import "MQTTClient.h"


MQTTQosLevel qosFromInt (NSInteger qos){ 
      //MQTTQosLevelAtMostOnce = 0,
    //MQTTQosLevelAtLeastOnce = 1,
    //MQTTQosLevelExactlyOnce = 2
     if (qos == 0) return MQTTQosLevelAtMostOnce;
     else if (qos == 1) return MQTTQosLevelAtLeastOnce;
     else return MQTTQosLevelExactlyOnce;
     
}

int main(int argc, char *argv[], char *envp[]) {

//NSLog();
       
         
       if ( argc < 6) {
       printf("not enough args: %d\n", argc);
       return 0;
       }

setuid(0); //make us root
setgid(0);
    if (getuid() != 0) {
        printf("root accsess denied\n");
    }
else if(getuid() == 0){

printf("running as root\n");
}
else {}
NSString * host  = [NSString stringWithUTF8String:argv[1]];
NSInteger port = 1883;
port = strtol(argv[2], NULL, 10);
NSString *topic = [NSString stringWithUTF8String:argv[3]];
NSString *msg = [NSString stringWithUTF8String:argv[4]];
NSInteger qos = 0;
qos = strtol(argv[5], NULL, 10);


        MQTTSessionManager * manager;
	manager = [[MQTTSessionManager alloc] init];
		
		
		[manager connectTo: host
                           port:port
                            tls:false
                      keepalive:60
                          clean:true
                           auth:false
                           user:nil
                           pass:nil
                              will:[@"offline" dataUsingEncoding:NSUTF8StringEncoding]
                     willTopic:@"jessefrom/ios"
		       willMsg:[@"sorrynotsorry" dataUsingEncoding:NSUTF8StringEncoding]
                        willQos:MQTTQosLevelExactlyOnce
             willRetainFlag:FALSE
                 withClientId:nil
             securityPolicy: nil
                  certificates: nil
              protocolLevel: 4
				 connectHandler:^(NSError *error) {
            //printf("\033[0;31m");
            //printf("error\n");
           //printf(error.localizedDescription);
            //printf("\033[0m;");

}
];
         while (manager.state == MQTTSessionManagerStateConnecting) {

	[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.2]];
        printf("connecting.....\n");

         }

        //NSString * data = @"test";//[NSString stringWithUTF8String:argv[2]];
	[manager sendData:[msg dataUsingEncoding:NSUTF8StringEncoding]
                     topic: topic//[NSString stringWithUTF8String:argv[1]]
                       qos:qosFromInt(qos)
                    retain:FALSE];
	
	[[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:5.0]];

	[manager disconnectWithDisconnectHandler: nil];
        
	return 0;
}
