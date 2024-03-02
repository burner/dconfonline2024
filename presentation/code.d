import std.random;

class C { // Boilerplate free code
	int theI;

	nothrow C fun(return ref int i) return scope @safe pure { 
		i = this.theI;
		return this; 
	}
}

@safe unittest {
	C c = new C();
	int i;
	C c2 = c.fun(i);
}

@safe:

int* gp;
void thorin(scope int*);
void gloin(int*);
int* balin(scope int* q, int* r) {
	/* error, q escapes to global gp
	gp = q; */
	gp = r; // ok
	
	// ok, q does not escape thorin()
	thorin(q); 
	thorin(r); // ok
	
	/* error, gloin() escapes q
	gloin(q); */
	gloin(r); // ok that gloin() escapes r
	
	/* error, cannot return 'scope' q
	return q; */
	return r; // ok
}

@safe unittest {
	// Will not even parse
	int a;
	int* b = balin(&a, &a); 

	// The GC will check the owns
	// for us
	int* c = new int;
	int* d = balin(c, c); 
}

void balin2(ref int q, ref int r, out result) {

}
