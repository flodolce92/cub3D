# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: flo-dolc <flo-dolc@student.42roma.it>      +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/12/31 00:25:42 by flo-dolc          #+#    #+#              #
#    Updated: 2024/12/31 00:41:02 by flo-dolc         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Colors
GREEN		=	\033[0;32m
YELLOW		=	\033[0;33m
RED			=	\033[0;31m
BLUE		=	\033[0;34m
RESET		=	\033[0m

# Directories
SRCS_DIR	=	src/
OBJS_DIR	=	obj/

# Source Files
SRC			=

SRCS		=	$(addprefix $(SRCS_DIR), $(SRC))
OBJS		=	$(addprefix $(OBJS_DIR), $(SRC:.c=.o))

# Output File
NAME		=	cub3D

# Compiler and Flags
CC			=	gcc
CFLAGS		=	-Wall -Wextra -Werror -g
INCLUDES	=	-I/usr/include -Imlx_linux -O3 -Ilibft
MLX_FLAGS	=	-Lmlx_linux -lmlx -L/usr/lib -lXext -lX11 -lm -lz
LIBFT_FLAGS	=	-Llibft -lft

# Utilities
RM			=	rm -f

# Rules
all:			$(NAME)

$(OBJS_DIR):
				@echo "$(YELLOW)Creating object directory...$(RESET)"
				@mkdir -p $(OBJS_DIR)

$(OBJS_DIR)%.o:	$(SRCS_DIR)%.c | $(OBJS_DIR)
				@echo "$(BLUE)Compiling $<...$(RESET)"
				@$(CC) $(CFLAGS) -c $< -o $@ $(INCLUDES)

$(NAME):		$(OBJS_DIR) $(OBJS)
				@echo "$(BLUE)Building libraries...$(RESET)"
				@$(MAKE) -C ./mlx_linux --no-print-directory
				@$(MAKE) -C ./libft --no-print-directory
				@echo "$(GREEN)Linking objects and creating $(NAME)...$(RESET)"
				@$(CC) $(CFLAGS) -o $(NAME) $(OBJS) $(MLX_FLAGS) $(LIBFT_FLAGS)

clean:
				@echo "$(RED)Cleaning object files...$(RESET)"
				@$(RM) $(OBJS)
				@$(RM) -r $(OBJS_DIR)
				@$(MAKE) -C ./mlx_linux clean --no-print-directory
				@$(MAKE) -C ./libft clean --no-print-directory

fclean:			clean
				@echo "$(RED)Removing executable...$(RESET)"
				@$(RM) $(NAME)
				@$(MAKE) -C ./libft fclean --no-print-directory

re:				fclean all

norm:
				@echo "$(BLUE)Running norminette...$(RESET)"
				@norminette $(SRCS) $(SRCS_DIR)cub3D.h

test:			all
				@echo "$(BLUE)Running test...$(RESET)"
				@./$(NAME) ./maps/good/subject_map.cub

.PHONY:			all clean fclean re norm test
