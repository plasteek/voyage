class_name VoyageLiteral
extends VoyageType

var _val

func _init(value):
   _val = value

func on_validate(data):
   if not typeof(data) == typeof(_val):
      return VoyageError.new("'%s' does not match '%s'" % [data, _val])
   if data != _val:
      return VoyageError.new("'%s' does not equal '%s'" % [data, _val])
   return data
