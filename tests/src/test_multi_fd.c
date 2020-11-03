#include "gnl_smasher.h"
#define TOTAL_ELEM 4

int	main(void) {
	char		*line = NULL;
	int			fd = -1;
	int			ret;
	const char	*files[] = {
		"./tests/files/baudelaire1.txt",
		"./tests/files/baudelaire2.txt",
		"./tests/files/empty.txt",
		"./tests/files/empty_lines.txt",
	};
	const size_t	must_read[] = {
		2, 7, 3, 6
	};

	for (size_t i = 0; i < TOTAL_ELEM; ++i) {
		if ((fd = open(files[i], O_RDONLY)) == -1) {
			return (TEST_ERROR);
		}
		for (size_t j = 0; j < must_read[i] && (ret = get_next_line(fd, &line)) > 0; ++j) {
			printf("%s\n", line);
			free(line);
			line = NULL;
		}
		printf("return value: %d\n", ret);
	}
	return (TEST_SUCCESS);
}
