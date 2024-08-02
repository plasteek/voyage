class_name VoyageString
extends VoyageType

var config := {}

func _init():
   config = {
      "min_len": 0,
      "max_len": INF,
      "regex": null
   }

func on_validate(data):
   if typeof(data) != TYPE_STRING:
      return VoyageError.new("'%s' is not of type string" % data)
   
   if data.length() > config.max_len:
      return VoyageError.new("'%s' length s more less than %d characters" % [data, config.max_len])
   
   if data.length() < config.min_len:
      return VoyageError.new("'%s' length is less than %d characters" % [data, config.min_len])

   if config.regex != null:
      var r = RegEx.new()
      r.compile(config.regex)

      if r.search(data) == null:
         return VoyageError.new("'%s' does not match the pattern '%s'" % [data, config.regex])

   return data

func min(size := 0):
   config.min_len = size
   return self

func max(size := INF):
   config.max_len = size
   return self

func range(min_len := 0, max_len := INF):
   min(min_len)
   max(max_len)
   return self

func length(len := 10):
   range(len, len)
   return self

func regex(pattern: String):
   config.regex = pattern
   return self