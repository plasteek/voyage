class_name VoyageOptional
extends VoyageType

var _type: VoyageType
var _default = null

func _init(type: VoyageType):
   _type = type

func on_validate(data):
   if data == null:
      return _default
   return _type.on_validate(data)

func default(value):
   if value != null:
      _default = _type.parse(value)
   return self
