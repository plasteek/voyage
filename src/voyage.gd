class_name v
extends RefCounted

# Simple schema validation for Godot 
# Note: should probably not at runtime

static func object(shape: Dictionary):
   return VoyageObject.new(shape)

static func dict(key_type: VoyageType, value_type: VoyageType):
   return VoyageDictionary.new(key_type, value_type)

static func string():
   return VoyageString.new()

static func number():
   return VoyageNumber.new()

static func tuple(tuple_shape: Array[VoyageType]):
   return VoyageTuple.new(tuple_shape)

static func literal(value):
   return VoyageLiteral.new(value)

static func either(types: Array[VoyageType]): # This is basically union
   return VoyageUnion.new(types)
