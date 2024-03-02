class Base {
	string name() {
		return "John";
	}
	
	string streetName() {
		return name() ~ "'s Str.";
	}
}

class German : Base {
	override string name() {
		return "Manfred";
	}
}

unittest {
	Base b = new German();
	assert(b.streetName() == 
			"Manfred's Str.");
}
