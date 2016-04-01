---
title: 'python# 3 python 流程控制语句'
date: 2016-03-14 11:25:38
categories: python
toc: true
tags:
---

##### 1,if else 语句
```
		语法如下:
				if expression:
				    if_suite
				`如果表达式的值非0或者布尔值为true,则执行 if_suite`
				if expression:
					if_suite
				else:
					else_suite
				if expression1:
					if_suite
				elif expression2:
					elif_suite
				else:
					else_suite
```
```
			#!/usr/sbin/python
			valus1=int(input("enter the value:"))
			if valus1 <4:
				print("the value is less than 4")
			elif valus1<7:
				print("the value is less than 7")
			elif valus1<9:
				print("the value is less than 9")

```

##### 2,while 语句
```
语法:
while expression:
	while_suite
			
			>>> a=6
			>>> while a<10:
			...     print("a is %d haha") %a
			...     a+=1
			...
			a is 6 haha
			a is 7 haha
			a is 8 haha
			a is 9 haha
```
##### 3,for语句
```
			>>> for i in ["jack","tom","jone","lucy"]:
			...     print(i)
			...
			jack
			tom
			jone
			lucy
			>>> for i in ["jack","tom","jone","lucy"]:
			...     print(i),		#加逗号的作用是不换行,默认是换行的
			...
			jack tom jone lucy
```
##### 4,range函数的用法
```
			>>> for i in range(9):
			...     print(i)
			...
			0
			1
			2
			3
			4
			5
			6
			7
			8

			>>> a='jfawlejfqwl'
			>>> for i in range(len(a)):
			...     print(a[i])
			...
			j
			f
			a
			w
			l
			e
			j
			f
			q
			w
			l
```
