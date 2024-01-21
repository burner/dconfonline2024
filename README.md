# Abstract

Everybody wants good containers like c++'s std:vector in dlang.
But what is good, given the multitude of design choices, language features, 
user expectations, and their interactions.
This talk will analyze this design space, then come up with an answer to the
question what is "good", and the finally design a "good" std.vector for dlang.

# Ideas to square

* @safe
* const ness
** const container
** const values
* allocators
* nested container
* iteration
* ranges
* bound checked index
* Exception
* value type, reference types, pointer types
* destructors
* small size optimization
* multi threading
* shared
* performance
* lock-free ness
