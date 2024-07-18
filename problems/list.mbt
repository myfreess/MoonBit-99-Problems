enum List[T] {
  // @immut/list.List[T]
  Nil
  Cons(T, List[T])
} derive(Debug, Eq)

fn List::of[T](arr : FixedArray[T]) -> List[T] {
  arr.fold_right(
    fn (acc, x) { Cons(x, acc) },
    init = Nil
  )
}

fn output[T : Show](self : List[T], logger : Logger) -> Unit {
  // dummy
}

fn to_string[T : Show](self : List[T]) -> String {
  let buf = Buffer::new(size_hint = 42)
  buf.write_char('(')
  loop self {
    Nil           => ()
    Cons(x, Nil)  => buf.write_string(x.to_string())
    Cons(x, rest) => {
      buf.write_string(x.to_string())
      buf.write_char(' ')
      continue rest
    }
  }
  buf.write_char(')')
  return buf.to_string()
}

test "convert array to lisp style list" {
  inspect(
    of([1, 2, 3]),
    content = "(1 2 3)"
  )!
  inspect(
    of([1]),
    content = "(1)"
  )!
  inspect(
    of([]),
    content = "()"
  )!
  inspect(
    of([42, 41, 40]),
    content = "(42 41 40)"
  )!
}


fn reverse[T](self : List[T]) -> List[T] {
  loop self, Nil {
    Nil, acc => acc
    Cons(x, rest), acc => continue rest, Cons(x, acc)
  }
}

test "reverse list" {
  @test.eq(
    of([1, 2, 3]),
    of([3, 2, 1]).reverse()
  )!
  @test.eq(
    of([]),
    of([]).reverse()
  )!
  @test.eq(
    of([42, 41, 40]),
    of([40, 41, 42]).reverse()
  )!
}