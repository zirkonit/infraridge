# infraridge
Toy project; cash register change calculator in different languages

## Ruby
Ruby source, running under JRuby as well, is the original version, tested, commented and handling I/O.
`ruby Ruby/main.rb` runs the REPL that supports the commands written in the original spec (`help` can help), `rspec Ruby/test/rb` runs the test suite.

## Scala
Scala source is an _almost_ line-for-line port of the Ruby version. The only Scala-specific feature is use of Options for the recursive change calculator.
`sbt test` in Scala directory runs the test suite.

## TODOs
Many forms of malformed input are not caught correctly and would provide uncaught exceptions in both implementations. This remains to be fixed.
