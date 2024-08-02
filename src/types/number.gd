class_name VoyageNumber
extends VoyageType

var config := {}

func _init():
   config = {
      "gt": - INF,
      "lt": INF,
      "mult_of": null,
      "sign": null
   }

func on_validate(data):
   if not _is_number(data):
      return VoyageError.new("'%s' is not a valid number" % [str(data)])
   
   if data <= config.gt:
      return VoyageError.new("'%d' is less than %d" % [data, config.gt])
   
   if data >= config.lt:
      return VoyageError.new("'%d' is greater than %d" % [data, config.lt])
   
   if config.mult_of != null:
      if data % config.mult_of != 0:
         return VoyageError.new("'%d' is not a multiple of %d" % [data, config.mult_of])
      
   if config.sign != null:
      if config.sign == 1 and data < 0:
         return VoyageError.new("'%d' is a negative number but expect positive" % data)
      if config.sign == -1 and data > 0:
         return VoyageError.new("'%d' is a positive number but expect negative " % data)

   return data


func gt(max_val):
   config.gt = max_val
   return self

func gte(max_val):
   config.gt = max_val - 1
   return self

func lt(min_val):
   config.lt = min_val
   return self

func lte(min_val):
   config.lt = min_val + 1
   return self

func multiple_of(mult):
   if not _is_number(mult):
      push_error("%s it not a valid multiplier" % str(mult))
      return
   config.mult_of = mult
   return self

func positive():
   config.sign = 1
   return self

func negative():
   config.sign = -1
   return self

func _is_number(data):
   if typeof(data) != TYPE_INT and typeof(data) != TYPE_FLOAT:
      return false
   return true