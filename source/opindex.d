module opindex;

import std;
import helper;

struct VecOpIndex(T) {
@safe:
	T[] arr;
	size_t len;

	void insert(T t) {
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
}

@safe unittest {
	VecOpIndex!(int) i;
	i.insert(1);
	assert(i[0] == 1);
}

@safe unittest {
	int* a;
	{
		VecOpIndex!(int) i;
		i.insert(1);
		a = &i[0];
	}
}
