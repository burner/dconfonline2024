module constness;

import std.stdio;
import std.format;

struct Vec(T) {
@safe:
	T[] arr;

	void append(T t) {
		this.arr ~= t;
	}

	size_t length() const @property {
		return this.arr.length;
	}

	ref inout(T) opIndex(size_t idx) inout {
		return this.arr[idx];
	}

	ViaPtr!(T) slicePtr(size_t begin, size_t end) @trusted {
		return ViaPtr!(T)(this.arr.ptr + begin, this.arr.ptr + end);
	}
}

unittest {
	Vec!(const(int)) vec;
	vec.append(10);
	assert(vec[0] == 10);
}

unittest {
	const Vec!(int) vec;
	// vec.append(10); compile-error
}

unittest {
	Vec!(const(Vec!(int))) vec;
	vec.append(const Vec!(int)([1,2,3]));

	assert(vec[0][0] == 1);
	// vec[0].append(4); compiler-error
}

unittest {
	Vec!(const(Vec!(int))) vec;
	vec.append(const Vec!(int)([1,2,3]));

	assert(vec[0][0] == 1);
	// vec[0].append(4); compiler-error

	Vec!(const(Vec!(int))) vec2;
	vec2 = vec;
}

unittest {
	Vec!(Vec!(const(int))) vec;
	vec.append(Vec!(const(int))([1,2,3]));

	assert(vec[0][0] == 1);
	vec[0].append(4);
}

unittest {
	const Vec!int vec;
	// vec.append(1); compiler-error
}

struct ViaPtr(T) {
	T* ptr;
	T* end;

	ref T front() @property {
		return *this.ptr;
	}

	void popFront() {
		this.ptr++;
	}

	bool empty() @property {
		return this.ptr >= this.end;
	}
}

unittest {
	Vec!(Vec!(const(int))) vec;
	vec.append(Vec!(const(int))([1,2,3]));

	int i = 1;
	foreach(it; vec[0].slicePtr(0, 1)) {
		assert(it == i, format("%s %s", it, i));	
		++i;
	}
}

unittest {
	Vec!(Vec!(const(int))) vec;
	vec.append(Vec!(const(int))([1,2,3]));

	auto vec2 = vec;
}
