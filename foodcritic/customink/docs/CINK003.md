CINK003 - Don't hardcode apache user or group
=============================================
This rule has bitten us in the butt a few times. When we first began using Chef, everything was run under `apache:www`, so there was no need to worry about file ownership. Now, the `apache2` has evolved an allows a user to specify an apache user and apache group. This rule checks that we haven't hard-coded the apache user defaults, and instead use the dynamic attribute.

For example, these blocks would trip this rule:

```ruby
directory '/foo' do
  owner 'apache'
  group 'www'
end
```

```ruby
directory '/foo' do
  owner 'http'
  group 'http'
end
```

But this blocks would not:

```ruby
directory '/foo' do
  owner node['apache']['user']
  group node['apache']['group']
end
```
