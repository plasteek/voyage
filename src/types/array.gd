class_name VoyageArray
extends VoyageType

var _type: VoyageType

func _init(type: VoyageType):
   _type = type

func on_validate(data):
   if typeof(data) != TYPE_ARRAY:
      return VoyageError.new("%s is not an array" % data)

   for item_index in range(data.size()):
      var item = data[item_index]
      var result = _type.on_validate(item)

      if result is VoyageError:
         return VoyageError.new("%s is not consistent with its array of %s" % [str(item), str(data)])
      data[item_index] = result

   return data
