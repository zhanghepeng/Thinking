---
title: 'python# 2-python 变量、赋值、数字类型、字符串、列表、元组、字典'
date: 2016-03-14 11:25:38
categories: python
toc: true
tags:
---
##### 1,变量名命名规则:字母和下划线开头,大小写敏感
```
		>>> courter=0
		>>> mills=100.2
		>>> name='jack'
		>>> counter=courter + 1
		>>> sssx=counter * mills
		>>> print(sssx)
		100.2
```
##### 2,python数字类型
`python的基本数字类型: 
		int:有符号整型 0101 84 -238 0x80 -0X92
		long:长整型 419275192851L -89283411 0xWEFWIOEVNOWBEOF
		bool:布尔型 ture false
		float:浮点型  2.1415926 4.2E-10 -90. 5.2341e23 -1.6232E-19
		complx:复数类型 6.23+1.5j -1.23-893j 0+1j 9.7324-3.41412j -0.223+0j` 
`未来的long和int 两种整型无缝结合,L可有可无`
		
##### 3,python字符串
`python支持使用成对单引号和双引号,三对单/双引号组成(三对的用来包含特殊字符)`

```
		#字符的下标也是从0开始的,下标为—的为从右边算起
		>>> charss='ontest!'
		>>> charss[0]
		'o'
		>>> charss[1]
		'n'
		>>> charss[5]
		't'
		>>> charss[6]
		'!'
		>>> charss[2:5]
		'tes'
		>>> charss[:3]
		'ont'
		>>> charss[:]
		'ontest!'
		>>> charss[-1:2]
		''
		>>> charss[-1]
		'!'
		>>> charss[-1:-4]
		''
		>>> charss[-4:-1]
		'est'
```
##### 4,python 的列表和元组
`python 的列表用[]来包裹,，而python的元组是用()来包裹,值不可以改变.列表和元组都可以切割[2:5][5]`
```
		#列表
				>>> liebiao=[1,2,4,"jack",'tomcat']
				>>> liebiao
				[1, 2, 4, 'jack', 'tomcat']
				>>> liebiao[2]
				4
				>>> liebiao[4:6]
				['tomcat']
				>>> liebiao[2:5]
				[4, 'jack', 'tomcat']
				>>> liebiao[2]='nginx'
				>>> liebiao
				[1, 2, 'nginx', 'jack', 'tomcat']
		#元组
		>>> yuanzu=(7,8,9,"tomcat",'redis')
				>>> yuanzu
				(7, 8, 9, 'tomcat', 'redis')
				>>> yuanzu[1]
				8
				>>> yuanzu[2:6]
				(9, 'tomcat', 'redis')
				>>> yuanzu[1]='jack'  #元组可以切片，但是不可以更改
				Traceback (most recent call last):
				  File "<stdin>", line 1, in <module>
				TypeError: 'tuple' object does not support item assignment
```
##### 5,python 字典
`python的字典是由键值对(key-value)构成,字典元素用{}来包裹`
			
```
				>>> dicttest={"tom":24,"jack":25,"lucy":28}
				>>> dicttest
				{'lucy': 28, 'jack': 25, 'tom': 24}
				>>> dicttest.keys() #显示所有的key
				['lucy', 'jack', 'tom']
				>>> dicttest["jone"]=19  #添加元素
				>>> dicttest
				{'lucy': 28, 'jack': 25, 'jone': 19, 'tom': 24}
				>>> dicttest["tom"]
				24
				>>> for key in dicttest:	#遍历元组
				...     print key,dicttest[key]
				...
				lucy 28
				jack 25
				jone 19
				tom 24
```