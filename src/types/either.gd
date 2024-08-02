class_name VoyageUnion
extends VoyageType

var _types: Array[VoyageType]

func _init(types: Array[VoyageType]):
   _types = types

func on_validate(data):
   for type in _types:
      if type.validate(data):
         return data
   return VoyageError.new("'%s' is not expected in the union type" % str(data))
