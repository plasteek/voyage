class_name VoyageDictionary
extends VoyageType

var _key_type: VoyageType
var _value_type = VoyageType

func _init(key_type: VoyageType, value_type: VoyageType):
   _key_type = key_type
   _value_type = value_type

func on_validate(data):
   if typeof(data) != TYPE_DICTIONARY:
      return VoyageError.new("'%s' is not a dictionary" % data)

   for key in data:
      var value = data[key]

      if not _key_type.validate(key):
         return VoyageError.new("Unexpected key type '%s'" % [str(key)])
      if not _value_type.validate(value):
         return VoyageError.new("Unexpected value type '%s' in the key %s" % [str(value), str(key)])

   return data