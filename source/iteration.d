module iteration;

import std.stdio;
import std.format;

struct Vec(T) {
@safe:
	T[] arr;

	void append(T t) {
		this.arr ~= t;
	}

	size_t length() @property {
		return this.arr.length;
	}

	ref T opIndex(size_t idx) return scope {
		return this.arr[idx];
	}

	ref T opIndexFast(size_t idx) @trusted {
		return *(arr.ptr + idx);
	}

	ViaPtr!(T) slicePtr(size_t begin, size_t end) @trusted {
		return ViaPtr!(T)(this.arr.ptr + begin, this.arr.ptr + end);
	}

	ViaIdx!(T) sliceIdx(size_t begin, size_t end) @trusted {
		return ViaIdx!(T)(&this, begin, end);
	}
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
	Vec!(int) v;
	foreach(i; 0 .. 10) {
		v.append(i);
	}

	int i;
	foreach(it; v.slicePtr(0, 10)) {
		int f = it;
		assert(f == i, format("%s %s", f, i));
		++i;
	}
	assert(i == 10);
}

struct ViaIdx(T) {
	Vec!(T)* vec;
	size_t idx;
	size_t end;

	ref T front() @property {
		return this.vec.opIndexFast(idx);
	}

	void popFront() {
		this.idx++;
	}

	bool empty() @property {
		return this.idx >= this.end;
	}
}

unittest {
	Vec!(int) v;
	foreach(i; 0 .. 10) {
		v.append(i);
	}

	int i;
	foreach(it; v.sliceIdx(0, 10)) {
		int f = it;
		assert(f == i, format("%s %s", f, i));
		++i;
	}
	assert(i == 10);
}

unittest {
	Vec!(int) v;
	foreach(i; 0 .. 10) {
		v.append(i);
	}

	foreach(idx; 0 .. v.length) {
		assert(v[idx] == v.opIndexFast(idx));
	}
}
