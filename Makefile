JLINK_OUTPUT?=demojre
MODULE_DIR=out

MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := "$(subst Makefile,,$(MKFILE_PATH))"

javac:
	javac --module-source-path src -m demoModule -d $(MODULE_DIR)

jlink-strip:
	JLINK_OPTS="--strip-debug" \
	JLINK_OUTPUT=demojre--strip-debug \
	$(MAKE) jlink

jlink-compress:
	JLINK_OPTS="--compress 2" \
	JLINK_OUTPUT=demojre--compress \
	$(MAKE) jlink

jlink-no-man-pages:
	JLINK_OPTS="--no-man-pages" \
	JLINK_OUTPUT=demojre--no-man-pages \
	$(MAKE) jlink

jlink-no-header-files:
	JLINK_OPTS="--no-header-files" \
	JLINK_OUTPUT=demojre--no-header-files \
	$(MAKE) jlink

jlink-min:
	JLINK_OPTS="--strip-debug \
	--compress 2 \
	--no-man-pages \
	--no-header-files" \
	JLINK_OUTPUT=demojre-min \
	$(MAKE) jlink

jlink-all:	javac
	$(MAKE) jlink-strip
	$(MAKE) jlink-compress
	$(MAKE) jlink-no-man-pages
	$(MAKE) jlink-no-header-files
	$(MAKE) jlink-min

jlink:
	jlink $(JLINK_OPTS) \
	--module-path $(MODULE_DIR) \
	--add-modules demoModule,java.base \
	--launcher demo-app=demoModule/packTest.Practice \
	--output $(JLINK_OUTPUT)

du:
	du -hs demojre-* | sort -h

demojre-run:
	./demojre/bin/java -version
	./demojre/bin/java -m demoModule/packTest.Practice

jdeps:
	jdeps --module-path $(MODULE_DIR) -s --module demoModule

clean:
	rm -rf $(MODULE_DIR) demojre*

docker-run:
	docker run --rm -ti \
	-v $(MKFILE_DIR):/tmp \
	hldtux/oracle-jdk-11 bash