# Mayhaps

Mayhaps call Ruby methods.

## Usage

Mayhaps allows you to call methods on objects that may or may not be
nil.

First, install the gem or add it to your `Gemfile`:

```ruby
gem "mayhaps", "~> 0.1.0"
```

Next, require it. There are two choices for using Mayhaps:

1. `require 'mayhaps'`: Provides the `mayhaps` and `mayhaps_chain`
   methods.
2. `require 'mayhaps/maybe'`: Provides the `maybe` and `maybe_chain`
   methods as aliases for the above.

For the following examples, `require 'mayhaps/maybe'` is used.

### Maybe

The `maybe` method allows you to call a method on an object that may or
may not be nil. If the object is nil, then the result of calling the
method will also be nil.

```ruby
hash = {:foo => "foo"}

hash[:foo].maybe.upcase #=> "FOO"
hash[:bar].maybe.upcase #=> nil
```

### Chaining

The `maybe_chain` method works similarly, except it allows you to chain
method calls and requires you to call `end` in order to retrieve the
result, which is either the result of the chain of method calls, or nil
if any of the methods in the chain returned nil.

```ruby
hash = {:foo => " foo "}

hash[:foo].maybe_chain.strip.upcase.end #=> "FOO"
hash[:bar].maybe_chain.strip.upcase.end #=> nil
```

### Examples

```ruby
# Without Mayhaps
if customer && customer.order && customer.order.id == some_id
  # Do something with customer
end

# With Mayhaps
require 'mayhaps/maybe'

if customer.maybe_chain.order.id.end == some_id
  # Do something with customer
end
```

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
