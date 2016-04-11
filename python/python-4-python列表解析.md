title: 'python# 4-python 列表解析'
date: 2016-03-14 11:25:38
categories: python
toc: true
tags:
---

##### 1,python 列表解析:
```
		>>> a=[x for x in range(9)]
		>>> print(a)
		[0, 1, 2, 3, 4, 5, 6, 7, 8]
		>>> a=[x*2 for x in range(9)]
		>>> print(a)
		[0, 2, 4, 6, 8, 10, 12, 14, 16]
		>>> a=[x for x in range(9) if x%2==0]
		>>> print(a)
		[0, 2, 4, 6, 8]
		>>> a=[x+2 for x in range(9) if x%2==0]
		>>> print(a)
		[2, 4, 6, 8, 10]
		>>> a=[(x,y) for x in range(8) if x%2==0  for y in range(8) if y%3==1]
		>>> print(a)
		[(0, 1), (0, 4), (0, 7), (2, 1), (2, 4), (2, 7), (4, 1), (4, 4), (4, 7), (6, 1), (6, 4), (6, 7)]
```
##### 2,python内建函数open
```
		E:\temp>cat a.log
		"test"

		E:\temp>cat b.log
		"hello"
		>>> a=open('a.log',mode='r')
		>>> for i in a.readlines():
		...     print(i)
		...
		"test"

		>>> a=open(r'e:\temp\b.log',mode='r')
		>>> for i in a.readlines():
		...     print(i)
		...
		"hello"
```