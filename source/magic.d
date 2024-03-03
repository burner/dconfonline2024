module magic;

import std;
import core.memory;

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

unittest {
	ulong[] byLength = readText(__FILE__)
		.splitter()
		.map!(s => s.length)
		.array
		.sort
		.uniq
		.array;

	GC.free(byLength.ptr); // compiler generated
}

unittest {
	ulong[] a = readText(__FILE__)
		.splitter()
		.map!(s => s.length)
		.array
		.sort
		.uniq
		.array;
}

unittest {
	string txt = readText(__FILE__);
	ulong[] a = txt
		.splitter()
		.map!(s => s.length)
		.array
		.sort
		.array;

	GC.free(cast(void*)txt.ptr); // compiler generated

	ulong[] byLength = a
		.uniq
		.array;

	GC.free(a.ptr);              // compiler generated
	GC.free(byLength.ptr);       // compiler generated
}
