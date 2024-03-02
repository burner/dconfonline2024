void fun(const ref int a, ref int b) {
	assert(a == 0);
	b = 10;
	assert(a == 10);
}

void main() {
	int i = 0;
	fun(i, i);
}
