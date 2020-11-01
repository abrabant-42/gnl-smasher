#include "gnl_smasher.h"

int	main(void) {
	int fd = -1;
	int ret = 0;
	char *line = NULL;

	if ((fd = open("./tests", O_RDONLY)) == -1) {
		return (TEST_ERROR);
	}
	ret = get_next_line(fd, &line);
	/* line should still be null, otherwise print what is inside to produce a diff error */
	if (line) {
		printf("%s\n", line);
		free(line);
	}
	printf("return value: %d\n", ret);
}
