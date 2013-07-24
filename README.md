Matty's Ultimate Gem
================

[![Build Status](https://secure.travis-ci.org/phluid61/mug.png)](http://travis-ci.org/phluig61/mug)
[![Gem Version](https://badge.fury.io/rb/mug.png)](http://badge.fury.io/rb/mug)

bool
----
```ruby
require 'mug/bool'
Bool(obj) #=> !!obj
obj.to_bool #=> !!obj
obj.to_b #=> C-like truthiness
```

fragile-method-chain
--------------------
```ruby
require 'mug/fragile-method-chain'
a._?.b.c._!
nested_hash._?[:a][:b][:c]._!
```

iterator/for
------------
```ruby
require 'mug/iterator/for'
0.iter_for(:next).take(5) #=> [0,1,2,3,4]
0.iter_for(:+,2).take(5) #=> [0,2,4,6,8]
```

iterator/method
---------------
```ruby
require 'mug/iterator/method'
0.method(:next).to_iter.take(5) #=> [0,1,2,3,4]
0.method(:+).to_iter(2).take(5) #=> [0,2,4,6,8]
```

maybe
-----
```ruby
require 'mug/maybe'
a.maybe{ b.maybe{ c } }
a.maybe.b.maybe.c
```

self
----
```ruby
require 'mug/self'
1.self #=> 1
obj.self #=> obj
2.self{|i| i*3 } #=> 6
[1,1,2,2,3].group_by(&:self) #=> {1=>[1,1], 2=>[2,2], 3=>[3]}
```
