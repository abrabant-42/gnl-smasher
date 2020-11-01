#include "gnl_smasher.h"

/*
** return value is not tested in this case, as it is not clearly defined by
** the subject.
*/

int	main(void) {
	int		fd = -1;
	char	*line =	NULL;
	int		ret;

	/* open file - if an error occurs here, the test will be ignored, that's not your fault ! */
	if ((fd = open("./tests/files/no_newline.txt", O_RDONLY)) == -1 || read(fd, NULL, 0) == -1) {
		return (TEST_ERROR);
	}

	for (size_t i = 0; i < 4 && (ret = get_next_line(fd, &line)) != -1; ++i) {
		if (i == 3) {
			printf("%s", line);
		} else {
			printf("%s\n", line);
		}
		free(line);
		line = NULL;
	}

	/* cleaning up */
	close(fd);

	return (TEST_SUCCESS);
}
