gcc -D MATHC_USE_UNIONS -E -nostdinc ./mathc/mathc.h 2>/dev/null | sed s/#.*// | tr -s n > mathc_stripped.h
