#ifndef GNL_SMASHER_H
# define GNL_SMASHER_H
# include <stdio.h>
# include <fcntl.h>
# include <unistd.h>
# include <stdlib.h>
# define TEST_ERROR 1
# define TEST_SUCCESS 0

int	get_next_line(int fd, char **line);

#endif
