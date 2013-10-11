# Mayhaps [![Gem Version](https://badge.fury.io/rb/mayhaps.png)](http://badge.fury.io/rb/mayhaps)

Mayhaps (maybe) call Ruby methods.

## Usage

Mayhaps allows you to call methods on objects that may or may not be
nil.

First, install the gem or add it to your `Gemfile`:

```ruby
gem "mayhaps", "~> 0.1.0"
```

Next, require it:

```ruby
require 'mayhaps'
```

### On the surface

Mayhaps adds a `maybe` method to all objects that allows you to call
methods on the object regardless of whether or not it is nil. It does
this by wrapping the object in a `Maybe` object, more specifically a
`Nothing` object for nil or a `Just` object for anything else. In order
to unwrap the value, use unary `+` on the `Maybe` object.

#### Examples

```ruby
hash = {:foo => " foo "}

hash[:foo].maybe.upcase #=> #<Just " FOO ">
hash[:bar].maybe.upcase #=> #<Nothing>

+hash[:foo].maybe.upcase #=> " FOO "
+hash[:bar].maybe.upcase #=> nil

+hash[:foo].maybe.upcase.strip #=> "FOO"
+hash[:bar].maybe.upcase.strip #=> nil
```

```ruby
# Without Mayhaps
if customer && customer.order && customer.order.id == some_id
  # Do something with customer
end

# With Mayhaps
require 'mayhaps'

if +customer.maybe.order.id == some_id
  # Do something with customer
end
```

### The nitty gritty

`Just` and `Nothing` both inherit from `BasicObject` rather than
`Object` in order to allow the maximum number of methods to fall through
to the wrapped object. This includes methods like `class` and `is_a?`,
therefore the `===` method of the `Maybe` classes should be used to
check if an object is wrapped in a `Maybe`.

```ruby
Maybe === :a.maybe #=> true
Just === :a.maybe #=> true
Maybe === nil.maybe #=> true
Nothing === nil.maybe #=> true
```

The methods that will be called on the `Maybe` object itself and not the
wrapped object are as follows:

* `+@`
* `method_missing`
* `inspect`
* `maybe`
* `_dump`
* `==`
* `equal?`
* `!`
* `!=`
* `instance_eval`
* `instance_exec`
* `__send__`
* `__id__`

`_dump` is a method added by the `Singleton` module, which `Nothing`
includes.

The `maybe` method defined on `Maybe` objects simply returns `self`.

The `maybe` method should be used to wrap objects in `Maybe` objects,
but they can also be created directly. Since `Nothing` is a `Singleton`,
its instance can be accessed using `Nothing.instance`. A `Just` object
can be created by calling `Just.new`. If the object passed to `Just.new`
is `nil`, an ArgumentError will be raised.

## License

Copyright © 2013, Curtis McEnroe <programble@gmail.com>

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
