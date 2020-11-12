#include "gnl_smasher.h"
#include <string.h>
#define TOTAL_ELEM 4

int		main(void) {
	char		*line = NULL;
	int			fd[TOTAL_ELEM] = { -1, };
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
		if ((fd[i] = open(files[i], O_RDONLY)) == -1) {
			return (TEST_ERROR);
		}
		for (size_t j = 0; j < must_read[i] && get_next_line(fd[i], &line) > 0; ++j) {
			printf("%s\n", line);
			free(line);
			line = NULL;
		}
	}
	for (size_t i = 0; i < TOTAL_ELEM; ++i) {
		ret = get_next_line(fd[i], &line);
		if (ret > 0) {
			printf("%s\n", line);
		}
		printf("return value: %d\n", ret);
		free(line);
	}
	return (TEST_SUCCESS);
}
