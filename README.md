<p align="center">
   <!-- align is deprecated but i'll use it here-->
   <h1 align="center">Voyage</h1>
   <p align="center">
      Zod-inspired schema validation for Godot (4.2+)
   </p>

</p>

## Original Motivation

This project/module is dedicated to improving Godot typing experience. Godot, at the time of writing, lacks many type-safety features that is convenient to confidently write code, knowing that nothing would break. Hence, the team behind this module takes heavy inspiration from a Typescript-based schema validation library, `zod`.

The library is designed to be as developer friendly as possible while keeping the size to a minimum.

## Limitation

Compared to `zod`, this library will only be a bare-bone and probably will not have any advanced typing other libraries have. However, it should be enough for game development.

## Setup

1. Copy all files in `src` to a script folder. Recommended path: `packages/voyage`
2. Rename the classes if there are any conflict
3. Usage it!

## Basic Usage

Create a simple schema

```gdscript
# v is the global namespace/class for voyage

var schema = z.string()
schema.parse("I am a string") # Returns "I am a string"
schema.parse(123) # Return null and pushes error

schema.validate("valid") # Returns true
schema.validate(123) # Returns false
```

Creating a dictionary schema

```gdscript
var config_schema= v.object({
   "theme": v.either([v.literal("dark"), v.literal("light")]),
   "username": v.string()
})

config_schema.validate({
   "theme": "dark",
   "username": "john"
}) # Returns true

config_schema.validate({
   "theme": "invalid theme",
   "username": "john"
}) # Returns false
```

## Primitives

```gdscript
# Primitive
v.string()
v.number() # Float or integer
```

## Literals

Represents the precise value a data should contain

```gdscript
var literal = z.literal("dark")
literal.validate("dark") # True
literal.validate("anything else") # False
```

## Strings

Voyage includes several helpful string utilities

```gdscript
v.string().min(5)
v.string().max(5)
v.string().range(0, 5) # String which minimum of 0 and max 5 characters
v.string().length(5)
v.string().regex(regex)
```

## Numbers

Some number specific utilities includes:

```gdscript
v.number().gt(5)
v.number().gte(5)

v.number().lt(5)
v.number().lte(5)

v.number().positive() # Only positive numbers
v.number().negative() # Only negative numbers
```

## Objects

All properties of an object is required by default and strips unknown keys.

```gdscript
var schema = v.object({
   "key1": v.string(),
}).parse({
   "key1": "hello",
   "key0": "something else"
}) # Returns { "key1": "hello" }

var schema2 = v.object({
   "key1": v.string(),
}).validate({
   "key0": "something else"
}) # false
```

### `.partial`

Partial allows the keys inside dictionary to all be optional

```gdscript
var schema = v.object({
   "key0": v.string(),
   "key1": v.string(),
}).partial().validate({
   "key0": "something else"
}) # true
```

### `.passthrough`

By default, voyage strips unknown keys. To allow them to pass, use this.

```gdscript
var schema = v.object({
   "key1": v.string(),
}).passthrough().parse({
   "key1": "hello",
   "key0": "something else"
}) # Returns { "key1": "hello", "key0": "something else" }
```

## Dictionaries

Unlike objects, this is a general typing of dictionary without the specific keys

```gdscript
var dict_schema = v.dict(z.string(), z.string())
dict_schema.validate({"hello": "true"}) # true
dict_schema.validate({"hello": 10, "hello2": "hello"}) # false
```

## Arrays

```gdscript
var string_array = z.string().max(5).array()
```

Careful with using `.optional` along with `.array`

```gdscript
var string_array = z.string().array().optional() # The array is optional
var string_array2 = z.string().optional().array().optional() # The array can contain a string or null
```

## Tuples

An array with fixed number of element and each element could have different types

```gdscript
var tuple_schema = v.tuple([v.string(), v.number()])
tuple_schema.validate(['hello', 1]) # true
```

A tuple can be variadic using the `.rest` method

```gdscript
var tuple_schema = v.tuple([v.string()]).rest(v.number())
tuple_schema.validate(['hello', 1, 2, 3, 4]) # true
```

## Either/Unions

`either` is the method for creating a union in voyage

```gdscript
var string_or_number = v.either([v.number(), v.string()])
var theme = v.either([v.literal("dark"), v.literal("light")])

string_or_number.validate(1234) # true
string_or_number.validate("1234") # true
string_or_number.validate({}) # false

theme.validate("dark") # true
theme.validate("light") # true
theme.validate("gray") # false
```

## Schema Methods

### `.parse`

Returns `null` if validation fails and the parsed data if success. Will push error.

```gdscript
var test = v.string()
test.parse("hello") # Returns "hello"
test.parse(123) # Returns null and pushes error
```

**NOTE:** if your disable `.passthrough` (default), this function will return a clone of your dictionary

### `.validate`

Returns a boolean if the object is valid or not. Does not push error

```gdscript
var test = v.string()
test.parse("hello") # Returns true
test.parse(123) # Returns false
```

### `.optional`

Lets a value to be null or 'optional'

```gdscript
var test = v.object({
   "hello": v.string().optional()
})
test.validate({
   "hello2": null
}) # true
```

### `.default`

Usually used in conjunction with `.optional`. Provide a default value to null values.

```gdscript
var test = v.object({
   "hello": v.string().optional().default("hello")
})
test.parse({
   "hello2": null
}) # Returns {"hello": "hello", "hello2": null}
```
