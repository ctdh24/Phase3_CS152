# Makefile
CXX=g++
CXXFLAGS=-lfl -g
BISONFLAGS=-v -d --file-prefix=y
OBJS	= bison.o lex.o main.o

all: $(OBJS)
	$(CXX) $(OBJS) -o mini_l $(CXXFLAGS)
CC	= g++
CFLAGS	= -g -Wall -ansi -pedantic

lex.o:		lex.yy.c
		$(CXX) -c lex.yy.c -o lex.o

lex.yy.c:	mini_l.lex 
		flex mini_l.lex

bison.o:	y.tab.c
		$(CXX) -c y.tab.c -o bison.o

y.tab.c:	mini_l.y
		bison $(BISONFLAGS) mini_l.y

main.o:		main.cc
		$(CC) $(CFLAGS) -c main.cc -o main.o

clean:
	rm -f *.o *~ lex.c lex.yy.c bison.c y.tab.h y.tab.c y.output mini_l.tab.c mini_l.tab.h mini_l.output mini_l

