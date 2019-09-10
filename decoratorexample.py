def explainfunction(func):
    def willbereturn():
        print("获取函数对象的字典%s"%dir(func))
        # 完全可以不使用装饰的func
        # func()
    return willbereturn




def explainfunction1(func):
    # 传入参数
    def willbereturn(name):
        print("获取函数对象的字典%s"%dir(func))
        # func()
        print(name)
    return willbereturn




def explainfunction2(func):
    # 传入参数
    def willbereturn(name,*args):
        print("获取函数对象的字典%s"%dir(func))
        func(*args)
        print("返回测试name %s"%name)
    return willbereturn



@explainfunction2
def test1(*args):
    print(args)



@explainfunction1
def test():
    print("i am here")


# 这里的参数其实是被传往最后返回的函数里面的，这样理解就非常正常了
test("yangming")
test1("yangming is here",2,3,4,5)