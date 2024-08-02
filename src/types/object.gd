class_name VoyageObject
extends VoyageType

var _types: Dictionary
var should_passthrough: bool = false

func _init(shape: Dictionary):
   _types = shape

func on_validate(data):
   if not typeof(data) == TYPE_DICTIONARY:
      return VoyageError.new("'%s' is not an object" % [str(data)])
   
   var result := {}
   for key in _types:
      var type = _types[key]
      if not key in data:
         if type is VoyageOptional:
            var parsed_default = type.parse(null)
            if parsed_default != null:
               result[key] = parsed_default
            continue
         else:
            return VoyageError.new("Missing key in dictionary '%s'" % key)

      var value = data[key]
      if not type.validate(value):
         return VoyageError.new("Unexpected value type '%s' in key '%s'" % [str(value), str(key)])
      
      result[key] = value
   
   if should_passthrough:
      result.merge(data)

   return result

func passthrough():
   should_passthrough = true
   return self
func partial():
   for key in _types:
      var type = _types[key]
      _types[key] = type.optional()
   return self
