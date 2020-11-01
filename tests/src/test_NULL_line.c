#include "gnl_smasher.h"

int	main(void) {
	int fd = -1;
	int ret = 0;

	if ((fd = open("./tests/files/baudelaire1.txt", O_RDONLY)) == -1) {
		return (TEST_ERROR);
	}
	ret = get_next_line(fd, NULL);
	/* line should still be null, otherwise print what is inside to produce a diff error */
	printf("return value: %d\n", ret);
}
