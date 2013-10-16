package test;

import java.lang.reflect.InvocationHandler;
import java.lang.reflect.Method;
import java.lang.reflect.Proxy;

public class DynamicProxy implements InvocationHandler {
	private Object delegate;
	public DynamicProxy() {
		// TODO Auto-generated constructor stub
	}
	/**
	 * 绑定代理对象
	 * @param delegate
	 * @return 返回代理对象的接口对象实例
	 */
	public Object bind(Object delegate) {
		this.delegate = delegate;
		// 返回一个指定接口的代理类实例，该接口可以将方法调用指派到指定的调用处理程序
		return Proxy.newProxyInstance(
				this.delegate.getClass().getClassLoader(), 
				this.delegate.getClass().getInterfaces(), this);
	}

	/**
	 * 代理对象的接口对象调用方法时，代理会自动执行此方法
	 */
	@Override
	public Object invoke(Object proxy, Method method, Object[] args)
			throws Throwable {
		// TODO Auto-generated method stub
		System.out.println("代理执行开始");
		Object result = method.invoke(this.delegate, args);
		System.out.println("代理执行结束");
		return result;
	}

}
