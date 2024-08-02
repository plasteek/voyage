class_name VoyageTuple
extends VoyageType

var _types: Array[VoyageType]
var _rest = null

func _init(tuple_shape: Array[VoyageType]):
   _types = tuple_shape

func on_validate(data):
   if typeof(data) != TYPE_ARRAY:
      return VoyageError.new("'%s' is not a valid tuple type" % str(data))
   
   if data.size() != _types.size() and _rest == null:
      return VoyageError.new("'%s' has a mismatch tuple length" % str(data))
   
   for index in range(0, data.size()):
      var tuple_data = data[index]
      var type = _types[index] if index < _types.size() else _rest

      # If validation failed
      if not type.validate(tuple_data):
         return VoyageError.new("Tuple '%s' at index %d does not match the expected tuple type" % [data, index])

   return data

func rest(type: VoyageType):
   _rest = type
   return self