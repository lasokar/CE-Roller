NAME = CROLLER
ICON = icon.png
DESCRIPTION = "Cyber Roller CE"
COMPRESSED = YES
ARCHIVED = YES
CFLAGS = -Wall -Wextra -Wno-unused-parameter -Oz
CXXFLAGS = -Wall -Wextra -Oz

include $(shell cedev-config --makefile)
