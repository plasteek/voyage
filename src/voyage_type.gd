class_name VoyageType
extends RefCounted

# Base class for validator

func on_validate(data):
   # Return data if the data is valid
   # Return VoyageError for error
   push_error("[ERROR] Unimplemented validation function")

func parse(data):
   var result = on_validate(data)
   if result is VoyageError:
      push_error(result.message)
      return null
   return result

func validate(data) -> bool:
   return not on_validate(data) is VoyageError

func array():
   return VoyageArray.new(self)
   
func optional():
   return VoyageOptional.new(self)
