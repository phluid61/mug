Matty's Ultimate Gem
================
                                                                                                                                                                       
[![Build Status](https://secure.travis-ci.org/phluid61/mug.png)](http://travis-ci.org/phluid61/mug)
[![Gem Version](https://badge.fury.io/rb/mug.png)](http://badge.fury.io/rb/mug)

and-or
------

### Object

#### `obj.and default`
#### `obj.and default {|o| block }`

Returns either _obj_ or _default_, depending on the falsiness of _obj_.

If a block is given, _obj_ is yielded to it; if it returns truthy, _default_ is returned, otherwise _obj_ is returned.

#### `obj.or default`
#### `obj.or default {|o| block }`

Returns either _obj_ or _default_, depending on the truthiness of _obj_.

If a block is given, _obj_ is yielded to it; if it returns truthy, _obj_ is returned, otherwise _default_ is returned.

### Examples

```ruby
require 'mug/and-or'

data_store.get_env_hash.or(default_hash).do_something

get_a_list.and(default_list, &:empty?).do_something
```

bool
----

### Kernel

#### `Bool(obj)`

Returns the truthiness of _obj_, as either _True_ or _False_.

This is functionally equivalent to calling `!!obj`

### Object

#### `obj.to_b`

Converts _obj_ to a boolean using "typical" C-like conversion rules.

The following values all become false:

* `0`, `0.0`, etc. (any numeric zero)
* `Float::NAN`
* `""`
* `[]`, `{}`, etc. (any Enumerable or Enumerator with no elements)
* any Exception

All others values become true.

#### `obj.to_bool`

Returns the truthiness of _obj_, as either _True_ or _False_.

This is functionally equivalent to calling `!!obj`

### Examples

```ruby
require 'mug/bool'

Bool(obj) #=> !!obj
obj.to_bool #=> !!obj
obj.to_b #=> C-like truthiness
```

fragile-method-chain
--------------------

Defines a fragile method chain.  If any method call in the chain returns a falsy value, the chain aborts.

```ruby
require 'mug/fragile-method-chain'

# Similar to: a.b && a.b.c
# except that a.b is not called twice
a._?.b.c._!

# Also works with #[] method
nested_hash._?[:a][:b][:c]._!
```

hashmap
-------

### Hash

#### `hsh.map_values {|v| block }`

Returns a new hash which is a copy of +hsh+ but each value is replaced by the result of running it through +block+.

```ruby
require 'mug/hashmap'

{'a'=>1, 'b'=>2}.map_values { |v| v*2 } #=> {'a'=>2, 'b'=>4}
{'a'=>1, 'b'=>2}.map_values { "cat" }   #=> {'a'=>"cat", 'b'=>"cat"}
```

#### `hsh.map_keys {|k| block }`

Returns a new hash which is a copy of +hsh+ but each key is replaced by the result of running it through +block+.

If +block+ returns duplicate keys, they will be overwritten in the resulting hash.

```ruby
require 'mug/hashmap'

{'a'=>1, 'b'=>2}.map_keys { |k| k*2 } #=> {'aa'=>1, 'bb'=>2}
{'a'=>1, 'b'=>2}.map_keys { "cat" }   #=> {'cat'=>2}
```

#### `hsh.map_pairs {|k, v| block }`

Returns a new hash which is a copy of +hsh+ but each key-value pair is replaced by the result of running it through +block+.

If +block+ returns duplicate keys, they will be overwritten in the resulting hash.

```ruby
require 'mug/hashmap'

{'a'=>1, 'b'=>2}.map_pairs { |k,v| [k*2, v+1] } #=> {'aa'=>2, 'bb'=>3}
{'a'=>1, 'b'=>2}.map_pairs { ["cat","dog"] }   #=> {'cat'=>'dog'}
```

hashop
------

### Hash

#### `hsh | other_hsh`


Returns a new Hash, whose value is the same as this
one, with any extras in +other_hash+ added in.

Useful for default options.

```ruby
require 'mug/hashop'

def foo options={}
  options | {b: 2, c: 2}
end
foo a: 1, b: 1 # => {:a=>1, :b=>1, :c=>2}
```

#### `hsh + other_hsh`

Adds the contents of +other_hash+ to +hsh+.
Entries with duplicate keys are overwritten with the values from +other_hash+

```ruby
require 'mug/hashop'

a = {a: 1, b: 1}
b = {b: 2, c: 2}
a + b # => {:a=>1, :b=>2, :c=>2}
b + a # => {:a=>1, :b=>1, :c=>2}
```

#### `hsh << o`

Appends stuff to the hash.

* If +o+ is a Hash, this is identical to calling #merge!
* If +o+ is an Array with two elements, it is interpreted as [key,value]
* If +o+ can be converted to a hash with #to_h, this is identical to calling #merge!
* Otherwise an ArgumentError is raised.

```ruby
require 'mug/hashop'

h = {}
h << {:a=>0}       # h = {:a=>0}
h << {:b=>2,:c=>3} # h = {:a=>0,:b=>2,:c=>3}
h << [:a,1]        # h = {:a=>1,:b=>2,:c=>3}
```


iterator/for
------------

### Object

#### `obj.iter_for(meth, *args)`

Creates an Iterator object, which is a subclass of Enumerator that recursively invokes a method on an object.

Initially the receiving object is +obj+.  After each iteration, the receiving object is replaced with the result of the previous iteration.

```ruby
require 'mug/iterator/for'

0.iter_for(:next).take(5) #=> [0,1,2,3,4]
0.iter_for(:+,2).take(5) #=> [0,2,4,6,8]
```

iterator/method
---------------

### Method

#### `meth.to_iter(*args)`

Creates an Iterator object, which is a subclass of Enumerator that recursively invokes +meth+ on an object.

Initially the receiving object is the object on which +meth+ is defined.  After each iteration, the receiving object is replaced with the result of the previous iteration.

```ruby
require 'mug/iterator/method'

0.method(:next).to_iter.take(5) #=> [0,1,2,3,4]
0.method(:+).to_iter(2).take(5) #=> [0,2,4,6,8]
```

maybe
-----

### Object

#### `obj.maybe`
#### `obj.maybe { block }`

Invokes a method on +obj+ iff +obj+ is truthy, otherwise returns +obj+.

When a block is given, the block is invoked in the scope of +obj+ (i.e. `self` in the block refers to +obj+).

When no block is given, `maybe` returns an object to conditionally delegates methods to +obj+.

```ruby
require 'mug/maybe'

# Equivalent to: a && a.b && a.b.c
# except that a and b are only invoked once

# (block form)
a.maybe{ b.maybe{ c } }

# (delegator form)
a.maybe.b.maybe.c
```

self
----

### Object

#### `obj.self`
#### `obj.self {|o| block }`

When a block is given, yields +obj+ to the block and returns the resulting value.

When no block is given, simply returns +obj+.

> Note: this is different from `#tap` because `obj.tap{nil}` returns `obj`, but `obj.self{nil}` returns `nil`.

```ruby
require 'mug/self'

1.self #=> 1
obj.self #=> obj
2.self{|i| i*3 } #=> 6
[1,1,2,2,3].group_by(&:self) #=> {1=>[1,1], 2=>[2,2], 3=>[3]}
```

tau
---

Defines the true circle constant.

```ruby
Math::TAU #= 6.283185307179586..
```

Additionally it expands the BigDecimal/BigMath module:

```ruby
require 'bigdecimal'
require 'bigdecimal/math'
include BigMath

puts TAU(15)
```

See http://tauday.com to find out what it's all about.

to_h
----

> Note: for Ruby <2.0, it is advisable to also include the [*to_h* gem](https://rubygems.org/gems/to_h).

### Enumerable

#### `enum.to_h`

Converts _enum_ to a hash.

Each element of _enum_ must be a single item, or an array of two items.  Duplicate keys are overwritten in order.

```ruby
[].to_h             #=> {}
[1,2].to_h          #=> {1=>nil, 2=>nil}
(1..2).to_h         #=> {1=>nil, 2=>nil}
[[1,2],[3,4]].to_h  #=> {1=>2, 3=>4}
[[1,2],[1,4]].to_h  #=> {1=>4}
```

