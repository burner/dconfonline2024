module opindex;

import std;
import helper;

struct VecOpIndex(T) {
@safe:
	T[] arr;
	size_t len;

	void append(T t) {
		if(this.len == arr.length) {
			this.arr.length = this.arr.length == 0
					? 10
					: this.arr.length * 2;
		}
		this.arr[this.len++] = t;
	}

	ref T opIndex(size_t idx) return scope {
		return this.arr[idx];
	}

	ref T opIndexFast(size_t idx) @trusted {
		return *(arr.ptr + idx);
	}
}

@safe unittest {
	VecOpIndex!(int) i;
	i.append(1);
	assert(i[0] == 1);
}

@safe unittest {
	int* a;
	{
		VecOpIndex!(int) i;
		i.append(1);
		a = &i[0];
	}
}

unittest {
	VecOpIndex!(int) i;
	i.append(1);
	i.append(2);
	int two = i.opIndexFast(1);
	assert(two == 2);
}
