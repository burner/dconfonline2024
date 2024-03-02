module magic;

void fun(const(int)[] arr) {
}

unittest {
	const(int)[] a = [1,2,3];
	fun(a);
	const(int[]) b = [1,2,3];
	fun(b);
}

unittest {
	// void[string] arr; compile-error
}
