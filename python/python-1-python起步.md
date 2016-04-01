---
title: 'python# 1-python 起步'
date: 2016-03-14 11:25:38
categories: python
toc: true
tags:
---

##### 1,abs 内建函数(取绝对值):
```
		>>> abs(-9)
		9
		>>> abs(9)
		9
		>>> abs(0)
		0
```
##### 2,raw_input(),int()  程序输入内建函数 
		`raw_input可以读取标准输入,并将读取到的数据赋值给指定的变量. int()内建函数给格式化为整数`
```
		>>> raw_input()
		jack is a boy
		'jack is a boy'
		>>> abc=raw_input()
		jack is baby
		>>> print(abc)
		jack is baby
		>>> num=1.9
		>>> print("tow %s is %d" %("num",num*2))
		tow num is 3
		>>> print("tow %s is %f" %("num",num*2))
		tow num is 3.800000
		>>> print("tow %s is %f" %("num",int(num*2)))
		tow num is 3.000000
		>>> print("tow %s is %d" %("num",int(num*2)))
		tow num is 3
```

##### 3,下划线(_)代表的是上一个表达式的值
	`注意:_ 是上一个 表达式 的值`
```
>>> abs(-9)
		9
		>>> _
		9
		>>> abs(8)
		8
		>>> _
		8
```
##### 4,print的用法
	`		%s :用字符串来替换,%d:用整数来替换,	%f:用浮点数来替换`

```
		>>> print("%s is number %d" %("jack",1))
		jack is number 1
		>>> print("%d 个 %s 个总共 %f" %(2,"苹果",2.2))
		2 个 苹果 个总共 2.200000
```

##### 5,help() 内建函数
		`如果不会用自己看到的函数,可以使用help()这个函数来查看用法,和shell中的man相似`
```
			>>> help(input)
			Help on built-in function input in module __builtin__:

			input(...)
				input([prompt]) -> value

				Equivalent to eval(raw_input(prompt)).

			>>> help(raw_input)
			Help on built-in function raw_input in module __builtin__:

			raw_input(...)
				raw_input([prompt]) -> string

				Read a string from standard input.  The trailing newline is stripped.
				If the user hits EOF (Unix: Ctl-D, Windows: Ctl-Z+Return), raise EOFError.
				On Unix, GNU readline is used if enabled.  The prompt string, if given,
				is printed without a trailing newline before reading.

			>>> help(abs)
			Help on built-in function abs in module __builtin__:

			abs(...)
				abs(number) -> number

				Return the absolute value of the argument.

```
##### 6,python注释
	`python 中使用#来注释,和shelL 一样`
##### 7,python 运算符
	`python 中的算术运算符:+ - * / // ** %`
		 + :加
		 - :减
		 * :乘
		 / :除 
		 % :取余
		 **:乘方
		 //:用作浮点运算的除法(对结果四舍五入)
```
		>>> print(4+5)
		9
		>>> a=3
		>>> b=6
		>>> print(a+b)
		9
		>>> print(a*b)
		18
		>>> print(a**b)
		729
		>>> print(b/a)
		2
		>>> print(a/b)
		0
		>>> print(b//a)
		2
		>>> print(a%b)
		3
		>>> print(b%a)
		0
		>>> a="#"
		>>> b=4
		>>> print(a*4)
		####
		>>> print(a+a)
		##
		>>> print(a**4) #这种用法错误
		Traceback (most recent call last):
		  File "<stdin>", line 1, in <module>
		TypeError: unsupported operand type(s) for ** or pow(): 'str' and 'int'
		>>> print(a+4)    #这种用法错误
		Traceback (most recent call last):
		  File "<stdin>", line 1, in <module>
		TypeError: cannot concatenate 'str' and 'int' objects  
```
	`python中的比较运算:< <= > >=  != <>`
```
		>>> a=4
		>>> b=3
		>>> print(a>b)
		True
		>>> print(a<b)
		False
		>>> print(a!=b)
		True
		>>> print(a<>b)
		True
```
	`python 中的逻辑运算: and or not`
	
```
		>>> 2>4 and 4>5
		False
		>>> 3>2 and 3>1
		True
		>>> 3>2 and 3<1
		False
		>>> 3>2 or 3<1
		True
```