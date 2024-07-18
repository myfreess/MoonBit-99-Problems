fn table(op : (Bool, Bool) -> Bool) -> Array[(Bool, Bool, Bool)] {
  let res = Array::new(capacity = 4)
  res.push((true, true, op(true, true)))
  res.push((false, false, op(false, false)))
  res.push((true, false, op(true, false)))
  res.push((false, true, op(false, true)))
  return res
}

test "truth table" {
  inspect(
    table(fn (x, y) { x && (x || y) }),
    content = "[(true, true, true), (false, false, false), (true, false, true), (false, true, false)]"
  )!
}