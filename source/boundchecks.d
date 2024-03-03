module boundcheks;

import std;

struct Vec(T) {
@safe:
	T[] arr;

	void append(T t) {
		this.arr ~= t;
	}

	ref T opIndex(size_t idx) @trusted {
		if(idx >= this.arr.length) {
			throw new Exception("OOB");
		}
		return *(arr.ptr + idx);
	}

	Nullable!(T*) opIndexN(size_t idx) {
		if(idx >= this.arr.length) {
			return Nullable!(T*).init;
		}
		return nullable(&arr[idx]);
	}

	bool opIndexNN(size_t idx
			, out Nullable!(T*) o) 
	@trusted {
		if(idx >= this.arr.length) {
			o = Nullable!(T*).init;
			return false;
		}
		o = nullable(this.arr.ptr + idx);
		return true;
	}

	bool assign(size_t idx, in T value) {
		if(idx >= this.arr.length) {
			return false;
		}
		this.arr[idx] = value;
		return true;
	}
}

unittest {
	Vec!(int) vec;
	vec.append(1);

	auto v = vec.opIndexN(0);
	*v.get() = 2;
	assert(vec[0] == 2);

	Nullable!(int*) n;
	assert(vec.opIndexNN(0, n));
	*n.get() = 3;
	assert(vec[0] == 3);

	assert(vec.assign(0, 4));
}
