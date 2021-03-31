
# Package

version       = "0.1.1"
author        = "Marcelo Módolo <marcelo.rmodolo@gmail.com>"
description   = "Alguns testes."
license       = "MIT"
srcDir        = "src"
bin           = @["main"] # will be overwritten by the command below
namedBin      = {"main": "./build/main"}.toTable()


# Dependencies

requires "nim >= 0.19.0"


task build, "make":
  withDir "src":
    exec "nim c -o:../build/main -r main.nim"

task run, "nimble run":
  withDir "build":
    exec "./main"

#task test, "Run all tests":
#  withDir "test":
#    exec r"nim c -r test_escape"
