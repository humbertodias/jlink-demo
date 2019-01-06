# jlink-demo

Creating your minified JRE

# Req

* Make
* JDK 10+
* Docker (Optional)

# Steps

1. make jlink-all

2. make du

with Docker

    make docker-run

and execute the previous steps.


| JRE                     | Size Mb |
| ------------------------|:-------:|
| demojre-min             | 32      |
| demojre-compress        | 34      |
| demojre-strip-debug     | 41      |
| demojre-no-header-files | 46      |
| demojre-no-man-pages    | 46      |
| /opt/jdk-11.0.1         | 290     |


# Ref

[JLink-demo](https://www.geeksforgeeks.org/jlink-java-linker)
