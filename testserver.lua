package.path = "./?.lua"
lram = require "lram"

lram.file("file1.txt", "blah blah blah", true)

print(lram.read("file1.txt"))

print(lram.remove("file1.txt"))

lram.folder("folder1")
lram.file("folder/test.txt", "bb2")

print(lram.read("folder/test.txt"))

io.read()

--[[

file1
folder1
 file1
 folder2
  file3556

]]