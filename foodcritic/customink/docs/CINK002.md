CINK002 - Prefer single-quoted strings
======================================
Purely a stylistic concern, this rule check to see if you are using double quotes instead of single quotes. There are also built-in exceptions, such as interpolation and when single quotes exist in the string.

For example, this block would trip this rule:

```ruby
package "foo"
```

But these blocks would not:

```ruby
package "#{package_name}"
```

```ruby
command "This is a 'quote' in a quote"
```

```ruby
command "Run this with a \n newline"
```

```ruby
command "\a A bell would be nice"
```
