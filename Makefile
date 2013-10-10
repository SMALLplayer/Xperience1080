TEXTURES=media/textures.xbt
XBMCTEX=TexturePacker

IMAGES := $(shell find media/. -name "*jpg" | sed 's/ /\\ /')
IMAGES += $(shell find media/. -name "*png" | sed 's/ /\\ /')
IMAGES += $(shell find media/. -name "*gif" | sed 's/ /\\ /')

AR_EXCLUDE:=media Makefile .git README.md
AR_CONTENT=$(shell find . -maxdepth 1 -mindepth 1 $(patsubst %,-not -name '%',$(AR_EXCLUDE))) $(TEXTURES)

AR_NAME=$(shell sed -n 's/.*id="\([^"]*\)" version="\([^"]*\)".*/\1-\2/p' < addon.xml)

all: $(TEXTURES)
	zip $(AR_NAME).zip $(AR_CONTENT) -rXq

.PHONY: force

$(TEXTURES): $(IMAGES)
	$(XBMCTEX) -input media/. -output $(TEXTURES)

clean:
	rm -f $(TEXTURES)
distclean: clean
