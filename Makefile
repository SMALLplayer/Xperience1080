TEXTURES=media/textures.xbt
XBMCTEX=TexturePacker

IMAGES := $(shell find media/. -name "*jpg" | sed 's/ /\\ /')
IMAGES += $(shell find media/. -name "*png" | sed 's/ /\\ /')
IMAGES += $(shell find media/. -name "*gif" | sed 's/ /\\ /')

AR_EXCLUDE:=media Makefile .git README.md
AR_CONTENT=$(shell find . -maxdepth 1 -mindepth 1 $(patsubst %,-not -name '%',$(AR_EXCLUDE))) $(TEXTURES)

ADDON_INFO=$(shell sed -n 's/.*id="\([^"]*\)" version="\([^"]*\)".*/\1 \2/p' < addon.xml)
ADDON_NAME=$(word 1,$(ADDON_INFO))
ADDON_VER=$(word 2,$(ADDON_INFO))

.PHONY: all clean distclean

all: $(TEXTURES)
	cd .. && zip $(ADDON_NAME)/$(ADDON_NAME)-$(ADDON_VER).zip $(addprefix $(ADDON_NAME)/,$(AR_CONTENT)) -rXq

$(TEXTURES): $(IMAGES)
	$(XBMCTEX) -input media/. -output $(TEXTURES)

clean:
	rm -f $(TEXTURES)
distclean: clean
