import std/parseopt, tables, std/os, strformat
import elvis

proc parseParams*(): TableRef[string, string] = 
  let options = newTable[string, string]()
  var opt = initOptParser()
  for kind, key, val in opt.getopt():
    case kind
    of cmdEnd: break
    of cmdLongOption, cmdShortOption:
      case key
      of "branch", "b":
        options["branch"] = val
      of "file", "f":
        options["file"] = val
      else:
        discard
    else:
      discard
  return options

when isMainModule:
  let params = parseParams()
  var branch= params["branch"]
  let config = params.getOrDefault("file", getEnv("HOME") & "/.config/git_push_guard")
  echo &"{branch} {config}"




  
