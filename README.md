# Json to OpenStruct

[![Gem Version](https://badge.fury.io/rb/json_to_openstruct.svg)](https://badge.fury.io/rb/json_to_openstruct)

A simple Ruby gem adding `OpenStruct::parse_json` and `OpenStruct::parse_hash` methods and reverse `OpenStruct#to_hash` and `OpenStruct#to_json` methods to (obviously) `OpenStruct`. It is able to parse and reconstruct nested json and hash objects as well.  
There is also a `OpenStruct#join` method adding possibility to replace values in the hash tree with the values passed as a hash in parameter (supporting `accepts_nested_attributes_for` format) and return it as a new hash.

## Instalation

From the command line:

    $ gem install json_to_openstruct

Or in your *Gemfile*:

    $ gem 'json_to_openstruct'

## Usage

Just open `OpenStruct` class and include `JsonToOpenStruct` (save somewhere *openstruct.rb* with the following content):

```ruby
require  'json_to_openstruct'

class OpenStruct
  include JsonToOpenStruct
end
```

If you get `uninitialized constant OpenStruct (NameError)`, require `OpenStruct` manually:

```ruby
require 'ostruct'
```

Let's consider such json:

```json
{
  "title":"title 1",
  "coll": [
    {"SubTitle":"Subtitle 1"},
    {"sub_title":"Subtitle 2"}
  ]
}
```

Then you can use it like this:

```ruby
json = File.read('data.json')
struct = OpenStruct.parse_json(json)
struct.title # => "title 1"
struct.coll.first.sub_title # => "Subtitle 1"
struct.coll.last.sub_title # => "Subtitle 2"
```

You can parse directly a ruby hash:

```ruby
struct = OpenStruct.parse_hash({ name: "Name 1", data: { sub_title: "Subtitle 3" }})
struct.name # => "Name 1"
struct.data.sub_title # => "Subtitle 3"
```

It is also possible to convert the `OpenStruct` back to hash:

```ruby
struct = OpenStruct.parse_hash({ name: "Name 1", data: { sub_title: "Subtitle 3" }})
struct.to_hash # => {:name=>"Name 1", :data=>{:sub_title=>"Subtitle 3"}}
```

..or to json:

```ruby
struct = OpenStruct.parse_hash({ name: "Name 1", data: { sub_title: "Subtitle 3" }})
struct.to_json # => {"name":"Name 1", "data":{"sub_title":"Subtitle 3"}}
```

Joining the hashes (supporting `accepts_nested_attributes_for`):

```ruby
struct = OpenStruct.parse_hash({:name=>"Name", :gift=>{:recipients=>[{:email=>"value-1"}, {:email=>"value-2"}]}, :another=>{:title=>"Switch Me"}})
struct.join({"gift"=>{"recipients_attributes"=>{"0"=>{"email"=>"value-3"}, "1"=>{"email"=>"value-4"}}}, "name"=>"New Name", "another"=> {"title"=>"Switched!"}})
# => {:name=>"New Name", :gift=>{:recipients=>[{:email=>"value-3"}, {:email=>"value-4"}]}, :another=>{:title=>"Switched!"}}
```

## Licence

This is licensed under [MIT](https://choosealicense.com/licenses/mit/) licence:

**MIT License**

Copyright (c) [2017] [[CodeRocket.co](http://coderocket.co)]

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
