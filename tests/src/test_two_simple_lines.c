#include "gnl_smasher.h"

int	main(void) {
	int		fd = -1;
	char	*line =	NULL;
	int		ret;

	/* open file - if an error occurs here, the test will be ignored, that's not your fault ! */
	if ((fd = open("./tests/files/baudelaire1.txt", O_RDONLY)) == -1 || read(fd, NULL, 0) == -1) {
		return (TEST_ERROR);
	}

	for (size_t i = 0; i < 2 && (ret = get_next_line(fd, &line)) > 0; ++i) {
		printf("%s\n", line);
		free(line);
		line = NULL;
	}
	printf("return value: %d\n", ret);

	/* cleaning up */
	close(fd);

	return (TEST_SUCCESS);
}
