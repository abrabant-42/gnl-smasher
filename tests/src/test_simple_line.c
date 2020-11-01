#include "gnl_smasher.h"

int	main(void) {
	int		fd = -1;
	char	*line =	NULL;
	int		ret;

	/* open file - if an error occurs here, the test will be ignored, that's not your fault ! */
	if ((fd = open("./tests/files/baudelaire1.txt", O_RDONLY)) == -1 || read(fd, NULL, 0) == -1) {
		return (TEST_ERROR);
	}

	ret = get_next_line(fd, &line);
	printf("%s\n", line);
	printf("return value: %d\n", ret);

	/* cleaning up */
	free(line);
	line = NULL;
	close(fd);

	return (TEST_SUCCESS);
}
