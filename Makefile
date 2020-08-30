export THEOS=/var/theos
ARCHS = arm64 arm64e


include $(THEOS)/makefiles/common.mk

TOOL_NAME = mqtt

mqtt_FILES = main.m MQTTClient/ForegroundReconnection.m MQTTClient/GCDTimer.m MQTTClient/MQTTCFSocketDecoder.m MQTTClient/MQTTCFSocketEncoder.m MQTTClient/MQTTCFSocketTransport.m MQTTClient/MQTTCoreDataPersistence.m MQTTClient/MQTTDecoder.m MQTTClient/MQTTInMemoryPersistence.m MQTTClient/MQTTLog.m MQTTClient/MQTTMessage.m MQTTClient/MQTTProperties.m MQTTClient/MQTTSSLSecurityPolicy.m MQTTClient/MQTTSSLSecurityPolicyDecoder.m MQTTClient/MQTTSSLSecurityPolicyEncoder.m MQTTClient/MQTTSSLSecurityPolicyTransport.m MQTTClient/MQTTSession.m MQTTClient/MQTTSessionLegacy.m MQTTClient/MQTTSessionManager.m MQTTClient/MQTTStrict.m MQTTClient/MQTTTransport.m MQTTClient/ReconnectTimer.m
mqtt_CFLAGS = -fobjc-arc

mqqt_CODESIGN_FLAGS = -Sent.xml

include $(THEOS_MAKE_PATH)/tool.mk

after-install::
	chown root:wheel /usr/bin/mqtt
	chmod +s /usr/bin/mqtt