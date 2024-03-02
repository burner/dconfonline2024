import std;
import std.algorithm.comparison : min, max;
import helper;

/**
*
* Allocators
*
*/

struct Vector1(T,A) {
	A* allocator;
}

unittest {
	Vector1!(int, Allocator) vec;

	{
		Allocator tuMalloc;
		vec = Vector1!(int, Allocator)(&tuMalloc);
	}
}

struct Vector2(T,A) {
	A* allocator;

	@disable this(this);
	@disable ref typeof(this) opAssign()(auto ref typeof(this) rhs);
}

unittest {
	Vector2!(int, Allocator) vec;

	{
		Allocator tuMalloc;
		auto vec2 = Vector2!(int, Allocator)(&tuMalloc);

		// The next line doesn't compile
		//vec = Vector2!(int, Allocator)(&tuMalloc); 
	}
}


/**
*
* Destructors
*
*/

struct VectorDestor(T) {
	T[] arr;
	size_t length;

	~this() {
		static if(hasElaborateDestructor!T) {
			foreach(idx; 0 .. this.length) {
				this.arr[idx].__dtor();
			}
		}
	}
}

unittest {
	VectorDestor!(int) v;
}
